package com.hwfs.fs.fsc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 케터링 스케줄보고하는 CateringSchlRept Service Interface
 * 
 * @ClassName CateringSchlReptService.java
 * @Description CateringSchlReptService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18    yanghj        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 yanghj
 * @since 2015.03.18
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface CateringSchlReptService {

	/**
	 * 케터링 스케줄보고(사업장 주요행사 계획<행사실적>) 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCeleList(Map<String, Object> mapParam) throws Exception;
	/**
	 * 케터링 스케줄보고(사업장 인력지원 계획<조리인력>) 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectCookHumanList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 케터링 스케줄보고(개인별근무 스케줄 리스트) 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectPlanList(Map<String, Object> mapParam) throws Exception;
	/**
	 * 케터링 스케줄보고(개인별근무 스케줄 달력) 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectCalendarList(Map<String, Object> mapParam) throws Exception;	
	/**
	 * 케터링 스케줄보고 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;
}
