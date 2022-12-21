package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 영업수입 현금 가수금 대체하는 SaleCashAlter DAO
 * 
 * @ClassName SaleCashAlterDAO.java
 * @Description SaleCashAlterDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.14   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/saleCashAlterDAO")
public class SaleCashAlterDAO extends DefaultDAO {
	
	/**
	 * 영업수입 현금 가수금 대체 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.saleCashAlterDAO.selectList", mapParam);
	}
	
	/**
	 * 영업수입 현금 대체 마스터을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMstList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.saleCashAlterDAO.selectMstList", mapParam);
	}
	
	/**
	 * 영업수입 현금 영업현금번호 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String selectMaxSalesCashNum(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.sar.saleCashAlterDAO.selectMaxSalesCashNum", mapParam, null);
	}
	
	/**
	 * 영업수입 대체마스터 영업현금입금번호 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String selectMaxSalesCashReceiveNum(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.sar.saleCashAlterDAO.selectMaxSalesCashReceiveNum", mapParam, null);
	}
	
	/**
	 * 영업수입 현금 가수금 대체 번호(을)를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String selectMaxAltNum(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.sar.saleCashAlterDAO.selectMaxAltNum", mapParam, null);
	}

	/**
	 * 영업수입 현금 가수금 대체(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSuspenseAlt(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.insertSuspenseAlt", mapParam);
	}
	
	/**
	 * 영업수입 현금 가수금 정보를 대체 처리 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSuspenseInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.updateSuspenseInfo", mapParam);
	}
	
	/**
	 * 영업수입 현금(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSaleCash(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.insertSaleCash", mapParam);
	}
	
	/**
	 * 영업 현금 발생 정보를 수정한다(쿠폰판매)
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSaleCashCoupon(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.updateSaleCashCoupon", mapParam);
	}

	/**
	 * 영업 현금 발생 정보를 대체 처리 수정한다
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSaleCash(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.updateSaleCash", mapParam);
	}
	
	/**
	 * 영업 현금 발생 정보를 수정한다(입금관리 현금발생시)
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSaleCashReceive(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.updateSaleCashReceive", mapParam);
	}
	
	/**
	 * 영업 현금 대체 상세(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSalesCashAltDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.insertSalesCashAltDetail", mapParam);
	}
	
	/**
	 * 영업 현금 발생 정보를 대체 처리 수정한다
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSalesCashAltDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.updateSalesCashAltDetail", mapParam);
	}
	
	/**
	 * 영업 현금 발생 정보를 대체취소한다
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancelSalesCashAltDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.cancelSalesCashAltDetail", mapParam);
	}
	
	/**
	 * 영업 현금 대체 마스터(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSalesCashAltMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.insertSalesCashAltMst", mapParam);
	}
	
	/**
	 * 영업 현금 발생 정보를 대체 처리 수정한다
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSalesCashAltMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.updateSalesCashAltMst", mapParam);
	}
	
	/**
	 * 영업 현금 발생 정보를 대체 취소한다
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancelSalesCashAltMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.cancelSalesCashAltMst", mapParam);
	}
	
	/**
	 * 영업 현금 발생 정보를 대체 처리 수정한다
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSalesCashAltMstAmt(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.updateSalesCashAltMstAmt", mapParam);
	}
	
	/**
	 * 영업 현금 발생 취소처리한다
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteSaleCash(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.deleteSaleCash", mapParam);
	}
	
	/**
	 * 영업 현금 발생 취소처리한다(쿠폰)
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancelSaleCashCoupon(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.cancelSaleCashCoupon", mapParam);
	}
	
	/**
	 * 영업 현금 발생 취소처리한다(입금관리의 현금발생 취소시)
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancelSaleCashReceive(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.cancelSaleCashReceive", mapParam);
	}

	/**
	 * 영업수입 현금 가수금 대체(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.saleCashAlterDAO.delete", mapParam);
	}
	
}
