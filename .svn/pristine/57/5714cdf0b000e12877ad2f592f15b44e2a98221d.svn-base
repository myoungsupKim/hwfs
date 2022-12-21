package com.hwfs.fm.fms.service;

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
public interface HubInterfaceMngtService {


	/**
	 * DB에 등록된 User ID 목록을 조회한다.
	 *
	 * @param jobList
	 *            DB에 저장된 Job 목록
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectUserIDList (Map<String, Object> mapParam) throws Exception;

	
	/**
	 * User 정보를 저장한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return rtnMap
	 *                processCnt    처리건수
	 *                listDupCheck  중복data
	 * @throws Exception
	*/
	Map<String, Object> saveHubInterface(DataSetMap list) throws Exception;
	
	
	
	/**
	 * 수동배치 정보를 reset한다.
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
	 * 수동배치 정보를 저장한다.
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
	 * 허브메카 수동배치 실행 권한을 조회한다.
	 * 추가일자:20220711  처리자:김혜진 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectBatchAuth(Map<String, Object> mapParam) throws Exception;	
	

}
