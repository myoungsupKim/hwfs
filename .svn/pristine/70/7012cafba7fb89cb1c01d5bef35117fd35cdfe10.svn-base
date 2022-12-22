package com.hwfs.rc.roa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * HELPER 지원 내역을 관리하는 HelperSupport DAO
 * 
 * @ClassName HelperSupportDAO.java
 * @Description HelperSupportDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.23   	유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.03.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/roa/helperSupportDAO")
public class HelperSupportDAO extends DefaultDAO {
	
	/**
	 * HELPER 지원 내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.helperSupportDAO.selectList", mapParam);
	}
	
	/**
	 * HELPER 지원 내역 중복을 체크한다. 
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectExists(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("rc.roa.helperSupportDAO.selectExists", mapParam);
	}

	/**
	 * HELPER 지원 내역(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.helperSupportDAO.insert", mapParam);
	}
	
	/**
	 * HELPER 지원 내역(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.helperSupportDAO.update", mapParam);
	}
	
	/**
	 * HELPER 지원 내역(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.helperSupportDAO.delete", mapParam);
	}
	
}
