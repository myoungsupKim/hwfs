package com.hwfs.rc.rcg.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 쿠폰소멸 처리 팝업하는 CouponTerminationPop DAO
 * 
 * @ClassName CouponTerminationPopDAO.java
 * @Description CouponTerminationPopDAO Class
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
@Repository("/rc/rcg/couponTerminationPopDAO")
public class CouponTerminationPopDAO extends DefaultDAO {
	
	/**
	 * 쿠폰소멸 처리 팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponTerminationPopDAO.selectList", mapParam);
	}
	
	/**
	 * 쿠폰소멸 처리 팝업 목록(소멸)을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTerminationList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponTerminationPopDAO.selectTerminationList", mapParam);
	}
	
	/**
	 * 쿠폰소멸 마스터 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCouponMst(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponTerminationPopDAO.selectCouponMst", mapParam);
	}

	/**
	 * 쿠폰소멸 처리 팝업(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponTerminationPopDAO.insert", mapParam);
	}
	
	/**
	 * 쿠폰소멸 처리 팝업(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponTerminationPopDAO.update", mapParam);
	}
	
	/**
	 * 쿠폰소멸 처리 팝업(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponTerminationPopDAO.delete", mapParam);
	}
	
	/**
	 * 쿠폰 소멸 처리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateNumCancleMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponTerminationPopDAO.updateNumCancleMst", mapParam);
	}
	
}
