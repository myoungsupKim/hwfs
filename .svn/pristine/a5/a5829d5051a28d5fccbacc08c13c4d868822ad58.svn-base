package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 판매단가를 일괄수정하는 SalePriceIndexPackModify Service Interface
 * 
 * @ClassName SalePriceIndexPackModifyService.java
 * @Description SalePriceIndexPackModifyService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.21    최성연        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.04.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SalePriceIndexPackModifyService {

	/**
	 * 구매자재 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectItem(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 판매단가 일괄수정 목록을 조회한다.
	 * <pre>
	 * - 1번째 탭 리스트 조회
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
	 * 판매단가 일괄수정 업장 목록을 조회한다.
	 * <pre>
	 * - 2번째 탭 리스트 조회
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectUpjang(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 판매단가 일괄수정 추가 자재 정보를 조회한다.
	 * <pre>
	 * - 2/3번째 탭 리스트 조회(자재목록)
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectItemCode(Map<String, Object> mapParam) throws Exception;
	RecordSet selectItemCode2(Map<String, Object> mapParam) throws Exception;

	/**
	 * 판매단가 일괄수정 추가 자재 정보 이력사항을 조회한다.
	 * <pre>
	 * - 2번째 탭
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectHist(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 판매단가를 일괄수정 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 1번째 탭의 고객사별 단가를 일괄 변경
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;


	/**
	 * 자재 일괄추가/변경 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 2/3번째 탭의 고객사별 단가를 일괄 변경
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList2(DataSetMap list) throws Exception;
	int saveList3(DataSetMap list) throws Exception;


}
