package com.hwfs.sc.scb.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 배치 Job 실행 결과를 관리하는 BatchExecRsltMngt Service Interface
 * - Job실행결과 조회/삭제
 * - Job실행상세결과 조회
 * 
 * @ClassName BatchExecRsltMngtService.java
 * @Description BatchExecRsltMngtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09    kksoo        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface BatchExecRsltMngtService {

	/**
	 * 이미 처리된(정지,종료,실패된) JOB 실행 결과 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectJobResultList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 현재 실행 중인 배치 Job 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectJobRunningList(Map<String, Object> mapParam) throws Exception;

	/**
	 * Job 실행결과 상세정보 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectJobResultDetailList(Map<String, Object> mapParam) throws Exception;

	/**
	 * Step 실행결과 상세정보 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectStepResultDetailList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 자기가 실행시킨 현재 실행 중인 배치 Job의 상태값을 얻는다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectAsyncRunningBatchStatus(Map<String, Object> mapParam) throws Exception;

	/**
	 * Step 실행 로그 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectJobResultStepLogList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 배치 Job 실행 결과 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - Delete만 존재한다.
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveJobResultList(DataSetMap list) throws Exception;
}
