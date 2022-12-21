package com.hwfs.fs.fsf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 판매상품군 정보관리하는 FuneralSaleGoodsInfoMgnt Service Interface
 * 
 * @ClassName FuneralSaleGoodsInfoMgntService.java
 * @Description FuneralSaleGoodsInfoMgntService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16    최문규        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FuneralSaleGoodsInfoMgntService {
	
	/**
	 * 세트등록(TAB2)_세트 코드 combo 리스트를 조회한다.
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
	RecordSet selectSetCdCombo(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 판매상품등록(TAB1)_매점상품 팝업 목록을 조회한다.
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
	RecordSet selectStoreClassPopupList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 장례식장 판매상품군 정보관리, 세트코드 조회한다.
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
	Map<String, RecordSet> selectFuneralSaleGoodsInputList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectSaleRegClassList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectSetList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 *  판매상품등록(TAB1)_상품 삭제가능 여부를 조회한다.
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
	RecordSet selectGoodsDeleteYn(Map<String, Object> mapParam) throws Exception;
	RecordSet selectSetDeleteYn(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 장례식장 관계자일경우 생성된 세트코드(을)를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveFuneralSaleGoodsInputList(Map<String, DataSetMap> param) throws Exception;
	
	String makeDtlCode(String strNum) throws Exception;
}
