package com.hwfs.fm.fmc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 클레임결과조회하는 ClaimResultSearch DAO
 * 
 * @ClassName ClaimResultSearchDAO.java
 * @Description ClaimResultSearchDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.29   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통하영업 최영준
 * @since 2015.05.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmc/claimResultSearchDAO")
public class ClaimResultSearchDAO extends DefaultDAO {
	
	/**
	 * 클레임결과조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimResultSearchDAO.selectList", mapParam);
	}
	
	/**
	 * 클레임결과조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet fmSelectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimResultSearchDAO.fmSelectList", mapParam);
	}

	/**
	 * 클레임결과조회(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimResultSearchDAO.insert", mapParam);
	}
	
	/**
	 * 클레임결과조회(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimResultSearchDAO.update", mapParam);
	}
	
	/**
	 * 클레임결과조회(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimResultSearchDAO.delete", mapParam);
	}
	
}
