package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 월마감 현황을 관리하는 MonthCloseChk Service Interface
 * 
 * @ClassName MonthCloseChkService.java
 * @Description MonthCloseChkService Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.21    백승현      최초생성
 * 
 * </pre>
 * @author FC종합전산구축 : 통합영업 백승현
 * @since 2015.12.21
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface MonthCloseChkService {

	/**
	 * 월마감관리 현황 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 월마감 현황을 조회 DataSetMap의 데이터를 Merge 처리한다.
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	int saveList(DataSetMap list) throws Exception;
	
	/**
	 * 회계 월마감 현황을 조회 DataSetMap의 데이터를 Merge 처리한다.
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	int saveList2(DataSetMap list) throws Exception;
	
	/**
	 * 회계 월마감관리 현황 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	RecordSet selectList2(Map<String, Object> mapParam) throws Exception;

}
