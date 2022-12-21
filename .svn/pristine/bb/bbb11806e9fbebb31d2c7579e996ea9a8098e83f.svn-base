package com.hwfs.rc.roa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * HELPER 등급 코드를 관리하는 HelperGradeCd DAO
 * 
 * @ClassName HelperGradeCdDAO.java
 * @Description HelperGradeCdDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.20   	유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.03.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/roa/helperGradeCdDAO")
public class HelperGradeCdDAO extends DefaultDAO {
	
	/**
	 * HELPER 등급 코드 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.helperGradeCdDAO.selectList", mapParam);
	}
	
	/**
	 * HELPER 등급 코드 중복체크를 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectExists(Map<String, Object> mapParam) throws Exception{
		return super.queryForInt("rc.roa.helperGradeCdDAO.selectExists", mapParam);
	}

	/**
	 * HELPER 등급 코드(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.helperGradeCdDAO.insert", mapParam);
	}
	
	/**
	 * HELPER 등급 코드(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.helperGradeCdDAO.update", mapParam);
	}
	
	/**
	 * HELPER 등급 코드(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.helperGradeCdDAO.delete", mapParam);
	}
	
}
