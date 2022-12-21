package com.hwfs.rc.rcm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 일마감 정보하는 CloseMgntDtlPop Service Interface
 * 
 * @ClassName CloseMgntDtlPopService.java
 * @Description CloseMgntDtlPopService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.11    JUN        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.08.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface CloseMgntDtlPopService {

	/**
	 * 일마감 정보를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 일마감 매출정보를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSalsList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 일마감 매출정보를 조회한다(사업장일마감용).
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectSalsListMag(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 일마감 지불정보를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectPayList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 일마감 지불정보를 조회한다(사업장일마감용).
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectPayListMag(Map<String, Object> mapParam) throws Exception;
}
