package com.hwfs.sm.ssi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사업장별 & 메뉴코드별 계정관리하는 AcctMgntbyMenu DAO
 * 
 * @ClassName AcctMgntbyMenuDAO.java
 * @Description AcctMgntbyMenuDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.30   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.03.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/ssi/acctMgntbyMenuDAO")
public class AcctMgntbyMenuDAO extends DefaultDAO {
	
	/**
	 * 사업장별 & 메뉴코드별 계정 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList() throws Exception {
		return super.queryForRecordSet("sm.ssi.acctMgntbyMenuDAO.selectList", "");
	}

	/**
	 * 사업장별 & 메뉴코드별 계정(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.acctMgntbyMenuDAO.insert", mapParam);
	}
	
	/**
	 * 사업장별 & 메뉴코드별 계정(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.acctMgntbyMenuDAO.update", mapParam);
	}
	
	/**
	 * 사업장별 & 메뉴코드별 계정(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.acctMgntbyMenuDAO.delete", mapParam);
	}
	
}
