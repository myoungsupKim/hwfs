package com.hwfs.sc.scb.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.batch.defaults.DefaultBatchController;
import com.hwfs.batch.launch.BatchRunner;
import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.token.ValidationToken;
import com.hwfs.cmn.util.DTOUtil;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.scb.dto.JobExecDTO;
import com.hwfs.sc.scb.dto.JobInfoDTO;
import com.hwfs.sc.scb.service.BatchJobMngtService;
import com.tobesoft.xplatform.data.DataSet;


 /**
 * Job Repository에 작성된 Job Configuration을 DB에 등록 관리하고 온라인 Job을 실행/중지시키는 BatchJobMngt Controller
 * 
 * @ClassName BatchJobMngtController.java
 * @Description BatchJobMngtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.08    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 :  AA kksoo
 * @since 2015.04.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scb/batchJobMngt/")
public class BatchJobMngtController extends DefaultBatchController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** BatchJobMngtService Bean 생성 */
	@Resource(name = "/sc/scb/batchJobMngtService")
	private BatchJobMngtService batchJobMngtService;
	
	/**
	 * Job Repository와 DB에 현재 등록된 Job 정보 목록을 조회한다.
	 * <pre>
	 * - Repository에 등록된 Job Configuration 목록이 DB에 등록되었는지 여부를 조회한다.
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectJobInfoList.xdo")
	public ModelAndView selectJobInfoList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//Job Repository와 DB에 현재 등록된 Job 정보 을(를) 조회한다.
		List<JobInfoDTO> jobList = batchJobMngtService.selectJobInfoList(getJobList(), inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", jobList);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * DB에 등록된 Job 정보 목록을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectDbJobList.xdo")
	public ModelAndView selectDbJobList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();
		
		//DB에 등록된 Job 정보 을(를) 조회한다.
		RecordSet jobList = batchJobMngtService.selectDbJobList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", jobList);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * Batch Job 정보를 DB에 Insert, Update, Delete 처리한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@ValidationToken
	@RequestMapping("saveJobList.xdo")
	public ModelAndView saveJobList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//Batch Job 정보를 DB에 등록, 수정, 삭제 처리한다.
		int processCnt = batchJobMngtService.saveJobList(parameter);

		logger.debug ("BatchJobMngtController.saveJobList processCnt={}", processCnt);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * Online Batch Job을 실행시킨다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@ValidationToken
	@RequestMapping("executeOnlineJob.xdo")
	public ModelAndView executeOnlineJob(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO
		  , HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		
		//배치실행정보 VO 생성
		JobExecDTO jobExecDTO = (JobExecDTO) DTOUtil.convertMapToVo(inVar, JobExecDTO.class);

		// Online Batch Job을 실행시킨다.
		Map<String, Object> batchRunInfo;
		if (jobExecDTO.getSyncYn() == null || jobExecDTO.getSyncYn().equals("0"))	//비동기
			batchRunInfo = super.batchRunAsync(jobExecDTO.getJobName(), getUniqueJobParameters(jobExecDTO, false), loginDTO.getSabun());
		else	//동기
			batchRunInfo = super.batchRunSync(jobExecDTO.getJobName(), getUniqueJobParameters(jobExecDTO, true), loginDTO.getSabun());
		
		logger.info ("BatchJobMngtController.executeOnlineJob batchRunInfo={}", batchRunInfo);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		if (successBatch (batchRunInfo))
			return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		else
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, getBatchErrMsg(batchRunInfo));
	}

	/**
	 * Job Configuration에 정의된 파라미터 파일을 설정한다.
	 * <pre> 
	 * - inputFile과 outputFile이 Job Configuration에 설정되어 있어야 한다.
	 * </pre>
	 *
	 * @param jobExecVO Job실행정보VO
	 * @param isSync 동기여부
	 * @return 설정된 파라미터 문자열
	 */
	private String getUniqueJobParameters(JobExecDTO jobExecDTO, boolean isSync) {		
		BatchRunner batchRunner = getBatchRunner (isSync);
		String paramters = batchRunner.createUniqueJobParameters();

		String strInputPath = propertiesService.getString("global.batch.input.path") + "/";		// Batch Input File Root
		String strOutputPath = propertiesService.getString("global.batch.output.path") + "/";	// Batch Output File Root
		
		if (jobExecDTO.getInputFile() != null && !jobExecDTO.getInputFile().equals(""))
			paramters = batchRunner.addJobParameter(paramters, "inputFile", "file:" + strInputPath + jobExecDTO.getInputFile());
		
		if (jobExecDTO.getOutputFile() != null && !jobExecDTO.getOutputFile().equals(""))
			paramters = batchRunner.addJobParameter(paramters, "outputFile", "file:" + strOutputPath + jobExecDTO.getOutputFile());

		return paramters;
	}

	/**
	 * Online Batch Job 실행을 중지시킨다.
	 * 
	 * @param xpDto XPlatformMapDTO
	 * @param req HttpServletRequest
	 * @return ModelAndView
	 * @throws Exception
	 */
	@ValidationToken
	@RequestMapping(value = "stopBatchJob.xdo")
	public ModelAndView stopBatchJob(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();

		Map<String, DataSetMap> inDataset = xpDTO.getInDataSetMap();

		// 처리할 데이터가 있는 DataSetMap을 얻는다.
		DataSetMap list = (DataSetMap) inDataset.get("ds_list");

		for (int i = 0; i < list.size(); i++) {
			@SuppressWarnings("unchecked")
			Map<String, Object> map = list.get(i);
			//ROW_TYPE_DELETED인건에 대해서 중지 처리
			int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if (rowType == DataSet.ROW_TYPE_DELETED) {
				boolean isSync = map.get("syncYn").equals("1") ? true : false;
				stopBatchJob (Long.parseLong(map.get("jobExecutionId").toString()), isSync);
				
				logger.info ("BatchJobMngtController.stopbatchJob {}", map);
			}
		}
			
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 중지시킨 Online Batch Job을 재실행한다.
	 * 
	 * @param xpDto XPlatformMapDTO
	 * @param req HttpServletRequest
	 * @return ModelAndView
	 * @throws Exception
	 */
	@ValidationToken
	@RequestMapping(value = "restartBatchJob.xdo")
	public ModelAndView restartBatchJob(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO
		  , HttpServletRequest req) throws Exception {
		
		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();

		Map<String, DataSetMap> inDataset = xpDTO.getInDataSetMap();

		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);

		// 처리할 데이터가 있는 DataSetMap을 얻는다.
		DataSetMap list = (DataSetMap) inDataset.get("ds_job");

		for (int i = 0; i < list.size(); i++) {
			Map map = list.get(i);
			boolean isSync = map.get("syncYn").equals("1") ? true : false;
			restartBatchJob (Long.parseLong(map.get("jobExecutionId").toString()), isSync, loginDTO.getSabun());
			
			logger.info ("BatchJobMngtController.restartBatchJob {}", map);
		}
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
