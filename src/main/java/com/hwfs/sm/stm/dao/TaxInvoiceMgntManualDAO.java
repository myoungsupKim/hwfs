package com.hwfs.sm.stm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 세금계산서 발행을 관리하는 TaxInvoiceMgntHq DAO
 * 
 * @ClassName taxInvoiceMgntManualDAO.java
 * @Description taxInvoiceMgntManualDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.10   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.06.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/stm/taxInvoiceMgntManualDAO")
public class TaxInvoiceMgntManualDAO extends DefaultDAO {
	
	/**
	 * 세금계산서 발행(수기) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceMgntManualDAO.selectList", mapParam);
	}
	
	/**
	 * 세금계산서 발행(본사용) 세금계산서 번호를 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Object selectTaxShetNum(Map<String, Object> mapParam) throws Exception {
		return super.queryForObject("sm.stm.taxInvoiceMgntManualDAO.selectTaxShetNum", mapParam, null);
	}

	/**
	 * 세금계산서 발행(본사용) 마스터를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertTaxShetMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntManualDAO.insertTaxShetMst", mapParam);
	}
	
	/**
	 * 세금계산서 발행(본사용) 상세를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertTaxShetDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntManualDAO.insertTaxShetDetail", mapParam);
	}
	
	/**
	 * 신고사업장 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectNewhghtUpjangInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceMgntManualDAO.selectNewhghtUpjangInfo", mapParam);
	}
	
	/**
	 * 고객 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCustInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceMgntManualDAO.selectCustInfo", mapParam);
	}
	
	/**
	 * 
	 * 세금계산서 발행 상세 목록을 검색한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTaxShetDetailList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceMgntManualDAO.selectTaxShetDetailList", mapParam);
	}
	
	/**
	 * 
	 * 최근 신고사업장 담당자 정보 또는 최근 고객 담당자 정보를 검색한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectInchargeInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceMgntManualDAO.selectInchargeInfo", mapParam);
	}
	
	/**
	 * 
	 * 세금계산서 발행 마스터를 삭제한다.(논리삭제)
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteTaxShetMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntManualDAO.deleteTaxShetMst", mapParam);
	}
	
	/**
	 * 
	 * 세금계산서 발행 상세를 삭제한다.(논리삭제)
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteTaxShetDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntManualDAO.deleteTaxShetDtl", mapParam);
	}
	
	/**
	 * 세금계산서 상태를 변경한다.
	 * updateTaxProgressStatus 기능 설명
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateTaxProgressStatus(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntManualDAO.updateTaxProgressStatus", mapParam);
	}
	
	/**
	 * 수정세금계산서 - 계약의 해제 마스터 등록한다.
	 * updateTaxProgressStatus 기능 설명
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int insertConcellation(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntManualDAO.insertConcellation", mapParam);
	}
	
	/**
	 * 수정세금계산서 - 계약의 해제 상세 등록한다.
	 * updateTaxProgressStatus 기능 설명
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int insertConcellationDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntManualDAO.insertConcellationDetail", mapParam);
	}
	
	/**
	 * 수정세금계산서 번호를 가져온다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Object selectTaxShetNumConcellation(Map<String, Object> mapParam) throws Exception {
		return super.queryForObject("sm.stm.taxInvoiceMgntManualDAO.selectTaxShetNumConcellation", mapParam, null);
	}
	
	
	/**
	 * 수정세금계산서 - 계약의 해제 마스터 등록한다.
	 * updateTaxProgressStatus 기능 설명
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int insertTaxShetCorrectionMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntManualDAO.insertTaxShetCorrectionMst", mapParam);
	}
	
	/**
	 * 수정세금계산서 - 계약의 해제 상세 등록한다.
	 * updateTaxProgressStatus 기능 설명
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int insertTaxShetCorrectionDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntManualDAO.insertTaxShetCorrectionDtl", mapParam);
	}
	
	/**
	 * 수정세금계산서 - 공급가액 등록 상세 등록한다.
	 * updateTaxProgressStatus 기능 설명
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int insertTaxShetApplyAmtDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntManualDAO.insertTaxShetApplyAmtDtl", mapParam);
	}
	
	
}
