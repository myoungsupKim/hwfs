package com.hwfs.fm.fms.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fm.fms.service.ExceptionBrandItemMgntService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 발주제한상품관리(브랜드) 등록하는 ExceptionBrandItemMgnt Controller
 * 
 * @ClassName ExceptionBrandItemMgntController.java
 * @Description ExceptionBrandItemMgntController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.10.24    hye.jin94        최초생성
 * </pre>
 * @author Jaey
 * @since 2021.07.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fms/exceptionBrandItemMgnt/")
public class ExceptionBrandItemMgntController extends DefaultController {
	
	/** ExceptionBrandItemMgntService Bean 생성 */
	@Resource(name = "/fm/fms/exceptionBrandItemMgntService")
	private ExceptionBrandItemMgntService exceptionBrandItemMgntService;

	/**
	 *  브랜드 업장목록 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectUpjangList.xdo")
	public ModelAndView selectUpjangList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);

		//행사거래처관리 조회
		RecordSet rs = exceptionBrandItemMgntService.selectUpjangList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_upjangList", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	

	/**
	 *  발주제한상품 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectItemList.xdo")
	public ModelAndView selectItemList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//행사상품관리 조회
		RecordSet rs = exceptionBrandItemMgntService.selectItemList(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_itemList", rs);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	/**
	 * 행사그룹관리 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectEventList.xdo")
	public ModelAndView selectEventList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);

		//행사그룹관리 조회
		RecordSet rs = exceptionBrandItemMgntService.selectEventList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_eventList", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 행사그룹관리 등록(을)를 Insert/Update/Delete 처리
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveEventInfo.xdo")
	public ModelAndView saveEventInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_eventList");

		//행사그룹관리을(를) 등록, 수정  처리
		int processCnt = exceptionBrandItemMgntService.saveEventInfo(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 행사거래처관리 등록(을)를 Insert/Update/Delete 처리
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveUpjangInfo.xdo")
	public ModelAndView saveUpjangInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_upjangList");

		//행사거래처관리을(를) 등록, 수정  처리
		int processCnt = exceptionBrandItemMgntService.saveUpjangInfo(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	/**
	 * 행사거래처관리엑셀 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("selectUpjangListExcel.xdo")
	public ModelAndView selectUpjangListExcel(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_upjangListExcel");
		
		//행사거래처관리엑셀 조회		
		Map<String, Object> rtnMap = exceptionBrandItemMgntService.selectUpjangListExcel(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_upjangList", rtnMap.get("upjangList"));
				
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	
	
	/**
	 * 상품관리 등록(을)를 Insert/Update/Delete 처리
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveItemInfo.xdo")
	public ModelAndView saveItemInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_itemList");
		
		//행사상품관리을(를) 등록, 수정  처리
		int processCnt = exceptionBrandItemMgntService.saveItemInfo(parameter);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	
	/**
	 * 발주제한상품 삭제처리
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("deleteExceptionItem.xdo")
	public ModelAndView deleteEventItem(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_itemList");
		
		//선택한 행사거래처를 삭제한다.
		int processCnt = exceptionBrandItemMgntService.deleteExceptionItem(parameter, loginDTO);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 발주제한상품관리 엑셀 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("selectItemListExcel.xdo")
	public ModelAndView selectItemListExcel(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_itemListExcel");
		
		//행사상품관리엑셀 조회		
		Map<String, Object> rtnMap = exceptionBrandItemMgntService.selectItemListExcel(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_itemList", rtnMap.get("itemList"));
				
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}		
	
	
	
	
	
	
	/**
	 *  행사이력 조회
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectEventHistList.xdo")
	public ModelAndView selectEventHistList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//행사이력 조회
		RecordSet rs1 = exceptionBrandItemMgntService.selectEventHistList(parameter);
		RecordSet rs2 = exceptionBrandItemMgntService.selectEventUpjangHistList(parameter);
		RecordSet rs3 = exceptionBrandItemMgntService.selectEventItemHistList(parameter); 
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_eventHistList", rs1);
		super.addOutDataSet(mav, "ds_upjangHistList", rs2);
		super.addOutDataSet(mav, "ds_itemHistList", rs3);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 행사그룹관리 삭제처리
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("deleteEventGroup.xdo")
	public ModelAndView deleteEventGroup(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_eventList");
		
		//선택한 행사그룹의 행사거래처와 행사자재를 삭제한다.
		int processCnt = exceptionBrandItemMgntService.deleteEventGroup(parameter, loginDTO);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 행사거래처관리 삭제처리
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("deleteEventUpjang.xdo")
	public ModelAndView deleteEventUpjang(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_upjangList");
		
		//선택한 행사거래처를 삭제한다.
		int processCnt = exceptionBrandItemMgntService.deleteEventUpjang(parameter, loginDTO);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
}
