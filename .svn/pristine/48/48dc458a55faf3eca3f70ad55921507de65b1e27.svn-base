package com.hwfs.fm.fmo.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 주문확정하는 OrderRequestConfirm Service Interface
 * 
 * @ClassName OrderRequestConfirmService.java
 * @Description OrderRequestConfirmService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.25    손형민        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface OrderRequestConfirmService {

	/**
	 * 주문확정 [목록]을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 주문확정 [상세목록] 을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSub(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 주문확정 확정전 [통제여부]를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSubFlag(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 주문확정 DataSetMap의 데이터를 [확정] 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	Map<String, Object> saveList(DataSetMap list) throws Exception;
	
	/**
	 * 주문확정 DataSetMap의 데이터를 [취소] 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int cnclList(DataSetMap list) throws Exception;
	
}

