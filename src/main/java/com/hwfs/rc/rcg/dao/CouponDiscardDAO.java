package com.hwfs.rc.rcg.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 쿠폰폐기 관리하는 CouponDiscard DAO
 * 
 * @ClassName CouponDiscardDAO.java
 * @Description CouponDiscardDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.12   	유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.06.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rcg/couponDiscardDAO")
public class CouponDiscardDAO extends DefaultDAO {
	
	/**
	 * 쿠폰폐기 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponDiscardDAO.selectList", mapParam);
	}
	
	/**
	 * 쿠폰폐기 상세 목록을 조회한다. - 사용안함
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDetailList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponDiscardDAO.selectDetailList", mapParam);
	}

}
