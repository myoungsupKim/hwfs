package com.hwfs.sm.ssi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;
import java.math.BigDecimal;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사용자별 업장 권한 관리하는 UserUpjangAuthMgnt DAO
 * 
 * @ClassName UserUpjangAuthMgntDAO.java
 * @Description UserUpjangAuthMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.03   	유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.07.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/ssi/userUpjangAuthMgntDAO")
public class UserUpjangAuthMgntDAO extends DefaultDAO {
	
	/**
	 * 사용자별 업장 권한 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.ssi.userUpjangAuthMgntDAO.selectList", mapParam);
	}
	
	/**
	 * 사업부별 업장 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCcList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.ssi.userUpjangAuthMgntDAO.selectCcList", mapParam);
	}
	
	/**
	 * 사용자 존재여부
	 *
	 * @param mapParam
	 * @return int
	 */
	public int selectCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("sm.ssi.userUpjangAuthMgntDAO.selectCnt", mapParam);
	}

	/**
	 * 사용자별 업장 권한 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.userUpjangAuthMgntDAO.insert", mapParam);
	}
	
	/**
	 * 사용자별 업장 권한 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.userUpjangAuthMgntDAO.update", mapParam);
	}
	
	/**
	 * 사용자별 업장 권한 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.userUpjangAuthMgntDAO.delete", mapParam);
	}
	
}
