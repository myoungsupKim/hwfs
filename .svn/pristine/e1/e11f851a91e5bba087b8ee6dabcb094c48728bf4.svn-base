package com.hwfs.sm.cmn.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 공통 Common Service Interface
 * 
 * @ClassName CommonService.java
 * @Description CommonService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.12    JUN        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.03.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface CommonService {

	/**
	 * 공통코드의 정보를 조회한다.
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectComCode(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 사업부(Combo)를 조회한다.
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectMuCd(Map<String, Object> mapParam) throws Exception;

	/**
	 * 영업유형코드(Combo)를 조회한다.
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectTypeCd(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 전표유형에 해당하는 시스템코드Combo 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectSysClassBySlipType(Map<String, Object> mapParam) throws Exception;

	/**
	 * 사업부에 해당하는 시스템코드Combo 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectSysClassByMuCd(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 사업부에 해당하는 전표유형Combo 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectSlipTypeByMuCd(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 용역 시급정보(Combo)를 조회한다.
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectDutyAmt(Map<String, Object> mapParam) throws Exception;

	/**
	 * 보유계좌정보를 조회한다.
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectAcntCd(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 회사코드(BU_CD)를 조회한다.
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet selectBuCd(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 사업부를 조회한다.(영업회계 공통)
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet getMuCd(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 팀을 조회한다.(영업회계 공통)
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet getTmCd(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * CC를 조회한다.(영업회계 공통)
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet getCcCd(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 업장을 조회한다.(영업회계 공통)
	 * @return RecordSet 조회결과
	 * @throws Exception
	*/
	RecordSet getUpjangCd(Map<String, Object> mapParam) throws Exception;

	/**
	 * 영업현금잔액 체크
	 * @return String 조회결과
	 * @throws Exception
	*/
	String getCashAltYn(DataSetMap list) throws Exception;
	
	/**
	 * 채권(입금)잔액 체크
	 * @return String 조회결과
	 * @throws Exception
	*/
	String getArReceiveYn(DataSetMap list) throws Exception;	
}
