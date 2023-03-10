package com.hwfs.fm.fmo.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 여신관련 상세정보를 조회하는 CreditDetailView DAO
 * 
 * @ClassName CreditDetailViewDAO.java
 * @Description CreditDetailViewDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.14   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.10.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmo/creditDetailViewDAO")
public class CreditDetailViewDAO extends DefaultDAO {
	
	/**
	 * 여신 기본정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjang(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.creditDetailViewDAO.selectUpjang", mapParam);
	}
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.creditDetailViewDAO.selectList"+mapParam.get("tabIndex"), mapParam);
	}

	/**
	 * 여신 상세정보를 조회(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.creditDetailViewDAO.insert", mapParam);
	}
	
	/**
	 * 여신 상세정보를 조회(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.creditDetailViewDAO.update", mapParam);
	}
	
	/**
	 * 여신 상세정보를 조회(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.creditDetailViewDAO.delete", mapParam);
	}

	/**
	 * 여신 상세정보를 보정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> callProcedure(Map<String, Object> inParam, String callProcName) throws Exception{
		//전달 순서대로 생성
		SqlParameter[] sqlParameter = new SqlParameter[]{
			new SqlParameter("P_UPJANG_CD", Types.VARCHAR),
			new SqlParameter("P_WKGUBUN",   Types.VARCHAR),
			new SqlParameter("P_WKUSER",    Types.VARCHAR),
			new SqlOutParameter("O_RTN",    Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
		};
		
		// Procedure Call
		return callProcedure(callProcName, sqlParameter, inParam);
	}
	
	
	
	public RecordSet selectCreditSumList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.creditDetailViewDAO.selectCreditSumList", mapParam);
	}
	
}
