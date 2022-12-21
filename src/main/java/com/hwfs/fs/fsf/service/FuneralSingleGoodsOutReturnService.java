package com.hwfs.fs.fsf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 고인별 판매품목 출고/반품관리하는 FuneralSingleGoodsOutReturn Service Interface
 * 
 * @ClassName FuneralSingleGoodsOutReturnService.java
 * @Description FuneralSingleGoodsOutReturnService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.20    최문규        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FuneralSingleGoodsOutReturnService {
	
	/**
	 * 상품구분
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
	RecordSet selectSetCd(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 상품분류, 상세상품 코드리스트를 조회한다.
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
	RecordSet selectCodeList1(Map<String, Object> mapParam) throws Exception;
	RecordSet selectCodeList2(Map<String, Object> mapParam) throws Exception;
	RecordSet selectCodeList3(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 반품대상 상품의 총 판매수량을 조회한다.(입력시, 반품 수량 실시간 체크)
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
	RecordSet searchSaleCount(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 고인 목록을 조회한다.
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
	RecordSet selectDeadGuestList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 고인별 고인별 총액산출및 판매품목 출고/반품관리(을)를 조회한다.
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
	Map<String, RecordSet> selectGoodsSaleoutReturnList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 고인별 판매품목 출고/반품관리(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	Map<String, Object> saveGoodsSaleoutReturnList(Map<String, DataSetMap> mapParam) throws Exception;
}
