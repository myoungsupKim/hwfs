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
import com.hwfs.fm.fms.service.StrategyGainRateItemRegService;


 /**
 * 전략이익률 자재를 등록 하는 StrategyGainRateItemReg Controller
 * 
 * @ClassName StrategyGainRateItemRegController.java
 * @Description StrategyGainRateItemRegController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최성연
 * @since 2015.05.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fms/strategyGainRateItemReg/")
public class StrategyGainRateItemRegController extends DefaultController {
	
	/** StrategyGainRateItemRegService Bean 생성 */
	@Resource(name = "/fm/fms/strategyGainRateItemRegService")
	private StrategyGainRateItemRegService strategyGainRateItemRegService;
	
	/**
	 * 전략이익률 자재  목록을 조회한다.
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
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();

		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//전략이익률 자재  을(를) 조회한다.
		RecordSet rs = strategyGainRateItemRegService.selectList(parameter);

		//전략이익률 자재  생성일자를 조회한다
		RecordSet rs1 = strategyGainRateItemRegService.selectDate(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);
		super.addOutDataSet(mav, "ds_date", rs1);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 전략이익률 자재 (을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * 1 Transaction
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
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//판매그룹을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = strategyGainRateItemRegService.saveList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	/**
	 * 전략이익률 자재 (을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * N Transaction
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
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {
		String saveFlag = "";
		int deleteCnt = 0;

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_saveRow");
		Map<String, Object> parameter1 = param.get("ds_saveRow").get(0);

		saveFlag = parameter1.get("saveFlag").toString();
		
		try {
				//전략이익율(를) 등록, 수정, 삭제 처리한다.
				int processCnt = strategyGainRateItemRegService.saveList2(parameter);

				//처리건수를 OutVariable에 설정한다.
				super.addOutVariable(mav, "fv_processCnt", processCnt);
		
    		} catch (Exception e) {
    			// 에러발생 시 생성된 정보는 모두 삭제
				if ("I".equals(saveFlag)) {
					deleteCnt = strategyGainRateItemRegService.deleteAll(parameter);
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
	 * 전략이익률 자재 (을)를 일괄 Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("deleteList.xdo")
	public ModelAndView deleteList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_search");

		//판매그룹을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = strategyGainRateItemRegService.deleteList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 매출처업장 업데이트 리스트를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("upjangList.xdo")
	public ModelAndView upjangList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();

		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//전략이익률 자재  을(를) 조회한다.
		RecordSet rs = strategyGainRateItemRegService.upjangList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	
	/**
	 * 매출처업장 항목을 Update 처리한다.
	 * <pre>
	 * 1 Transaction
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("upjangMig.xdo")
	public ModelAndView upjangMig(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//판매그룹을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = strategyGainRateItemRegService.upjangMig(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	
}
