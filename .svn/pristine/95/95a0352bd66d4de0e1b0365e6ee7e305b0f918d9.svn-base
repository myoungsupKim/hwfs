package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 특약율을 설정하는 SpContFact Service Interface
 * 
 * @ClassName SpContFactService.java
 * @Description SpContFactService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.16    최성연        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.03.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SpContFactService {

	/**
	 * 업장별 창고리스트 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSubinv(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 품목별 특약율을 설정 목록을 조회한다.
	 * <pre>
	 * - 중분류, 소분류, 품목별 조회
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectGroup(Map<String, Object> mapParam) throws Exception;
	RecordSet selectClass(Map<String, Object> mapParam) throws Exception;
	RecordSet selectItem(Map<String, Object> mapParam) throws Exception;
	RecordSet selectItem2(Map<String, Object> mapParam) throws Exception;


	/**
	 * 품목별 특약율관련 기준일자를 목록을 조회한다.
	 * <pre>
	 * - 기준일자 LIST
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectDateList(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 본사별 창고리스트 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSub(Map<String, Object> mapParam) throws Exception;	
	
	
	/**
	 * 품목별 특약율을 설정 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 중분류, 소분류, 자재별에 대한 항목 저장 
	 * </pre>
	 *
	 * @param loginParameter
	 *            로그인 세션
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리결과
	 * @throws Exception
	*/
	int saveGroup(LoginDTO loginParameter, DataSetMap list) throws Exception;
	int saveItem(LoginDTO loginParameter, DataSetMap list) throws Exception;
	int deleteItem2(LoginDTO loginParameter, DataSetMap list) throws Exception;
	
	
	/**
	 * 일괄복사를 위한 특약율정보 자료개수(COUNT)를 조회한다.
	 *
	 * @param loginParameter
	 *            로그인 세션
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리결과
	 * @throws Exception
	*/
	int selectSubCnt(Map<String, Object> mapParam) throws Exception;	
	
	
	/**
	 * 품목별 특약율을 설정 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 일괄 복사처리
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveSub(DataSetMap list, DataSetMap list1) throws Exception;
}
