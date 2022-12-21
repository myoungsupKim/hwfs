package com.hwfs.sc.app.dao;

import java.sql.Types;
import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 재고조회 인터페이스용  DAO 개체
 * @ClassName InventoryDAO.java
 * @Description  InventoryDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.09.02.   김명섭        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.09.02.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/app/inventoryDAO")
public class InventoryDAO extends DefaultDAO {
	
	/**
	 * 물류센터 정보 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCenterInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.inventoryDAO.selectCenterInfo", parameter);
	}

	/**
	 * 물류센터 재고 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectInventoryInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.inventoryDAO.selectInventoryInfo", parameter);
	}

	/**
	 * 사업장관리자재조회체크 프로시져호출
	 *
	 * @param inParam
	 * @param callProcName
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> callAppUpjangProcedure(Map<String, Object> inParam, String callProcName) throws Exception{
		//전달 순서대로 생성
		SqlParameter[] sqlParameter = new SqlParameter[]{
			new SqlParameter("P_UPJANG_CODE", Types.VARCHAR),
			new SqlParameter("P_SUBINV_CODE", Types.VARCHAR),
			new SqlParameter("P_REQ_DATE",    Types.VARCHAR),
			new SqlOutParameter("O_RTN",      Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",   Types.VARCHAR),
            new SqlOutParameter("O_CLSYYMM",  Types.VARCHAR),
            new SqlOutParameter("O_PHYSICBDT",Types.VARCHAR)
		};
		
		// Procedure Call
		return callProcedure(callProcName, sqlParameter, inParam);
	}

	/**
	 * 사업장관리자재저장체크 프로시져호출
	 *
	 * @param inParam
	 * @param callProcName
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> callAppSaveChkProcedure(Map<String, Object> inParam, String callProcName) throws Exception{
		//전달 순서대로 생성
		SqlParameter[] sqlParameter = new SqlParameter[]{
			new SqlParameter("P_UPJANG_CODE", Types.VARCHAR),
			new SqlParameter("P_SUBINV_CODE", Types.VARCHAR),
			new SqlParameter("P_REQ_DATE",    Types.VARCHAR),
			new SqlParameter("P_STATS",       Types.VARCHAR),
			new SqlOutParameter("O_RTN",      Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",   Types.VARCHAR),
            new SqlOutParameter("O_GRPCD",    Types.VARCHAR)
		};
		
		// Procedure Call
		return callProcedure(callProcName, sqlParameter, inParam);
	}

	/**
	 * 사업장관리자재저장 프로시져호출
	 *
	 * @param inParam
	 * @param callProcName
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> callAppSaveProcedure(Map<String, Object> inParam, String callProcName) throws Exception{
		//전달 순서대로 생성
		SqlParameter[] sqlParameter = new SqlParameter[]{
			      new SqlParameter("P_UPJANG_CODE"     , Types.VARCHAR),
			      new SqlParameter("P_SUBINV_CODE"     , Types.VARCHAR),
			      new SqlParameter("P_REQ_DATE"        , Types.VARCHAR),
			      new SqlParameter("P_PO_UOM"          , Types.VARCHAR),
			      new SqlParameter("P_STATS"           , Types.VARCHAR),
			      new SqlParameter("P_GRP_CD"          , Types.VARCHAR),
			      new SqlParameter("P_ITEM_CODE"       , Types.VARCHAR),
			      new SqlParameter("P_UOM_CONVERT_RATE", Types.VARCHAR),
			      new SqlParameter("P_M_STK_QTY"       , Types.VARCHAR),
			      new SqlParameter("P_M_STK_QTY_ORG"   , Types.VARCHAR),
			      new SqlParameter("P_U_STK_PRICE"     , Types.VARCHAR),
			      new SqlParameter("P_M_STK_PRICE"     , Types.VARCHAR),
			      new SqlParameter("P_M_REAL_QTY"      , Types.VARCHAR),
			      new SqlParameter("P_M_USE_QTY"       , Types.VARCHAR),
			      new SqlParameter("P_U_STK_AMT"       , Types.VARCHAR),
			      new SqlParameter("P_M_STK_AMT"       , Types.VARCHAR),
			      new SqlParameter("P_U_USE_AMT"       , Types.VARCHAR),
			      new SqlParameter("P_M_USE_AMT"       , Types.VARCHAR),
			      new SqlParameter("P_VALUE_DATE_INFO" , Types.VARCHAR),
			      new SqlParameter("P_VALUE_DATE"      , Types.VARCHAR),
			      new SqlParameter("P_MAKER_DATE"      , Types.VARCHAR),
			      new SqlParameter("P_TAX_CODE"        , Types.VARCHAR)
		};
		
		// Procedure Call
		return callProcedure(callProcName, sqlParameter, inParam);
	}
	
	/**
	 * 사업장 재고 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet upjangInventoryInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.inventoryDAO.upjangInventoryInfo", parameter);
	}
	
	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.inventoryDAO.logInsert", parameter);
	}
	
}
