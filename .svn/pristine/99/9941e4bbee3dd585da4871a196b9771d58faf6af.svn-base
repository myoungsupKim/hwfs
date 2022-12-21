package com.hwfs.sm.cmn.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 가수금정보 공통 SuspenseCommon Service Interface
 * 
 * @ClassName SuspenseCommonService.java
 * @Description SuspenseCommonService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06    JUN        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SuspenseCommonService {

	/**
	 * 가수금정보 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectSuspenseList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 가수금정보 내역조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectSuspenseHistory(Map<String, Object> mapParam) throws Exception;

	/**
	 * 가수금 대체 정보 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectSuspenseAltMst(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 가수금대체처리
	 * @param list DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int setSuspenseAltProc(DataSetMap list) throws Exception;
	
	/**
	 * 가수금대체 취소처리
	 * @param list DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int setSuspenseAltCancel(DataSetMap list) throws Exception;
	
	/**
	 * 가수금잔액 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectTotalSuspenseAmt(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 가수금잔액 체크
	 * @return String 조회결과
	 * @throws Exception
	*/
	String getSuspenseAltYn(DataSetMap list) throws Exception;

}
