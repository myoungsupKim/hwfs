package com.hwfs.fm.fms.web;

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
import com.hwfs.fm.fms.service.EstPaperWriteService;


 /**
 * 견적서를 작성하는 EstPaperWrite Controller
 * 
 * @ClassName EstPaperWriteController.java
 * @Description EstPaperWriteController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.28    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최성연
 * @since 2015.04.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fms/estPaperWrite/")
public class EstPaperWriteController extends DefaultController {
	
	/** EstPaperWriteService Bean 생성 */
	@Resource(name = "/fm/fms/estPaperWriteService")
	private EstPaperWriteService estPaperWriteService;
	
	/**
	 * 식재영업 담당자를 검색한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSabun.xdo")
	public ModelAndView selectSabun(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//견적서를 작성 을(를) 조회한다.
		RecordSet rs = estPaperWriteService.selectSabun(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	/**
	 * 견적서 작성을 위한 자재분류정보를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectClass.xdo")
	public ModelAndView selectClass(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//견적서를 작성 을(를) 조회한다.
		RecordSet rs = estPaperWriteService.selectClass(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_class", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

	/**
	 * 견적번호를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectEsti.xdo")
	public ModelAndView selectEsti(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//견적서를 작성 을(를) 조회한다.
		RecordSet rs = estPaperWriteService.selectEsti(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_esti", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	/**
	 * 견적서 목록을 조회한다.
	 * <pre>
	 * - schEstiId 가 "NEW"면 신규, 그외는 기존정보 조회
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
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//견적서를 작성 을(를) 조회한다.
		RecordSet rs = estPaperWriteService.selectList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	/**
	 * 유사시뮬레이션 목록을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSimu.xdo")
	public ModelAndView selectSimu(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//견적서를 작성 을(를) 조회한다.
		RecordSet rs = estPaperWriteService.selectSimu(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 유사시뮬레이션 관련 수량을 구한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSimQty.xdo")
	public ModelAndView selectSimQty(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_itemSimRow").get(0);
		
		//견적서를 작성 을(를) 조회한다.
		RecordSet rs = estPaperWriteService.selectSimQty(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_simQty", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	/**
	 * 평균시뮬레이션 관련 수량을 구한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectAvgQty.xdo")
	public ModelAndView selectAvgQty(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_itemSimRow").get(0);
		
		//견적서를 작성 을(를) 조회한다.
		RecordSet rs = estPaperWriteService.selectAvgQty(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_avgQty", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	/**
	 * 견적서를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 신규 및 재작성 시 저장을 처리 한다
	 *  1 Transaction 용
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> parameter1 = param.get("ds_list").get(0);
		DataSetMap parameter2 = param.get("ds_list");

		//견적서 ID Key값을 구한다
		RecordSet rs = estPaperWriteService.selectID(parameter1);
		
		//견적서 ID를 SET한다.
		String estiId = "";
		if (rs.size() > 0) {
			Map map = rs.get(0);
			if (map.get("estiId") != null)
				estiId =  map.get("estiId").toString(); //필드명이 "estiId"인 경우임
		}
		
		//System.out.println("estiId : " + estiId);
		
		//견적서 작성을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = estPaperWriteService.saveList(parameter2, estiId);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_estiId", estiId);
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

	/**
	 * 견적서를 Insert/Update/Delete 처리한다.
	 * <pre>
	 *  N Transaction 용
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList2.xdo")
	public ModelAndView saveList2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		int deleteCnt = 0;
		String estiId = "";
		String isFirst = "";
		String saveFlag = "";
		String estiId2 = "";
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_saveRow");
		Map<String, Object> parameter1 = param.get("ds_saveRow").get(0);

		isFirst = parameter1.get("isFirst").toString();
		saveFlag = parameter1.get("saveFlag").toString();
		estiId2 = parameter1.get("estiId2").toString();
		
		//System.out.println("estiId : " + estiId);

		// 신규작성 시	
		if ("I".equals(saveFlag)) {
				// 최초 저장하는 건에 대해서만 Key값을 가져온다 
				if ("Y".equals(isFirst)) {
				//견적서 ID Key값을 구한다
				RecordSet rs = estPaperWriteService.selectID(parameter1);
		
					//견적서 ID를 SET한다.
					if (rs.size() > 0) {
						Map map = rs.get(0);
						if (map.get("estiId") != null)
						estiId =  map.get("estiId").toString(); //필드명이 "estiId"인 경우임
					}
				} else {
					// 기 생성한 Key값을 복사
					estiId = estiId2;
				}
		}

		try {
			//견적서(를) 등록, 수정, 삭제 처리한다.
			int processCnt = estPaperWriteService.saveList2(parameter, estiId);

			// 생성건수가 0 이면 관련 견적서를 모두 삭제한다 :오류 발생시
 			if (processCnt==0) {    		
 				if ("I".equals(saveFlag)) {
 					deleteCnt = estPaperWriteService.deleteEst(parameter, estiId);
 				}
 				
				super.addOutVariable(mav, "fv_errorFlag", "Y");
				super.addOutVariable(mav, "fv_errorMsg", "견적서 생성 오류");
			}
			
 			//처리건수를 OutVariable에 설정한다.
 			super.addOutVariable(mav, "fv_estiId", estiId);
			super.addOutVariable(mav, "fv_processCnt", processCnt);

    	} catch (Exception e) {
    		// 에러발생 시 생성된 견적서정보는 모두 삭제
				if ("I".equals(saveFlag)) {
					deleteCnt = estPaperWriteService.deleteEst(parameter, estiId);
				}
				
				super.addOutVariable(mav, "fv_errorFlag", "Y");
				super.addOutVariable(mav, "fv_errorMsg", e.getMessage());
    		
    		// 에러 발생 시 에러메시지를 화면에 표시하지 않음
    		return super.setResultSet(mav, -100, e.getMessage());
    	}
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	
	/**
	 * 견적서 선택한 자재를 삭제한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("deleteItem.xdo")
	public ModelAndView deleteItem(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_deleteItem");

		//견적서의 선택한 자재를 삭제 처리한다.
		int processCnt = estPaperWriteService.deleteItem(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

	/**
	 * 견적서를 확인 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveConfirm.xdo")
	public ModelAndView saveConfirm(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//견적서를 자재별로 확인 처리 한다.
		int processCnt = estPaperWriteService.saveConfirm(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
}
