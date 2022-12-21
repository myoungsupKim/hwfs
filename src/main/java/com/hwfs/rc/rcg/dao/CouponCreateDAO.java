package com.hwfs.rc.rcg.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 쿠폰 생성 관리하는 CouponCreate DAO
 * 
 * @ClassName CouponCreateDAO.java
 * @Description CouponCreateDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.20   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.03.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rcg/couponCreateDAO")
public class CouponCreateDAO extends DefaultDAO {
	
	/**
	 * 쿠폰 생성 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponCreateDAO.selectList", mapParam);
	}

	/**
	 * 쿠폰 생성 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponCreateDAO.insert", mapParam);
	}
	
	/**
	 * 쿠폰 생성 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponCreateDAO.update", mapParam);
	}
	
	/**
	 * 쿠폰 생성 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponCreateDAO.delete", mapParam);
	}
	
	/**
	 * 쿠폰 생성 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("rc.rcg.couponCreateDAO.delCnt", mapParam);
	}
	
	/**
	 * 쿠폰 생성 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int couponStatusUpdate(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponCreateDAO.couponStatusUpdate", mapParam);
	}
	
	
	
	
	/**
	 * 쿠폰 생성 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int create(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponCreateDAO.create", mapParam);
	}
	
	/**
	 * 쿠폰 미생성된 중복 번호를 체크 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectCouponNumCount(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("rc.rcg.couponCreateDAO.selectCouponNumCount", mapParam);
	}

	/**
	 * 쿠폰 번호를 조회 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCouponNum(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponCreateDAO.selectCouponNum", mapParam);
	}
	
	/**
	 * 쿠폰 번호가 중복인지 조회 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectCouponCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("rc.rcg.couponCreateDAO.selectCouponCnt", mapParam);
	}


}
