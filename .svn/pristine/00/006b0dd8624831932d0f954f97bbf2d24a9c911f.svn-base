package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.sc.cmn.dto.SmsDTO;

/**
 * 배송처검색하는 TransMgmt DAO
 *
 * @ClassName TransMgmtDAO.java
 * @Description TransMgmtDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.11.16   	kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : COM kihoon
 * @since 2017.11.16
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/transMgmtDAO")
public class TransMgmtDAO extends DefaultDAO {

	/**
	 * 배송처검색 목록 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.transMgmtDAO.selectList", mapParam);
	}
	
	/**
	 * 사전 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCheck(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.transMgmtDAO.selectCheck", mapParam);
	}
	
	/**
	 * 저장
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveList(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.transMgmtDAO.saveList", mapParam);
	}
	
	/**
	 * 영업 주소정보 저장
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> callAddrProcedure(Map<String, Object> inParam, String callProcName) throws Exception {
		//전달 순서대로 설정
		SqlParameter[] sqlParameter = new SqlParameter[] {
		    new SqlParameter("P_OCCUR_DATE",    Types.VARCHAR),
		    new SqlParameter("P_SYS_CLASS",    	Types.VARCHAR),
		    new SqlOutParameter("O_RTN",    	Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG", 	Types.VARCHAR)
		};

		// procedure 호출
		return callProcedure(callProcName, sqlParameter, inParam);
	}
}
