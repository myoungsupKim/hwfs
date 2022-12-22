package com.hwfs.sc.scz.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * SAP 인터페이스 내역을 조회하는 SapInterfaceRetrieve Service Interface
 * 
 * @ClassName SapInterfaceRetrieveService.java
 * @Description SapInterfaceRetrieveService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.02    김재섭        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.09.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SapInterfaceRetrieveService {

	/**
	 * 계정코드 마지막 수신일자 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectAcctMstLastDate() throws Exception;

	/**
	 * 계정코드 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectAcctMst(Map<String, Object> mapParam) throws Exception;

	/**
	 * 전표 마지막 송신일자 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSlipLastDate() throws Exception;

	/**
	 * 전표유형 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSlipType() throws Exception;

	/**
	 * 전표마스터 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSlipMst(Map<String, Object> mapParam) throws Exception;

	/**
	 * 전표디테일 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSlipDtl(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 전표상태 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSlipStatus(Map<String, Object> mapParam) throws Exception;

	/**
	 * 전표취소 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSlipCancel(Map<String, Object> mapParam) throws Exception;

	/**
	 * 거래처 마지막 요청일자
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCustLastDate() throws Exception;

	/**
	 * 거래처 요청 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCustRequest(Map<String, Object> mapParam) throws Exception;

	/**
	 * 거래처 요청결과 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCustResponse(Map<String, Object> mapParam) throws Exception;

	/**
	 * 조직 마지막 수신일자
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCcLastDate() throws Exception;

	/**
	 * 조직 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCc(Map<String, Object> mapParam) throws Exception;
	
	RecordSet selectCcLog(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 세금계산서 마지막 송신일자
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectTaxShetLastDate() throws Exception;
	
	/**
	 * 세금계산서 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectTaxShetHdr(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 세금계산서 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectTaxShetItem(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 세금계산서 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectTaxShetPublish(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 세금계산서 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectTaxShetAttach(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 세금계산서 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectTaxShetPublishStatus(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 세금계산서 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectTaxShetStatus(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 세금계산서 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectTaxShetNtsStatus(Map<String, Object> mapParam) throws Exception;
	
	
	
	
	
	
	
	


}
