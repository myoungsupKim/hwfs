package com.hwfs.sc.sch.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사용자 권한변경 이력을 조회하는 UserAuthChngLog DAO
 * 
 * @ClassName UserAuthChngLogDAO.java
 * @Description UserAuthChngLogDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.02   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.10.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/sch/userAuthChngLogDAO")
public class UserAuthChngLogDAO extends DefaultDAO {
	
	/**
	 * 사용자 권한변경 이력 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.sch.userAuthChngLogDAO.selectList", mapParam);
	}

	/**
	 * 사용자 권한변경 이력(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.sch.userAuthChngLogDAO.insert", mapParam);
	}
	
	/**
	 * 사용자 권한변경 이력(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.sch.userAuthChngLogDAO.update", mapParam);
	}
	
	/**
	 * 사용자 권한변경 이력(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.sch.userAuthChngLogDAO.delete", mapParam);
	}
	
}
