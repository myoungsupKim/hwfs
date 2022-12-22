package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 이익율을 설정하는 GainRateSetMngt Service Interface
 * 
 * @ClassName GainRateSetMngtService.java
 * @Description GainRateSetMngtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.10    최성연        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.03.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface GainRateSetMngtService {

	/**
	 * 팀 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectTm(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 단가계약업장 목록을 조회한다.
	 * <pre>
	 * - DTO 
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectStd(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 팀별 판매그룹 목록을 조회한다.
	 * <pre>
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
	 * 판매그룹을 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(LoginDTO loginParameter, DataSetMap list) throws Exception;

	
	/**
	 * 자재 대분류 목록을 조회한다.
	 * <pre>
	 * - DTO 
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectClassCode(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 분류별 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectClass(Map<String, Object> mapParam) throws Exception;

	/**
	 * 업장 목록을 조회한다.
	 * <pre>
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
	 * 자재별 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectItem(Map<String, Object> mapParam) throws Exception;
	RecordSet selectTheme(Map<String, Object> mapParam) throws Exception;

	/**
	 * 자재별 이익율 현황을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectGainList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectGainList2(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 추가할 자재를 검색한다.
	 * <pre>
	 * 팝업화면(GainRateItemSearchPop)
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectItemPop(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 분류별 이익율을 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveClass(LoginDTO loginParameter, DataSetMap list) throws Exception;

	/**
	 * 자재별 이익율을 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveItem(LoginDTO loginParameter, DataSetMap list) throws Exception;
	int saveItem2(LoginDTO loginParameter, DataSetMap list) throws Exception;
	int saveTheme(LoginDTO loginParameter, DataSetMap list) throws Exception;
	
	/**
	 * 자재별 이익율을  건별 Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int deleteItem(LoginDTO loginParameter, DataSetMap list) throws Exception;
	int deleteTheme(LoginDTO loginParameter, DataSetMap list) throws Exception;

	/**
	 * 이익율을 업체별로 복사 한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int rateCopy(DataSetMap upjangList,Map<String, Object> mapParam) throws Exception;
	
}
