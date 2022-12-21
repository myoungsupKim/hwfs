package com.hwfs.fs.fso.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 물건정보조회하는 ObjectInfoRept DAO
 * 
 * @ClassName ObjectInfoReptDAO.java
 * @Description ObjectInfoReptDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.20   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.08.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fso/objectInfoReptDAO")
public class ObjectInfoReptDAO extends DefaultDAO {
	
	/**
	 * 물건정보조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectObjectInfoReptList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.objectInfoReptDAO.selectObjectInfoReptList", mapParam);
	}

	/**
	 * 물건정보조회(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.objectInfoReptDAO.insert", mapParam);
	}
	
	/**
	 * 물건정보조회(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.objectInfoReptDAO.update", mapParam);
	}
	
	/**
	 * 물건정보조회(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.objectInfoReptDAO.delete", mapParam);
	}
	
}
