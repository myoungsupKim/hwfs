package com.hwfs.ft.ftr.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.ft.ftr.service.NonArrivinventoryService;


 /**
 * 미착 재고 조회하는 NonArrivinventory Controller
 * 
 * @ClassName NonArrivinventory.java
 * @Description NonArrivinventory Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.10.24   김명섭        최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2019.10.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ft/ftr/nonArrivinventory/")
public class NonArrivinventoryController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** NonArrivinventoryService Bean 생성 */
	@Resource(name = "/ft/ftr/nonArrivinventoryService")
	private NonArrivinventoryService nonArrivinventoryService;
	
	/**
	 * 미착 재고를 조회한다.
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
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		//수발주 스케쥴관리 을(를) 조회한다.
		RecordSet rs = nonArrivinventoryService.selectList(parameter.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	

	@RequestMapping("selectHist.xdo")
	public ModelAndView selectHist(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		//수발주 스케쥴관리 을(를) 조회한다.
		RecordSet rs = nonArrivinventoryService.selectHist(parameter.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
}
