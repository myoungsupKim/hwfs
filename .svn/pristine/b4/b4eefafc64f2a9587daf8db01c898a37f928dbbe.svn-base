package com.hwfs.fs.fsa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 채용사이트관리하는 AdoptionSiteList DAO
 * 
 * @ClassName AdoptionSiteListDAO.java
 * @Description AdoptionSiteListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.24   	yanghj        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합엽업 yanghj
 * @since 2015.03.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsa/adoptionSiteListDAO")
public class AdoptionSiteListDAO extends DefaultDAO {
	
	/**
	 * 채용사이트관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionSiteListDAO.selectList", mapParam);
	}

	/**
	 * 채용사이트관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionSiteListDAO.insert", mapParam);
	}
	
	/**
	 * 채용사이트관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionSiteListDAO.update", mapParam);
	}
	
	/**
	 * 채용사이트관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionSiteListDAO.delete", mapParam);
	}
	
}
