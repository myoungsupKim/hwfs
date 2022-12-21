package com.hwfs.rc.rcg.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 쿠폰회수 내역 관리하는 CouponWithdraw DAO
 * 
 * @ClassName CouponWithdrawDAO.java
 * @Description CouponWithdrawDAO Class
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
@Repository("/rc/rcg/couponWithdrawDAO")
public class CouponWithdrawDAO extends DefaultDAO {
	
	/**
	 * 쿠폰회수 내역 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponWithdrawDAO.selectList", mapParam);
	}
	
	/**
	 * 쿠폰회수 상세 내역을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDetail(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponWithdrawDAO.selectDetail", mapParam);
	}
	/**
	 * 쿠폰회수 내역 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> callWithdrawProcedure(Map<String, Object> inParam, String callProcName) throws Exception {
		//전달 순서대로 설정
		SqlParameter[] sqlParameter = new SqlParameter[] {
		    new SqlParameter("P_OCCUR_DATE",    Types.VARCHAR),
		    new SqlParameter("P_COUPON_NUM",    Types.VARCHAR),
		    new SqlParameter("P_CC_CD",    	Types.VARCHAR),
		    new SqlParameter("P_UPJANG_CD",    	Types.VARCHAR),
		    new SqlParameter("P_COUPON_AMT",		Types.VARCHAR),
		    new SqlParameter("P_USE_AMT",		Types.VARCHAR),
		    new SqlParameter("P_EXCH_AMT",		Types.VARCHAR),
		    new SqlParameter("P_REMARK",		Types.VARCHAR),
            new SqlOutParameter("O_RTN",    	Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG", 	Types.VARCHAR)
		};

		// procedure 호출
		return callProcedure(callProcName, sqlParameter, inParam);
	}
	/**
	 * 쿠폰회수 취소 처리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> callWithdrawCancel(Map<String, Object> inParam, String callProcName) throws Exception {
		//전달 순서대로 설정
		SqlParameter[] sqlParameter = new SqlParameter[] {
		    new SqlParameter("P_OCCUR_DATE",    Types.VARCHAR),
		    new SqlParameter("P_COUPON_NUM",    Types.VARCHAR),
		    new SqlParameter("P_UPJANG_CD",    	Types.VARCHAR),
            new SqlOutParameter("O_RTN",    	Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG", 	Types.VARCHAR)
		};

		// procedure 호출
		return callProcedure(callProcName, sqlParameter, inParam);
	}
	/**
	 * 쿠폰회수 내역 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponWithdrawDAO.insert", mapParam);
	}
	
	/**
	 * 쿠폰회수 내역 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponWithdrawDAO.update", mapParam);
	}
	
	/**
	 * 쿠폰회수 내역 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponWithdrawDAO.delete", mapParam);
	}
	
}
