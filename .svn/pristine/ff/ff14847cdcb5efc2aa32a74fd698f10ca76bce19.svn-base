package com.hwfs.ms.mlm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 임시여신승인하는 EmergencyLoanApp DAO
 * 
 * @ClassName EmergencyLoanAppDAO.java
 * @Description EmergencyLoanAppDAO Class
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
@Repository("/ms/mlm/emergencyLoanAppDAO")
public class EmergencyLoanAppDAO extends DefaultDAO {
	
	/**
	 * 임시여신승인 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mlm.emergencyLoanAppDAO.selectList", mapParam);
	}	
	
	/**
	 * 임시여신승인시 업장 여신정보변경시 수정
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mlm.emergencyLoanAppDAO.updateUpjang", mapParam);
	}
	
	/**
	 * 임시여신승인시 여신정보 수정
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateCreditMobile(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mlm.emergencyLoanAppDAO.updateCreditMobile", mapParam);
	}
	
	/**
	 * 반려처리
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReturnUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mlm.emergencyLoanAppDAO.updateReturnUpjang", mapParam);
	}
	
	/**
	 * 반려처리
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReturnCreditMobile(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mlm.emergencyLoanAppDAO.updateReturnCreditMobile", mapParam);
	}
	
	/**
	 * 임시여신승인 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet saveChk(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mlm.emergencyLoanAppDAO.saveChk", mapParam);
	}	
	
	
	
}
