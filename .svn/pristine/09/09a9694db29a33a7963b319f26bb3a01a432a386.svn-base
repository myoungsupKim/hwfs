package com.hwfs.fm.fmf.web;

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
import com.hwfs.fm.fmf.service.CloseMgntStatusService;


 /**
 * 마감관리현황(브랜드) 조회하는 CloseMgntStatus Controller
 * 
 * @ClassName CloseMgntStatusController.java
 * @Description CloseMgntStatusController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.03.10   ksm        최초생성
 * 
 * </pre>
 * @author ksm
 * @since 2022.03.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fmf/closeMgntStatus/")
public class CloseMgntStatusController extends DefaultController {
	
	/** CloseMgntStatusService Bean 생성 */
	@Resource(name = "/fm/fmf/closeMgntStatusService")
	private CloseMgntStatusService closeMgntStatusService;
	
	/**
	 * 마감관리현황(브랜드) 목록을 조회한다.
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
		
		//매입매출집계 을(를) 조회한다.
		RecordSet rs = closeMgntStatusService.selectList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 마감관리현황(브랜드) 브랜드유통 관리부서 목록을 조회한다.
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
	@RequestMapping("selectBrandTm.xdo")
	public ModelAndView selectBrandTm(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//브랜드유통 관리부서 목록을 조회한다.
		RecordSet rs = closeMgntStatusService.selectBrandTm(inVar);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_tm", rs);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 마감관리현황(브랜드)(을)를 Insert/Update/Delete 처리한다.
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
		DataSetMap parameter = param.get("ds_list");

		//매입매출집계을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = closeMgntStatusService.saveList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
