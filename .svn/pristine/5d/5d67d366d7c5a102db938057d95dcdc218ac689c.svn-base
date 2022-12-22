package com.hwfs.fm.fmc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 클레임접수하는 ClaimAccept Service Interface
 * 
 * @ClassName ClaimAcceptService.java
 * @Description ClaimAcceptService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.13    최영준        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.05.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface ClaimAcceptService {

	
	/**
	 * 분류 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectItemClass(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 클레임접수 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * CS사원 체크를 한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return boolean 
	 *            CS사원 true, false
	 * @throws Exception
	*/
	String checkCS(Map<String, Object> mapParam) throws Exception;

	/**
	 * 클레임접수 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;
	
	/**
	 * 클레임접수 확정건 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int updateList(DataSetMap list) throws Exception;
}
