package com.hwfs.rc.rcg.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 쿠폰번호를 관리하는 CouponMgnt DAO
 * 
 * @ClassName CouponMgntDAO.java
 * @Description CouponMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.05   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.06.05
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rcg/couponMgntDAO")
public class CouponMgntDAO extends DefaultDAO {
	
	/**
	 * 쿠폰번호 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponMgntDAO.selectList", mapParam);
	}

	public RecordSet selectCouponStatus(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponMgntDAO.selectCouponStatus", mapParam);
	}
	
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponMgntDAO.insertList", mapParam);
	}
}
