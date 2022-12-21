package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 전략이익율 등록하는 StrategyProfit Service Interface
 * 
 * @ClassName StrategyProfitService.java
 * @Description StrategyProfitService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.16    sychoi        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 sychoi
 * @since 2015.11.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface StrategyProfitService {

	/**
	 * 전략이익율 CC별 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectStd(Map<String, Object> mapParam) throws Exception;

	/**
	 * 분류별 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectClass(Map<String, Object> mapParam) throws Exception;
	RecordSet selectClassType(Map<String, Object> mapParam) throws Exception;
	RecordSet selectClassBef(Map<String, Object> mapParam) throws Exception;

	/**
	 * 자재별 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectItem(Map<String, Object> mapParam) throws Exception;
	RecordSet selectItemBef(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 전략이익율 등록 목록을 조회한다.
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
	 * 전략이익율 등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	int saveClass(DataSetMap list) throws Exception;
	int deleteClass(DataSetMap list) throws Exception;
	int saveItem(DataSetMap list) throws Exception;
	int saveItem2(DataSetMap list) throws Exception;
	int deleteAll(DataSetMap list) throws Exception;
	int deleteItem(DataSetMap list) throws Exception;

}
