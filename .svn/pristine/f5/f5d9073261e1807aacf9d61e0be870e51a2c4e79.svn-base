package com.hwfs.rc.rcg.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 쿠폰종류관리하는 CouponSpecies DAO
 * 
 * @ClassName CouponSpeciesDAO.java
 * @Description CouponSpeciesDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.03.18
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rcg/couponSpeciesDAO")
public class CouponSpeciesDAO extends DefaultDAO {
	
	/**
	 * 쿠폰종류관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponSpeciesDAO.selectList", mapParam);
	}

	/**
	 * 쿠폰종류관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSpeciesDAO.insert", mapParam);
	}
	
	/**
	 * 쿠폰종류관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSpeciesDAO.update", mapParam);
	}
	
	/**
	 * 쿠폰종류관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSpeciesDAO.delete", mapParam);
	}
	
}
