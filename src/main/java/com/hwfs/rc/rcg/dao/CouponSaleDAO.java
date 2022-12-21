package com.hwfs.rc.rcg.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 쿠폰 판매 처리하는 CouponSale DAO
 * 
 * @ClassName CouponSaleDAO.java
 * @Description CouponSaleDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.30   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.03.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rcg/couponSaleDAO")
public class CouponSaleDAO extends DefaultDAO {
	
	/**
	 * 쿠폰 판매 처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponSaleDAO.selectList", mapParam);
	}
	
	/**
	 * 쿠폰 판매 처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDetailList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponSaleDAO.selectDetailList", mapParam);
	}
	
	/**
	 * 쿠폰 판매 처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String selectMaxProcNum(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("rc.rcg.couponSaleDAO.selectMaxProcNum", mapParam, null);
	}

	/**
	 * 쿠폰 판매 처리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSaleDAO.insertMst", mapParam);
	}
	
	/**
	 * 쿠폰 판매 상세 처리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSaleDAO.insertDetail", mapParam);
	}
	
	/**
	 * 쿠폰 판매 처리(을)를 마스터를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSaleDAO.updateMst", mapParam);
	}
	
	/**
	 * 쿠폰 판매 처리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateNumMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSaleDAO.updateNumMst", mapParam);
	}
	
	/**
	 * 쿠폰 판매 처리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateNumCancleMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSaleDAO.updateNumCancleMst", mapParam);
	}
	/**
	 * 쿠폰 판매 취소 처리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSaleDAO.deleteMst", mapParam);
	}
	
	/**
	 * 쿠폰 판매 취소 처리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSaleDAO.deleteDetail", mapParam);
	}
	
	/**
	 * 쿠폰 판매 처리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSaleDAO.delete", mapParam);
	}

	/**
	 * 쿠폰 판매 입금 수단을 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertReceiveWay(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSaleDAO.insertReceiveWay", mapParam);
	}
	
	/**
	 * 쿠폰 판매 입금 수단을 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReceiveWay(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSaleDAO.updateReceiveWay", mapParam);
	}
	
	/**
	 * 쿠폰 판매 입금 수단을 수정한다.(선수금대체번호)
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReceiveWayAtlNum(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSaleDAO.updateReceiveWayAtlNum", mapParam);
	}

}
