package com.hwfs.rc.rcm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 업장 마감을하는 CloseMgnt01 Service Interface
 * 
 * @ClassName CloseMgnt01Service.java
 * @Description CloseMgnt01Service Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.26    JUN        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface CloseMgnt01Service {

	/**
	 * 업장 마감 (매출목록)을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet salsList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 업장 마감 (지불목록)을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet paymentList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 업장 마감 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	
	/**
	 * 업장 마감 (선수금발생 목록)을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAdvanceOccurList(Map<String, Object> mapParam) throws Exception;
}
