package com.hwfs.sc.scz.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 조직을 보정작업을하는 OrgRevision DAO
 * 
 * @ClassName OrgRevisionDAO.java
 * @Description OrgRevisionDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.27   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.07.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scz/orgRevisionDAO")
public class OrgRevisionDAO extends DefaultDAO {
	
	/**
	 * 조직 보정 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.orgRevisionDAO.selectList", mapParam);
	}

	/**
	 * 조직 보정(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.orgRevisionDAO.insert", mapParam);
	}
	
	/**
	 * 조직 보정(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.orgRevisionDAO.update", mapParam);
	}
	
	/**
	 * 조직 보정(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.orgRevisionDAO.delete", mapParam);
	}
	
}
