package com.hwfs.fs.fsa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;


 /**
 * 채용인력Pool관리하는 AdoptionPoolList DAO
 * 
 * @ClassName AdoptionPoolListDAO.java
 * @Description AdoptionPoolListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.24   	yanghj        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 yanghj
 * @since 2015.03.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsa/adoptionPoolListDAO")
public class AdoptionPoolListDAO extends DefaultDAO {
	
	/**
	 * 검색조건 시도 콤보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSido(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionPoolListDAO.selectSido", mapParam);
	}
	/**
	 * 채용인력Pool관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionPoolListDAO.selectList", mapParam);
	}

	/**
	 * 채용인력Pool관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionPoolListDAO.insert", mapParam);
	}
	
	/**
	 * 채용인력Pool관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionPoolListDAO.update", mapParam);
	}
	
	/**
	 * 채용인력Pool관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionPoolListDAO.delete", mapParam);
	}
	
}
