package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 표준레시피 코드를 관리하는 StandardRecipeMasterMgnt DAO
 * 
 * @ClassName StandardRecipeMasterMgntDAO.java
 * @Description StandardRecipeMasterMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.30   	유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.03.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/standardRecipeMasterMgntDAO")
public class StandardRecipeMasterMgntDAO extends DefaultDAO {
	
	/**
	 * 표준레시피 코드 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeMasterMgntDAO.selectList", mapParam);
	}
	
	/**
	 * 표준레시피 코드 max+1 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Object selectMaxStdRecipeCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForObject("rc.rrm.standardRecipeMasterMgntDAO.selectMaxStdRecipeCd", mapParam, null);
	}

	/**
	 * 표준레시피 코드(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntDAO.insert", mapParam);
	}
	
	/**
	 * 표준레시피 코드(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntDAO.update", mapParam);
	}
	
	/**
	 * 표준레시피 코드(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntDAO.deleteMst", mapParam);
	}
	
	
	/**
	 * 표준레시피 코드(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntDAO.deleteDetail", mapParam);
	}
	
	/**
	 * 표준레시피 수정시 업장 레시피를 일괄 수정한다.
	 * - 업장수정허용여부가 'N'인것만 수정
	 * @param mapParam
	 * @return
	 */
	public int updateUpjangRecipeMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntDAO.updateUpjangRecipeMst", mapParam);
	}
	
	/**
	 * 반찬 세트류 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectRsr(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeMasterMgntDAO.selectRsr", mapParam);
	}

	/**
	 * 업장레시피를 삭제한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjangRecipeMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntDAO.deleteUpjangRecipeMst", mapParam);
	}

	/**
	 * 업장레시피 상세를 삭제한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjangRecipeDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntDAO.deleteUpjangRecipeDtl", mapParam);
	}

	/**
	 * 업장레시피를 등록한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public int insertUpjangRecipeMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntDAO.insertUpjangRecipeMst", mapParam);
	}

	/**
	 * 업장레시피 상세를 등록한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public int insertUpjangRecipeDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeMasterMgntDAO.insertUpjangRecipeDtl", mapParam);
	}

	/**
	 * 대상 레시피를 사용중인 업장 목록을 조회한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangList(Map<String, Object> mapParam) {
		return super.queryForRecordSet("rc.rrm.standardRecipeMasterMgntDAO.selectUpjangList", mapParam);
	}
}
