package com.hwfs.ma.mas.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사업장 일마감 취소 기획승인 하는하는 CloseMgmt DAO
 * 
 * @ClassName CloseMgmtDAO.java
 * @Description CloseMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.17   	박준석        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 박준석
 * @since 2015.08.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ma/mas/closeMgmtDAO")
public class CloseMgmtDAO extends DefaultDAO {
	
	/**
	 * 마감취소 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> callCloseProcedure(Map<String, Object> inParam, String callProcName) throws Exception {
		//전달 순서대로 설정
		SqlParameter[] sqlParameter = new SqlParameter[] {
		    new SqlParameter("P_OCCUR_SDATE",    Types.VARCHAR),
		    new SqlParameter("P_OCCUR_EDATE",    Types.VARCHAR),
		    new SqlParameter("P_SYS_CLASS",    	Types.VARCHAR),
		    new SqlParameter("P_CLOSE_GUBUN",    	Types.VARCHAR),
		    new SqlParameter("P_UPJANG_CD",		Types.VARCHAR),
		    new SqlParameter("P_EMP_NUM",		Types.VARCHAR),
		    new SqlParameter("P_REQ_ID",		Types.VARCHAR),
            new SqlOutParameter("O_RTN",    	Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG", 	Types.VARCHAR)
		};

		// procedure 호출
		return callProcedure(callProcName, sqlParameter, inParam);
	}
	
	/**
	 * 사업장 일마감 취소 기획승인 하는 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ma.mas.closeMgmtDAO.selectList", mapParam);
	}

	/**
	 * 사업장 일마감 취소 기획승인 하는(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.mas.closeMgmtDAO.insert", mapParam);
	}
	
	/**
	 * 사업장 일마감 취소 기획승인 하는(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.mas.closeMgmtDAO.update", mapParam);
	}
	
	/**
	 * 사업장 일마감 취소 기획승인 하는(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.mas.closeMgmtDAO.delete", mapParam);
	}
	
}
