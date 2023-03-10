package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.hwfs.sc.scb.dto.JobExecDTO;
import com.hwfs.sc.scb.dto.JobInfoDTO;

 /**
 * 
 * @ClassName HubPriceInterfaceService.java
 * @Description HubPriceInterfaceService Class
 * @Modification-Information
 * <pre>
 *    수정일             수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.19    hye.ji94   최초생성
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
public interface HubPriceInterfaceService {


	/**
	 * 단가업장 목록을 조회한다.
	 *
	 * @param jobList
	 *            DB에 저장된 Job 목록
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectPriceUpjang (Map<String, Object> mapParam) throws Exception;

	/**
	 * 단가계약 정보를 조회한다.
	 *
	 * @param jobList
	 *            DB에 저장된 Job 목록
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectContractInfo (Map<String, Object> mapParam) throws Exception;
	
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
