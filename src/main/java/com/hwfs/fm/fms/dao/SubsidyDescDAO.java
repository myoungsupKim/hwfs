package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 장려금내역하는 SubsidyDesc DAO
 * 
 * @ClassName SubsidyDescDAO.java
 * @Description SubsidyDescDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.03   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.07.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/subsidyDescDAO")
public class SubsidyDescDAO extends DefaultDAO {
	
	/**
	 * 장려금내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.subsidyDescDAO.selectList", mapParam);
	}
	
	/**
	 * 장려금내역 Sub 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.subsidyDescDAO.selectSubList", mapParam);
	}

	/**
	 * 장려금내역(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.subsidyDescDAO.insert", mapParam);
	}
	
	/**
	 * 장려금내역(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.subsidyDescDAO.update", mapParam);
	}
	
	/**
	 * 장려금내역(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.subsidyDescDAO.delete", mapParam);
	}
	
}
