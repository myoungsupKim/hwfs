package com.hwfs.sm.stm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 세금계산서 발행을 관리하는 TaxInvoiceMgntHq DAO
 * 
 * @ClassName TaxInvoiceMgntHqDAO.java
 * @Description TaxInvoiceMgntHqDAO Class
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
@Repository("/sm/stm/taxInvoiceMgntHqDAO")
public class TaxInvoiceMgntHqDAO extends DefaultDAO {
	
	/**
	 * 세금계산서 발행(본사용) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceMgntHqDAO.selectList", mapParam);
	}
	
	/**
	 * 세금계산서 발행(본사용) 세금계산서 번호를 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Object selectTaxShetNum(Map<String, Object> mapParam) throws Exception {
		return super.queryForObject("sm.stm.taxInvoiceMgntHqDAO.selectTaxShetNum", mapParam, null);
	}

	/**
	 * 세금계산서 발행(본사용) 마스터를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertTaxShetMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntHqDAO.insertTaxShetMst", mapParam);
	}
	
	/**
	 * 세금계산서 발행(본사용) 상세를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertTaxShetDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntHqDAO.insertTaxShetDetail", mapParam);
	}
	
	/**
	 * 세금계산서 발행(본사용) 대상을 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertTaxShetOccurObj(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntHqDAO.insertTaxShetOccurObj", mapParam);
	}
	
	/**
	 * 신고사업장 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectNewhghtUpjangInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceMgntHqDAO.selectNewhghtUpjangInfo", mapParam);
	}
	
	/**
	 * 고객 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCustInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceMgntHqDAO.selectCustInfo", mapParam);
	}
	
	/**
	 * 
	 * 세금계산서 발행 상세 목록을 검색한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTaxShetDetailList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceMgntHqDAO.selectTaxShetDetailList", mapParam);
	}
	
	/**
	 * 
	 * 최근 신고사업장 담당자 정보 또는 최근 고객 담당자 정보를 검색한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectInchargeInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceMgntHqDAO.selectInchargeInfo", mapParam);
	}
	
	/**
	 * 
	 * 세금계산서 발행 마스터를 삭제한다.(논리삭제)
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteTaxShetMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntHqDAO.deleteTaxShetMst", mapParam);
	}
	
	/**
	 * 
	 * 세금계산서 발행 상세를 삭제한다.(논리삭제)
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteTaxShetDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntHqDAO.deleteTaxShetDtl", mapParam);
	}
	
	/**
	 * 
	 * 세금계산서 발행 대상목록을 삭제한다.(논리삭제)
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteTaxShetOccurObj(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntHqDAO.deleteTaxShetOccurObj", mapParam);
	}
	
	/**
	 * 
	 * 원본 세금계산서 발행 대상목록을 삭제한다.(논리삭제)
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteTaxShetOccurObjOrgnl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntHqDAO.deleteTaxShetOccurObjOrgnl", mapParam);
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
		return super.update("sm.stm.taxInvoiceMgntHqDAO.updateTaxProgressStatus", mapParam);
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
		return super.update("sm.stm.taxInvoiceMgntHqDAO.insertConcellation", mapParam);
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
		return super.update("sm.stm.taxInvoiceMgntHqDAO.insertConcellationDetail", mapParam);
	}
	
	/**
	 * 수정세금계산서 번호를 가져온다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Object selectTaxShetNumConcellation(Map<String, Object> mapParam) throws Exception {
		return super.queryForObject("sm.stm.taxInvoiceMgntHqDAO.selectTaxShetNumConcellation", mapParam, null);
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
		return super.update("sm.stm.taxInvoiceMgntHqDAO.insertTaxShetCorrectionMst", mapParam);
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
		return super.update("sm.stm.taxInvoiceMgntHqDAO.insertTaxShetCorrectionDtl", mapParam);
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
		return super.update("sm.stm.taxInvoiceMgntHqDAO.insertTaxShetApplyAmtDtl", mapParam);
	}
	
	/**
	 * 기재사항착오정정일경우 매출등 발생 정보에 새로운 세금계산서 번호로 업데이트 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateCorrectionObj(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.stm.taxInvoiceMgntHqDAO.updateCorrectionObj", mapParam);
	}
	
	/**
	 * 세금계산서 공급 받는자 담당자를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectInvoiceRcvr(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.stm.taxInvoiceMgntHqDAO.selectInvoiceRcvr", mapParam);
	}
	

}
