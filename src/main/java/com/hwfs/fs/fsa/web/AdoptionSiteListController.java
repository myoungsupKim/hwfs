package com.hwfs.fs.fsa.web;

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
import com.hwfs.fs.fsa.service.AdoptionSiteListService;


 /**
 * 채용사이트관리하는 AdoptionSiteList Controller
 * 
 * @ClassName AdoptionSiteListController.java
 * @Description AdoptionSiteListController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.24    yanghj        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합엽업 yanghj
 * @since 2015.03.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsa/adoptionSiteList/")
public class AdoptionSiteListController extends DefaultController {

	/** AdoptionSiteListService Bean 생성 */
	@Resource(name = "/fs/fsa/adoptionSiteListService")
	private AdoptionSiteListService adoptionSiteListService;
	
	/**
	 * 채용사이트관리 목록을 조회한다.
	 * <pre>
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
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//채용사이트관리 을(를) 조회한다.
		RecordSet rs = adoptionSiteListService.selectList(param.get("ds_search").get(0));
		
		//개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수 accessLogService.readLog(inVar, rs.size());
		accessLogService.readLog(param.get("ds_search").get(0), rs.size());

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "dsList", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 채용사이트관리(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("dsList");
		
		//개인정보보호 접근로그를 쌓는다.
	    accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"TEL_NO, EMAIL"}));

		//채용사이트관리을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = adoptionSiteListService.saveList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		
		//채용사이트관리 을(를) 조회한다.
		RecordSet rs = adoptionSiteListService.selectList(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "dsList", rs);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
