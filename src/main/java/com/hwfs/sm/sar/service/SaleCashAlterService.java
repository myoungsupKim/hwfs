package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 영업수입 현금 가수금 대체하는 SaleCashAlter Service Interface
 * 
 * @ClassName SaleCashAlterService.java
 * @Description SaleCashAlterService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.14    김명호        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SaleCashAlterService {

	/**
	 * 영업수입 현금 가수금 대체 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 영업수입 현금 대체 마스터 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectMstList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 영업수입 현금 가수금 대체 DataSetMap의 데이터를 rowType에 따라 대체 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	
	int saveList(DataSetMap search, DataSetMap list, DataSetMap listSuspense) throws Exception;
	
	/**
	 * 영업수입 현금 가수금 대체 DataSetMap의 데이터를 rowType에 따라 대체취소 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int cancleList(DataSetMap list, DataSetMap listSuspense, DataSetMap search) throws Exception;
}
