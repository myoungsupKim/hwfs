package com.hwfs.sc.scb.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 배치 Job 실행 결과를 관리하는 BatchExecRsltMngt DAO
 * 
 * @ClassName BatchExecRsltMngtDAO.java
 * @Description BatchExecRsltMngtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scb/batchExecRsltMngtDAO")
public class BatchExecRsltMngtDAO extends DefaultDAO {
	
	/**
	 * 이미 처리된(정지,종료,실패된) JOB 실행 결과 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectJobResultList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scb.batchExecRsltMngtDAO.selectJobResultList", mapParam);
	}

	/**
	 * 현재 실행 중인 배치 Job 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectJobRunningList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scb.batchExecRsltMngtDAO.selectJobRunningList", mapParam);
	}

	/**
	 * Job 실행결과 상세정보 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet selectJobResultDetailList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scb.batchExecRsltMngtDAO.selectJobResultDetailList", mapParam);
	}

	/**
	 * Step 실행결과 상세정보 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet selectStepResultDetailList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scb.batchExecRsltMngtDAO.selectStepResultDetailList", mapParam);
	}

	/**
	 * 자기가 실행시킨 현재 실행 중인 배치 Job의 상태값을 얻는다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet selectAsyncRunningBatchStatus(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scb.batchExecRsltMngtDAO.selectAsyncRunningBatchStatus", mapParam);
	}

	/**
	 * Step 실행 로그 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet selectJobResultStepLogList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scb.batchExecRsltMngtDAO.selectJobResultStepLogList", mapParam);
	}

	/**
	 * 배치 Job 실행 결과(을)를 삭제한다.
	 * <pre>
	 * - JOB_EXECUTION_ID를 이용하여 Job Execution & Context, Step Execution & Context, Job Instance & Job Params, SP Execution 정보를 모두 삭제한다.
	 * - FK 설정으로 자식 테이블부터 삭제한다.
	 * </pre>
	 * @param mapParam
	 * @return
	 */
	public int deleteJobResult(Map<String, Object> mapParam) throws Exception {
		//SP Execution
		super.update("sc.scb.batchExecRsltMngtDAO.deleteSpExecution", mapParam);

		//Step Execution & Context
		super.update("sc.scb.batchExecRsltMngtDAO.deleteStepExecutionContext", mapParam);
		super.update("sc.scb.batchExecRsltMngtDAO.deleteStepExecution", mapParam);
		
		//Job Execution & Context
		super.update("sc.scb.batchExecRsltMngtDAO.deleteJobExecutionContext", mapParam);
		return super.update("sc.scb.batchExecRsltMngtDAO.deleteJobExecution", mapParam);

		//Job Instance를 Job Execution에서 재사용하므로 삭제 시 FK Constraint 발생  
		//Job Instance & Job Params
		//super.update("executResultDAO.deleteJobParams", mapParam);
		//super.update("executResultDAO.deleteJobInstance", mapParam);
	}
	
}
