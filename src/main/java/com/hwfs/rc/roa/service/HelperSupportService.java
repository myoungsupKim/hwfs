package com.hwfs.rc.roa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * HELPER 지원 내역을 관리하는 HelperSupport Service Interface
 * 
 * @ClassName HelperSupportService.java
 * @Description HelperSupportService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.23    유인찬        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.03.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface HelperSupportService {

	/**
	 * HELPER 지원 내역 목록을 조회한다.
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * HELPER 지원 내역 중복을 체크한다.
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	int selectExists(Map<String, Object> mapParam) throws Exception;

	/**
	 * HELPER 지원 내역 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;
}
