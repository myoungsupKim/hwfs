package com.hwfs.guide.sample.web;

import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.batch.defaults.DefaultBatchController;
import com.hwfs.batch.launch.BatchRunner;
import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;

/**
 * Batch Job 실행 Sample Controller
 * @ClassName BatchRunSampleController.java
 * @Description BatchRunSampleController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 19.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 19.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
public class BatchRunSampleController extends DefaultBatchController {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** Sample Service Bean 생성 */
	//@Resource(name = "/guide/sample/xpsampleService")
	//private XpSampleService xpsampleService;

	
	/**
	 * 등록된 배치목록을 화면에 표시한다.
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/guide/sample/batchList.do", method = RequestMethod.GET)
    public String getBatchList(ModelMap model){

		model.addAttribute("jobList",getJobList());

		return "guide/sample/BatchList";
	}
	
	/**
	 * 선택한 배치를 실행시킨다.
	 * @param jobName
	 * @param model
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/guide/sample/batchRun.do", method = RequestMethod.POST)
    public String batchRun(@RequestParam(value = "jobName", required = false) String jobName, Model model, HttpServletRequest req ) throws Exception {
		//String strDesc = xpsampleService.getBeanDefinition(jobName);

		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);
		
		if (loginDTO == null) {
			loginDTO = new LoginDTO();
			loginDTO.setUserid("unknown");
		}
		

		Map<String, Object> batchRunInfo = super.batchRunSync(jobName, getUniqueJobParameters(jobName, true), loginDTO.getSabun());
		
		setBatchRunInfo (model, batchRunInfo);
			
		return "guide/sample/BatchRunResult";
	}

	/**
	 * 고정길이 파일을 DB에 저장하는 예 (Sync 처리)
	 *
	 * @param xpDto
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/guide/sample/runBatchFileToDB.xdo")
    public ModelAndView runBatchFileToDB (XplatformMapDTO xpDto, HttpServletRequest req) throws Exception{
		String jobName = "fixedLengthToJdbcJob";
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();

		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		//배치를 실행시킨다.
		Map<String, Object> batchRunInfo = super.batchRunSync(jobName, getUniqueJobParameters(jobName, true), loginDTO.getSabun());
		
		logger.debug ("runBatchFileToDB={}", batchRunInfo);
		
		//실행결과를 확인한다.
		if (successBatch (batchRunInfo))
			return setResultSet (mav, DefaultConsts.OK_CODE, "");
		else
			return setResultSet (mav, DefaultConsts.ERR_CODE, getBatchErrMsg(batchRunInfo));
	}

	/**
	 * DB 데이터를 고정길이 파일로 저장하는 예 (Sync 처리)
	 *
	 * @param xpDto
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/guide/sample/runBatchDBToFile.xdo")
    public ModelAndView runBatchDBToFile (XplatformMapDTO xpDto, HttpServletRequest req) throws Exception{
		String jobName = "dbioToFixedLengthJob";
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();

		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		//배치를 실행시킨다.
		Map<String, Object> batchRunInfo = super.batchRunSync(jobName, getUniqueJobParameters(jobName, true), loginDTO.getSabun());
		
		logger.debug ("runBatchDBToFile={}", batchRunInfo);
		
		//실행결과를 확인한다.
		if (successBatch (batchRunInfo))
			return setResultSet (mav, DefaultConsts.OK_CODE, "");
		else
			return setResultSet (mav, DefaultConsts.ERR_CODE, getBatchErrMsg(batchRunInfo));
	}

	/**
	 * FixedLength File에 한글이 있는 경우는 byte 단위로 처리해야 정확하게 처리된다. 이에 대한 예 (Sync 처리)
	 *
	 * @param xpDto
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/guide/sample/runBatchFileToFile.xdo")
    public ModelAndView runBatchFileToFile (XplatformMapDTO xpDto, HttpServletRequest req) throws Exception{
		String jobName = "fixedLengthToFixedLengthAnsiJob";
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();

		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		//Sync 배치를 실행시킨다.
		Map<String, Object> batchRunInfo = super.batchRunSync(jobName, getUniqueJobParameters(jobName, true), loginDTO.getSabun());
		
		logger.debug ("runBatchFileToFile={}", batchRunInfo);
		
		//실행결과를 확인한다.
		if (successBatch (batchRunInfo))
			return setResultSet (mav, DefaultConsts.OK_CODE, "");
		else
			return setResultSet (mav, DefaultConsts.ERR_CODE, getBatchErrMsg(batchRunInfo));
	}

	/**
	 * 구분자가 있는 파일을 읽어 파일로 처리하는 예 (Async 처리)
	 *
	 * @param xpDto
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/guide/sample/runBatchFileToFileAsync.xdo")
    public ModelAndView runBatchFileToFileAsync (XplatformMapDTO xpDto, HttpServletRequest req) throws Exception{
		String jobName = "delimitedToDelimitedJob";
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();

		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		//Async 배치를 실행시킨다.
		Map<String, Object> batchRunInfo = super.batchRunAsync(jobName, getUniqueJobParameters(jobName, false), loginDTO.getSabun());
		
		logger.debug ("runBatchFileToFileAsync={}", batchRunInfo);
		
		//Async는 우선 결과를 반환하고 실행결과는 별도 처리로 확인한다.
		return setResultSet (mav, DefaultConsts.OK_CODE, getBatchRunningMsg());
	}

	/**
	 * DB to DB 처리 예(Async 처리)
	 * 
	 * @param xpDto
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/guide/sample/runBatchDBToDB.xdo")
    public ModelAndView runBatchDBToDB (XplatformMapDTO xpDto, HttpServletRequest req) throws Exception{
		String jobName = "dbioToDbioJob";
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();

		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		//배치를 실행시킨다.
		Map<String, Object> batchRunInfo = super.batchRunAsync(jobName, getUniqueJobParameters(jobName, false), loginDTO.getSabun());
		
		logger.debug ("runBatchDBToDB={}", batchRunInfo);
		
		//실행결과를 확인한다.
		if (successBatch (batchRunInfo))
			return setResultSet (mav, DefaultConsts.OK_CODE, "");
		else
			return setResultSet (mav, DefaultConsts.ERR_CODE, getBatchErrMsg(batchRunInfo));
	}

	//임시 개발을 위한 테스트용
	protected String getUniqueJobParameters(String jobName, boolean isSync) {		
		BatchRunner batchRunner = getBatchRunner (isSync);
		String paramters = batchRunner.createUniqueJobParameters();

		String strInputPath = propertiesService.getString("global.batch.input.path") + "/";		// Batch Input File Root
		String strOutputPath = propertiesService.getString("global.batch.output.path") + "/";	// Batch Output File Root
		
		if ("delimitedToDelimitedJob".equals(jobName)) {
			paramters = batchRunner.addJobParameter(paramters, "inputFile", "file:" + strInputPath + "csvData.csv");
			paramters = batchRunner.addJobParameter(paramters, "outputFile", "file:" + strOutputPath + "csvOutput.csv");
		}else if ("fixedLengthToFixedLengthJob".equals(jobName)) {
			paramters = batchRunner.addJobParameter(paramters, "inputFile", "file:" + strInputPath + "txtData.txt");
			paramters = batchRunner.addJobParameter(paramters, "outputFile", "file:" + strOutputPath + "txtOutput.txt");
		}else if ("fixedLengthToFixedLengthAnsiJob".equals(jobName)) {
			paramters = batchRunner.addJobParameter(paramters, "inputFile", "file:" + strInputPath + "GTPAID");
			paramters = batchRunner.addJobParameter(paramters, "outputFile", "file:" + strOutputPath + "GTPAID");
		}else if ("fixedLengthToIbatisJob".equals(jobName) || "fixedLengthToJdbcJob".equals(jobName)) {
			paramters = batchRunner.addJobParameter(paramters, "inputFile", "file:" + strInputPath + "txtData.txt");
		}else if ("jdbcToFixedLengthJob".equals(jobName) || "dbioToFixedLengthJob".equals(jobName)) {			
			paramters = batchRunner.addJobParameter(paramters, "outputFile", "file:" + strOutputPath + "txtOutput.txt");
		}else if ("ibatisToDelimitedJob".equals(jobName)) {			
			paramters = batchRunner.addJobParameter(paramters, "outputFile", "file:" + strOutputPath + "csvOutput.csv");
		}else if ("simpleTaskletJob".equals(jobName)) {
			paramters = batchRunner.addJobParameter(paramters, "value", "abce가나다라...");
		}
//		else if ("dbioToDbioParallelJob".equals(jobName)) {
//			//parametersValues 설정
//			//paramters = batchRunner.addJobParameter(paramters, "parameterValues.fromId", "30");
//		}

		return paramters;
	}

}
