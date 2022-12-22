package com.hwfs.sm.sar.service;

import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

 /**
 * 가수금을 전환 신청하는 SuspenseReturnRequest Service Interface
 * 
 * @ClassName SuspenseReturnRequestService.java
 * @Description SuspenseReturnRequestService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15    JUN        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SuspenseReturnRequestService {

	/**
	 * 가수금 전환 신청 목록 EAI 호출을 한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	List<Map<String, Object>> selectSuspenseInquery(Map<String, Object> mapParam) throws Exception;

	/**
	 * 가수금 상세(히스토리) 조회
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> selectSuspenseLogInquery(Map<String, Object> mapParam) throws Exception;

	/**
	 * 가수금 전환신청 EAI 호출
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	String processSuspenseAltRequest(Map<String, Object> mapParam, DataSetMap list) throws Exception;
	
	/**
	 * 가수금 전환취소신청 EAI 호출
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	String processCancelSuspenseAltRequest(Map<String, Object> mapParam, DataSetMap list) throws Exception;
	
	/**
	 * 가수금 전환결과 EAI 호출.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	List<Map<String, Object>> selectSuspenseAltRequest(Map<String, Object> mapParam) throws Exception;


}
