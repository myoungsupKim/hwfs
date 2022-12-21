package com.hwfs.sm.cmn.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 선수금정보 공통 AdvanceCommon Service Interface
 * 
 * @ClassName AdvanceCommonService.java
 * @Description AdvanceCommonService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29    JUN        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.04.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface AdvanceCommonService {


	/**
	 * 선수금정보 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectAdvanceMst(Map<String, Object> mapParam) throws Exception;

	/**
	 * 선수금 환불 대상 정보 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectAdvanceRefundMst(Map<String, Object> mapParam) throws Exception;

	/**
	 * 선수금 대체 정보 조회(조회조건)
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectAdvanceAltMst(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 선수금 입금수단 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectAdvanceReceiveWay(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 선수금대체처리(이관 포함)
	 * @param list DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int setAdvanceAltProc(DataSetMap list1, DataSetMap list2) throws Exception;
	

	/**
	 * 선수금대체처리(이관전 등록)
	 * @param list DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int setAdvanceAltProcReq(DataSetMap list1, DataSetMap list2) throws Exception;
	
	/**
	 * 전자결재정보 업데이트
	 * @param list DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveSignInfo(DataSetMap list) throws Exception;
	
	
	/**
	 * 선수금대체 취소처리(이관 포함)
	 * @param list DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int setAdvanceAltCancel(DataSetMap list1, DataSetMap list2) throws Exception;
	
	/**
	 * 재이관 여부 체크
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet chkAdvanceTransInfo(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 이관취소 가능여부
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet chkAdvanceTransCancel(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 선수금잔액 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectTotalAdvanceAmt(Map<String, Object> mapParam) throws Exception;

	/**
	 * 선수금환불처리(을)를 처리한다.(식권 포함)
	 * @param list DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int setAdvanceRefundProc(DataSetMap list1, DataSetMap list2, DataSetMap list3) throws Exception;	

	/**
	 * 선수금대체 취소처리(식권 포함)
	 * @param list DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int setAdvanceRefundCancel(DataSetMap list1, DataSetMap list2) throws Exception;
	
	/**
	 * 선수금이관처리(을)를 처리한다.(식권 포함)
	 * @param list DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int setAdvanceTransProc(DataSetMap list1, DataSetMap list2, DataSetMap list3) throws Exception;	
	
	/**
	 * 선수금이관 취소처리(식권 포함)
	 * @param list DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int setAdvanceTransCancel(DataSetMap list1, DataSetMap list2) throws Exception;
	
	/**
	 * 선수금잔액 체크
	 * @return String 조회결과
	 * @throws Exception
	*/
	String getAdvanceAltYn(DataSetMap list) throws Exception;	
}
