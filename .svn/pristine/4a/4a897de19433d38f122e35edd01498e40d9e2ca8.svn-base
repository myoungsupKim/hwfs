package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 전략이익률 자재를 등록 하는 StrategyGainRateItemReg Service Interface
 * 
 * @ClassName StrategyGainRateItemRegService.java
 * @Description StrategyGainRateItemRegService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15    최성연        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.05.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface StrategyGainRateItemRegService {

	/**
	 * 전략이익률 자재  목록을 조회한다.
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
	RecordSet selectDate(Map<String, Object> mapParam) throws Exception;
	RecordSet upjangList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 전략이익률 자재  DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;
	int saveList2(DataSetMap list) throws Exception;
	int upjangMig(DataSetMap list) throws Exception;

	
	/**
	 * 전략이익률 자재  DataSetMap의 데이터를 일괄 Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int deleteList(DataSetMap list) throws Exception;
	int deleteAll(DataSetMap list) throws Exception;
}
