package com.hwfs.fs.fse.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.fs.fse.service.EventMasterListService;


 /**
 * 이벤트관리 현황조회하는 EventMasterList Controller
 * 
 * @ClassName EventMasterListController.java
 * @Description EventMasterListController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2020.20.22    JHKIM        최초생성
 * </pre>
 * @author  
 * @since 2020.20.22
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fse/eventMasterList/")
public class EventMasterListController extends DefaultController {

	/** EventMasterListService Bean 생성 */
	@Resource(name = "/fs/fse/eventMasterListService")
	private EventMasterListService eventMasterListService;
	
	/**
	 * 이벤트관리 현황조회 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
//		Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		//기물사용현황 을(를) 조회한다.
		RecordSet rsList01 = eventMasterListService.selectList01(parameter.get("ds_search").get(0));
		//팀업장별사용현황  을(를) 조회한다.
		RecordSet rsList02 = eventMasterListService.selectList02(parameter.get("ds_search").get(0));
		//기물만족도  을(를) 조회한다.
		RecordSet rsList03 = eventMasterListService.selectList03(parameter.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "dsList01Output", rsList01);
		super.addOutDataSet(mav, "dsList02Output", rsList02);
		super.addOutDataSet(mav, "dsList03Output", rsList03);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	
}
