package com.hwfs.fm.fmc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 클레임접수하는 ClaimAccept DAO
 * 
 * @ClassName ClaimAcceptDAO.java
 * @Description ClaimAcceptDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.13   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.05.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmc/claimAcceptDAO")
public class ClaimAcceptDAO extends DefaultDAO {
	
	/**
	 * 업장별 창고리스트 목록을 조회한다.
	 * @param mapParam
	 * @return	
	 */
	public RecordSet selectItemClass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimAcceptDAO.selectItemClass", mapParam);
	}
	/**
	 * 클레임접수 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimAcceptDAO.selectList", mapParam);
	}
	
	/**
	 * CS사원을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet checkCS(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimAcceptDAO.checkCS", mapParam);
	}

	/**
	 * 클레임접수(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimAcceptDAO.insert", mapParam);
	}
	
	/**
	 * 클레임접수(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimAcceptDAO.update", mapParam);
	}
	
	/**
	 * 클레임접수 확정(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateFix(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimAcceptDAO.updateFix", mapParam);
	}
	
	/**
	 * 클레임접수(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimAcceptDAO.delete", mapParam);
	}
	
	/**
	 * 클레임접수(을)를 여부를 확인한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String ticketFlag(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fm.fmc.claimAcceptDAO.ticketFlag", mapParam, null);
	}
	
}
