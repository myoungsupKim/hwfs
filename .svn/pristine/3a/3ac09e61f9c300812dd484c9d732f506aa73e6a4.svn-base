package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 업장품목 예외사항 관리하는 SalePriceException Service Interface
 * 
 * @ClassName SalePriceExceptionService.java
 * @Description SalePriceExceptionService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.15    최성연        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.07.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SalePriceExceptionService {

	/**
	 * 단가계약업장 목록 조회를 수행합니다
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectStd(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 업장품목 예외사항 관리 목록을 조회한다.(+)(-)
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectListAdd(Map<String, Object> mapParam) throws Exception;
	RecordSet selectListDel(Map<String, Object> mapParam) throws Exception;

	/**
	 * 업장품목 예외사항 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	int saveExcel(DataSetMap list) throws Exception;
}
