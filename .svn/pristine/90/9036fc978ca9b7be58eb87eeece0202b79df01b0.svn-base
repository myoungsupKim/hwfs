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
import com.hwfs.fm.fms.service.SalePriceSimuService;


 /**
 * 판매가를 시뮬레이션하는 SalePriceSimu Controller
 * 
 * @ClassName SalePriceSimuController.java
 * @Description SalePriceSimuController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.29    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최성연
 * @since 2015.05.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fms/salePriceSimu/")
public class SalePriceSimuController extends DefaultController {
	
	/** SalePriceSimuService Bean 생성 */
	@Resource(name = "/fm/fms/salePriceSimuService")
	private SalePriceSimuService salePriceSimuService;

	
	/**
	 * 판매가 시뮬레이션 ID 를 조회한다.
	 * <pre>
	 * </pre>
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
		
		//판매가 시뮬레이션 ID 을(를) 조회한다.
		RecordSet rs = salePriceSimuService.selectSimu(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_simu", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 판매가 시뮬레이션 목록을 조회한다.
	 * <pre>
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
		
		//판매가 시뮬레이션 을(를) 조회한다.
		RecordSet rs = salePriceSimuService.selectList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 판매가 시뮬레이션(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> parameter1 = param.get("ds_list").get(0);
		DataSetMap parameter2 = param.get("ds_list");

		//시뮬레이션 ID Key값을 구한다
		RecordSet rs = salePriceSimuService.selectID(parameter1);
		
		//시뮬레이션 ID를 SET한다.
		String simuId = "";
		if (rs.size() > 0) {
			Map map = rs.get(0);
			if (map.get("simuId") != null)
				simuId =  map.get("simuId").toString(); //필드명이 "simuId"인 경우임
		}
		

		//판매가 시뮬레이션을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = salePriceSimuService.saveList(parameter2, simuId);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_simuId", simuId);
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 선택한 시뮬레이션 자료를 삭제한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("deleteSimu.xdo")
	public ModelAndView deleteSimu(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_search");

		//선택한 시뮬레이션 자료를 삭제 처리한다.
		int processCnt = salePriceSimuService.deleteSimu(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
		
	
	/**
	 * 시뮬레이션을 확인 처리한다.
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

		//시뮬레이션을 업장별로 확인 처리 한다.
		int processCnt = salePriceSimuService.saveConfirm(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	
}
