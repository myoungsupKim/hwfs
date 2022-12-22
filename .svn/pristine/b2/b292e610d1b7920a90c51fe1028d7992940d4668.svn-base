package com.hwfs.rc.rcg.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcg.dao.CouponWithdrawDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 쿠폰회수 내역 관리하는 CouponWithdraw Service Implementation
 * 
 * @ClassName CouponWithdrawServiceImpl.java
 * @Description CouponWithdrawServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.29    유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.06.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcg/couponWithdrawService")
public class CouponWithdrawServiceImpl extends DefaultServiceImpl implements CouponWithdrawService {
	
	/** CouponWithdrawDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponWithdrawDAO")
	private CouponWithdrawDAO couponWithdrawDAO;
	

	/**
	 * 쿠폰회수 내역 관리 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return couponWithdrawDAO.selectList(mapParam);
	}
	
	/**
	 * 쿠폰회수 상세 내역을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectDetail(Map<String, Object> mapParam) throws Exception {
		return couponWithdrawDAO.selectDetail(mapParam);
	}

	/**
	 * 쿠폰회수 내역 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public String saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String strRtn	= null;
		String strRtnMsg= null;
		String strRtnDate= null;
		

		Map<String, Object> inParam = new HashMap<String, Object>();
		Map<String, Object> rowData = list.get(0);
		//입력값 Setting
		inParam.put("P_OCCUR_DATE",	String.valueOf(rowData.get("occurDate")));
		inParam.put("P_COUPON_NUM",	String.valueOf(rowData.get("couponNum")));
		inParam.put("P_CC_CD",	String.valueOf(rowData.get("ccCd")));
		inParam.put("P_UPJANG_CD",	String.valueOf(rowData.get("upjangCd")));
		inParam.put("P_COUPON_AMT",	String.valueOf(rowData.get("couponAmt")));
		inParam.put("P_USE_AMT",	String.valueOf(rowData.get("useAmt")));
		inParam.put("P_EXCH_AMT",	String.valueOf(rowData.get("exchAmt")));
		inParam.put("P_REMARK",	String.valueOf(rowData.get("remark")));
				
		String callProcName = "";
		
		callProcName = "SP_SLA_COUPON_WITHDRAW";
		
		//마감취소 procedure 호출
		Map<String, Object> retVal = couponWithdrawDAO.callWithdrawProcedure(inParam, callProcName);
		
		//출력값 Setting
		strRtn		= String.valueOf(retVal.get("O_RTN"));
		strRtnMsg	= String.valueOf(retVal.get("O_RTNMSG"));
		strRtnDate	= String.valueOf(retVal.get("O_RTNDATE"));
				
				
		return strRtn + "|" + strRtnMsg + "|" + strRtnDate;

	}
	/**
	 * 쿠폰회수 내역 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public String delList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String strRtn	= null;
		String strRtnMsg= null;
		String strRtnDate= null;
		

		Map<String, Object> inParam = new HashMap<String, Object>();
		Map<String, Object> rowData = list.get(0);
		//입력값 Setting
		inParam.put("P_OCCUR_DATE",	String.valueOf(rowData.get("occurDate")));
		inParam.put("P_COUPON_NUM",	String.valueOf(rowData.get("couponNum")));
		inParam.put("P_UPJANG_CD",	String.valueOf(rowData.get("upjangCd")));
				
		String callProcName = "";
		
		callProcName = "SP_SLA_COUPON_WITHDRAW_DEL";
		
		//마감취소 procedure 호출
		Map<String, Object> retVal = couponWithdrawDAO.callWithdrawCancel(inParam, callProcName);
		
		//출력값 Setting
		strRtn		= String.valueOf(retVal.get("O_RTN"));
		strRtnMsg	= String.valueOf(retVal.get("O_RTNMSG"));
		strRtnDate	= String.valueOf(retVal.get("O_RTNDATE"));
				
				
		return strRtn + "|" + strRtnMsg + "|" + strRtnDate;

	}
}
