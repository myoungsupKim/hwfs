package com.hwfs.rc.roa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 용역 근무 내용을 관리하는 PartTimeDutyDetail Service Interface
 * 
 * @ClassName PartTimeDutyDetailService.java
 * @Description PartTimeDutyDetailService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.11.22    김지영        최초생성
 *  
 * </pre>
 * @author 서비스ITO2 : 김지영
 * @since 2018.11.22
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface PartTimeDutyDetailService {

	/**
	 * 용역 근무 내용 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 용역 시급 관리 중복체크
	 */
	int selectExists(Map<String, Object> parameter);
	
	/**
	 * 용역 근무 내용 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;
	
	/**
	 * 용역 근무내용정보(Combo)를 조회한다.
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectDutyDetail(Map<String, Object> mapParam) throws Exception;
}
