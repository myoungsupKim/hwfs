package com.hwfs.sc.scu.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 가사번 사용자를 관리하는 TempUserMgmt DAO
 * 
 * @ClassName TempUserMgmtDAO.java
 * @Description TempUserMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.02   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.10.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scu/tempUserMgmtDAO")
public class TempUserMgmtDAO extends DefaultDAO {
	
	/**
	 * 가사번 사용자 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.tempUserMgmtDAO.selectList", mapParam);
	}

	public RecordSet selectOrgInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.tempUserMgmtDAO.selectOrgInfo", mapParam);
	}
	
	public RecordSet selectCreateTempSabun(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.tempUserMgmtDAO.selectCreateTempSabun", mapParam);
	}
	
	/**
	 * 가사번 사용자(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSccUserInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.tempUserMgmtDAO.insertSccUserInfo", mapParam);
	}
	
	/**
	 * 가사번 사용자(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSccUserInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.tempUserMgmtDAO.updateSccUserInfo", mapParam);
	}
	
	/**
	 * 가사번 사용자(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertHrPersonal(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.tempUserMgmtDAO.insertHrPersonal", mapParam);
	}
	
	/**
	 * 가사번 사용자(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateHrPersonal(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.tempUserMgmtDAO.updateHrPersonal", mapParam);
	}
	
	
	/**
	 * 가사번 사용자(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSccUserAuthlevel(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.tempUserMgmtDAO.insertSccUserAuthlevel", mapParam);
	}
	
	public int deleteSccUserAuthlevel(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scu.tempUserMgmtDAO.deleteSccUserAuthlevel", mapParam);
	}
	
}
