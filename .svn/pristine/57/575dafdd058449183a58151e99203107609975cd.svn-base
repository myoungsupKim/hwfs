package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 채권채무 상계처리하는 ArDebitOffsetClearPop Service Interface
 * 
 * @ClassName ArDebitOffsetClearPopService.java
 * @Description ArDebitOffsetClearPopService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.27    김명호        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface ArDebitOffsetClearPopService {

	/**
	 * 채권채무 상계처리 목록을 조회한다.
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
	 * 채권채무 상계처리 DataSetMap의 데이터를 상계처리 위해 채권목록,선수금 목록, 입금 정보, 선수금 대체정보를 받아서 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param listAr : 채권목록
	 * @param receiveData : 입금정보
	 * @param listAdvance : 선수금목록
	 * @param advanceData : 선수금대체정보
	 * 
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap listAr, DataSetMap receiveData, DataSetMap listAdvance, DataSetMap advanceData) throws Exception;
	
	/**
	 * 채권채무 상계 취소 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int cancleList(DataSetMap listAr, DataSetMap receiveData, DataSetMap listAdvance, DataSetMap advanceData) throws Exception;
}
