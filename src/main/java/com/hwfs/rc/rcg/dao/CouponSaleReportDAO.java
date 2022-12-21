package com.hwfs.rc.rcg.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 전표별 쿠폰판매내역 조회하는 CouponSaleReport DAO
 * 
 * @ClassName CouponSaleReportDAO.java
 * @Description CouponSaleReportDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.29   	유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.06.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rcg/couponSaleReportDAO")
public class CouponSaleReportDAO extends DefaultDAO {
	
	/**
	 * 전표별 쿠폰판매내역 조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponSaleReportDAO.selectList", mapParam);
	}

	/**
	 * 전표별 쿠폰판매내역 조회(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSaleReportDAO.insert", mapParam);
	}
	
	/**
	 * 전표별 쿠폰판매내역 조회(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSaleReportDAO.update", mapParam);
	}
	
	/**
	 * 전표별 쿠폰판매내역 조회(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSaleReportDAO.delete", mapParam);
	}
	
}
