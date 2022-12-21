package com.hwfs.sc.scb.web;

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
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.scb.service.BatchExecRsltMngtService;


 /**
 * 배치 Job 실행 결과를 관리하는 BatchExecRsltMngt Controller
 * - Job실행결과 조회/삭제
 * - Job실행상세결과 조회
 * 
 * @ClassName BatchExecRsltMngtController.java
 * @Description BatchExecRsltMngtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 :  AA kksoo
 * @since 2015.04.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scb/batchExecRsltMngt/")
public class BatchExecRsltMngtController extends DefaultController {
	
	/** BatchExecRsltMngtService Bean 생성 */
	@Resource(name = "/sc/scb/batchExecRsltMngtService")
	private BatchExecRsltMngtService batchExecRsltMngtService;
	
	/**
	 * 배치 Job 실행 결과 목록을 조회한다.
	 * <pre>
	 * - running가 없는 경우는 이미 처리된(정지,종료,실패된) JOB 실행 결과 목록을 조회한다.
	 * - running인 경우는 현재 실행 중인 배치 Job 목록을 조회한다.
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectJobResultList.xdo")
	public ModelAndView selectJobResultList (
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO
		  , HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		@SuppressWarnings("unchecked")
		Map<String, Object> searchMap = param.get("ds_search").get(0);
		
		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		
		//로그인 사용자 ID를 설정 : 자신이 실행시킨 Job을 조회하기 위해 필요
		searchMap.put ("executionUserId", loginDTO.getSabun());

		RecordSet rs;
		if (searchMap.containsKey("running") && searchMap.get("running").toString().equalsIgnoreCase("y"))
			//현재 실행 중인 배치 Job 목록을 조회한다.
			rs = batchExecRsltMngtService.selectJobRunningList(searchMap);
		else	
			//이미 처리된(정지,종료,실패된) JOB 실행 결과 목록을 조회한다.
			rs = batchExecRsltMngtService.selectJobResultList(searchMap);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * Job 실행 상세 결과를 조회한다.
	 * <pre>
	 * - Job Execution과 Step Execution 결과를 조회한다.
	 * </pre>
	 *
	 * @param xpDTO
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectJobResultDetailList.xdo")
	public ModelAndView selectJobResultDetailList (
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, Object> searchMap = xpDTO.getInVariableMap();
		
		//Job 실행결과 상세정보를 얻는다.
		RecordSet rsJob = batchExecRsltMngtService.selectJobResultDetailList(searchMap);
		
		//Step 실행결과 상세정보를 얻는다.
		RecordSet rsStep = batchExecRsltMngtService.selectStepResultDetailList(searchMap);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_job", rsJob);
		super.addOutDataSet(mav, "ds_list", rsStep);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 자기가 실행시킨 현재 실행 중인 배치 Job의 상태값을 얻는다.
	 *
	 * @param xpDTO
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectAsyncRunningBatchStatus.xdo")
	public ModelAndView selectAsyncRunningBatchStatus (
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO
		  , HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, Object> searchMap = xpDTO.getInVariableMap();
		
		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
					
		//로그인 사용자 ID를 설정 : 자신이 실행시킨 Job을 조회하기 위해 필요
		searchMap.put ("executionUserId", loginDTO.getSabun());
		
		//자기가 실행시킨 현재 실행 중인 배치 Job의 상태값을 얻는다.
		RecordSet rs = batchExecRsltMngtService.selectAsyncRunningBatchStatus(searchMap);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * Step 실행 로그 목록을 조회한다.
	 *
	 * @param xpDTO
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectJobResultStepLogList.xdo")
	public ModelAndView selectJobResultStepLogList (
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, Object> searchMap = xpDTO.getInVariableMap();
		
		//Step 실행 로그 목록을 얻는다.
		RecordSet rs = batchExecRsltMngtService.selectJobResultStepLogList(searchMap);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 배치 Job 실행 결과(을)를 DB에서 Delete 처리한다.
	 * <pre>
	 * - Delete만 존재한다.
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveJobResultList.xdo")
	public ModelAndView saveJobResultList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//배치 Job 실행 결과을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = batchExecRsltMngtService.saveJobResultList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
