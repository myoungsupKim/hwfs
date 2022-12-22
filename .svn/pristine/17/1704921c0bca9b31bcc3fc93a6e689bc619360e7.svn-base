package com.hwfs.sm.stm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 세금계산서 발행을 관리하는 TaxInvoiceMgntManual Service Interface
 * 
 * @ClassName TaxInvoiceMgntManualService.java
 * @Description TaxInvoiceMgntManualService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.10    Yu        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.06.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TaxInvoiceMgntManualService {

	/**
	 * 세금계산서 발행(본사용) 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 세금계산서 발행(본사용) DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveTaxInvoice(DataSetMap taxShetMst, DataSetMap taxShetDtl) throws Exception;
	
	/**
	 * CC_CD로 업장정보 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangInfo(Map<String, Object> mapParam) throws Exception ;
	
	/**
	 * 
	 * 세금계산서 발행 상세 목록을 검색한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTaxShetDetailList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 
	 * 최근 신고사업장 담당자 정보 또는 최근 고객 담당자 정보를 검색한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectInchargeInfo(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 세금계산서 발행(본사용) 데이터를 삭제한다.
	 *
	 * @return 처리건수
	 * @throws Exception
	*/
	int deleteTaxInvoice(DataSetMap list) throws Exception;
	
	/**
	 * 
	 * 세금계산서 요청
	 *
	 * @param list
	 * @return
	 */
	public Map<String, Object> taxInvoiceRequest(DataSetMap list, String reqStatus, LoginDTO loginDto) throws Exception;
	
	
	
	/**
	 * 수정 세금계산서 DataSetMap의 데이터를 Insert 시킨다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	Map<String, String> saveConcellation(DataSetMap taxShetMst, DataSetMap taxShetDtl) throws Exception;
	
}
