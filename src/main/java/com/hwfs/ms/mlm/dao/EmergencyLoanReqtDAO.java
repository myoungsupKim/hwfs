package com.hwfs.ms.mlm.dao;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 임시여신신청하는 EmergencyLoanReqt DAO
 * 
 * @ClassName EmergencyLoanReqtDAO.java
 * @Description EmergencyLoanReqtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.31   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.03.31
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/mlm/emergencyLoanReqtDAO")
public class EmergencyLoanReqtDAO extends DefaultDAO {
	
	/**
	 * 임시여신신청 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mlm.emergencyLoanReqtDAO.selectList", mapParam);
	}
	
	/**
	 * 임시여신신청 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectHistList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mlm.emergencyLoanReqtDAO.selectHistList", mapParam);
	}

	/**
	 * 임시여신신청(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mlm.emergencyLoanReqtDAO.insert", mapParam);
	}
	
	/**
	 * 임시여신신청(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mlm.emergencyLoanReqtDAO.update", mapParam);
	}
	
	/**
	 * 임시여신신청(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mlm.emergencyLoanReqtDAO.delete", mapParam);
	}	
	
}
