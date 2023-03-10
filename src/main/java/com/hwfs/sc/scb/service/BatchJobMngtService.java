package com.hwfs.sc.scb.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.hwfs.sc.scb.dto.JobExecDTO;
import com.hwfs.sc.scb.dto.JobInfoDTO;

 /**
 * Job Repository에 작성된 Job Configuration을 DB에 등록 관리하고 온라인 Job을 실행시키는 BatchJobMngt Service Interface
 * (주의) HWFS CMN Batch Framework에서 사용하는 updateOnlineExecJobInfo 메소드를 구현해야 한다.
 * 
 * @ClassName BatchJobMngtService.java
 * @Description BatchJobMngtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.08    kksoo        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface BatchJobMngtService {

	/**
	 * Job Repository와 DB에 현재 등록된 Job 정보 목록을 조회한다.
	 * <pre>
	 * - Job Repository에 저장된 Job Configuration 파일과 DB에 등록된 Job 정보를 비교하여 생성한다.
	 * - ynRgst에 DB에 등록된 Job인지 여부를 설정한다. ("1"인 경우는 DB에 등록된 Job)
	 * </pre>
	 *
	 * @param jobList
	 *            Job Repository에 저장된 Job 목록
	 * @param mapParam
	 *            조회조건 Map
	 * @return List<JobInfoDTO> 
	 *            조회결과
	 * @throws Exception
	 */
	List<JobInfoDTO> selectJobInfoList (Set<String> jobList, Map <String, Object> mapParam) throws Exception;

	/**
	 * DB에 등록된 Job 정보 목록을 조회한다.
	 *
	 * @param jobList
	 *            DB에 저장된 Job 목록
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectDbJobList (Map<String, Object> mapParam) throws Exception;

	/**
	 * Job 정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveJobList(DataSetMap list) throws Exception;
	
	/**
	 * Online Batch Job 실행 정보를 Update 처리한다.
	 * <pre>
	 * - HWFS CMN Batch Framework에서 사용하는 메소드로 이를 구현해야 한다.
	 * </pre>
	 * 
	 * @param jobExecDTO
	 *            JobExecVO Job 실행정보DTO
	 * @return int 처리건수
	 * @throws Exception
	 */
	public int updateOnlineExecJobInfo(JobExecDTO jobExecDTO) throws Exception;
	
	
	/**
	 * 주문 수동배치 정보를 reset한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return rtnMap
	 *                processCnt    처리건수
	 *                listDupCheck  중복data
	 * @throws Exception
	*/
	public int updateHubInterfaceManual(Map<String, Object> list) throws Exception;
	
	/**
	 * 주문 수동배치 정보를 저장한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return rtnMap
	 *                processCnt    처리건수
	 *                listDupCheck  중복data
	 * @throws Exception
	*/
	public int saveHubInterfaceManual(Map<String, Object> list) throws Exception;
	
	/**
	 * 단가 수동배치 정보를 reset한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return rtnMap
	 *                processCnt    처리건수
	 *                listDupCheck  중복data
	 * @throws Exception
	*/
	public int updateHubInterfaceManual2(Map<String, Object> list) throws Exception;
	
	/**
	 * 단가 수동배치 정보를 저장한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return rtnMap
	 *                processCnt    처리건수
	 *                listDupCheck  중복data
	 * @throws Exception
	*/
	public int saveHubInterfaceManual2(Map<String, Object> list) throws Exception;
}
