package com.hwfs.fm.fmf.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 일마감관리하는 ClosingBooks DAO
 * 
 * @ClassName ClosingBooksDAO.java
 * @Description ClosingBooksDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.09.13    김명섭        최초생성
 * </pre>
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmf/closingBooksDAO")
public class ClosingBooksDAO extends DefaultDAO {
	
	/**
	 * 프로시져호출
	 *
	 * @param inParam
	 * @param callProcName
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> callProcedure(Map<String, Object> inParam, String callProcName) throws Exception{
		//전달 순서대로 생성
		SqlParameter[] sqlParameter = new SqlParameter[]{
			new SqlParameter("P_UPJANGCD",  Types.VARCHAR),
			new SqlParameter("P_STARTYMD",  Types.VARCHAR),
			new SqlParameter("P_ENDYMD",    Types.VARCHAR),
			new SqlParameter("P_RECVNAME",  Types.VARCHAR),
			new SqlParameter("P_RECVNUM",   Types.VARCHAR),
			new SqlParameter("P_CUSER",     Types.VARCHAR),
			new SqlOutParameter("O_RTN",    Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
		};
		
		// Procedure Call
		return callProcedure(callProcName, sqlParameter, inParam);
	}

}
