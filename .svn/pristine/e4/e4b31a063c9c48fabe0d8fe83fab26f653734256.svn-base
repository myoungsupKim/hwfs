package com.hwfs.sm.sar.web;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sm.sar.service.SuspenseReturnRequestService;


 /**
 * 가수금을 전환 신청하는 SuspenseReturnRequest Controller
 * 
 * @ClassName SuspenseReturnRequestController.java
 * @Description SuspenseReturnRequestController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 JUN
 * @since 2015.05.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sm/sar/suspenseReturnRequest/")
public class SuspenseReturnRequestController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SuspenseReturnRequestService Bean 생성 */
	@Resource(name = "/sm/sar/suspenseReturnRequestService")
	private SuspenseReturnRequestService suspenseReturnRequestService;
	
	/**
	 * 가수금 전환 신청 목록 EAI 호출.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectSuspenseInquery.xdo")
	public ModelAndView selectSuspenseInquery(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> inVar = param.get("ds_search").get(0);
		
		//가수금 전환 신청 목록 EAI 호출.
		List<Map<String, Object>> rs = suspenseReturnRequestService.selectSuspenseInquery(inVar);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 가수금 상세(히스토리) EAI 호출
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectSuspenseLogInquery.xdo")
	public ModelAndView selectSuspenseLogInquery(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> inVar = param.get("ds_search").get(0);

		// 가수금 상세(히스토리) EAI 호출
		List<Map<String, Object>> rs = suspenseReturnRequestService.selectSuspenseLogInquery(inVar);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 가수금 전환신청 EAI 호출
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
//	@SuppressWarnings("unchecked")
	@RequestMapping("processSuspenseAltRequest.xdo")
	public ModelAndView processSuspenseAltRequest(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		// 조회 조건 파라미터를 얻는다.
//		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
//		Map<String, Object> inVar = param.get("ds_search").get(0);

		// 가수금 전환신청 EAI 호출
//		Map<String, Object> rs = suspenseReturnRequestService.processSuspenseAltRequest(inVar);
		String processCd = suspenseReturnRequestService.processSuspenseAltRequest(inVar, parameter);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCd", processCd);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		
		
		// XPlatform으로 넘겨줄 Dataset을 설정한다.
//		super.addOutDataSet(mav, "ds_list", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
//		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 가수금 전환취소신청 EAI 호출
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
//	@SuppressWarnings("unchecked")
	@RequestMapping("processCancelSuspenseAltRequest.xdo")
	public ModelAndView processCancelSuspenseAltRequest(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//logger.debug("test");
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		
		//logger.debug("test222");
		
		
		// 가수금 전환신청 EAI 호출
//		Map<String, Object> rs = suspenseReturnRequestService.processSuspenseAltRequest(inVar);
		String processCd = suspenseReturnRequestService.processCancelSuspenseAltRequest(inVar, parameter);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCd", processCd);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		
		
		// XPlatform으로 넘겨줄 Dataset을 설정한다.
//		super.addOutDataSet(mav, "ds_list", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
//		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 가수금 전환결과 EAI 호출.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectSuspenseAltRequest.xdo")
	public ModelAndView selectSuspenseAltRequest(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> inVar = param.get("ds_search").get(0);
		
		//가수금 전환 신청 목록 EAI 호출.
		List<Map<String, Object>> rs = suspenseReturnRequestService.selectSuspenseAltRequest(inVar);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
