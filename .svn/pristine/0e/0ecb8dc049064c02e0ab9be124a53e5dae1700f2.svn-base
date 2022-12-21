package com.hwfs.fm.fmc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 발주대비클레임건수하는 OrderClaimCnt Service Interface
 * 
 * @ClassName OrderClaimCntService.java
 * @Description OrderClaimCntService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.29    최영준        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통하영업 최영준
 * @since 2015.05.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface OrderClaimCntService {

	/**
	 * 발주대비클레임건수 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet upjangSearch(Map<String, Object> mapParam) throws Exception;
	RecordSet custSearch(Map<String, Object> mapParam) throws Exception;
	RecordSet custDetailSearch(Map<String, Object> mapParam) throws Exception;
	RecordSet subCustSearch(Map<String, Object> mapParam) throws Exception;
	RecordSet itemSearch(Map<String, Object> mapParam) throws Exception;
	RecordSet chartSearch(Map<String, Object> mapParam) throws Exception;
	//RecordSet dayTermSearch(Map<String, Object> mapParam) throws Exception;
	//RecordSet monthTermSearch(Map<String, Object> mapParam) throws Exception;
	RecordSet typeSearch(Map<String, Object> mapParam) throws Exception;
	/**
	 * 발주대비클레임건수 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;
}
