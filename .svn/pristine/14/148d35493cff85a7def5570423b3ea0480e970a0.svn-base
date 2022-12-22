package com.hwfs.rc.rcg.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 쿠폰 배포 처리하는 CouponDestribution DAO
 * 
 * @ClassName CouponDestributionDAO.java
 * @Description CouponDestributionDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.24   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.03.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rcg/couponDestributionDAO")
public class CouponDestributionDAO extends DefaultDAO {
	
	/**
	 * 쿠폰 배포 처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponDestributionDAO.selectList", mapParam);
	}

	/**
	 * 쿠폰 배포 처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String selectMaxDplyNum(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("rc.rcg.couponDestributionDAO.selectMaxDplyNum", mapParam, null);
	}

	/**
	 * 쿠폰 배포 처리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponDestributionDAO.insertMst", mapParam);
	}
	
	/**
	 * 쿠폰 배포 처리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponDestributionDAO.insertDetail", mapParam);
	}
	
	/**
	 * 쿠폰 배포 처리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateNumMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponDestributionDAO.updateNumMst", mapParam);
	}
	
	/**
	 * 쿠폰 배포 처리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponDestributionDAO.delete", mapParam);
	}
	
}
