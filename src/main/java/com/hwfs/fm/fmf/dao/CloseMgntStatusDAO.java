package com.hwfs.fm.fmf.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 마감관리현황(브랜드) 조회하는 CloseMgntStatus DAO
 * 
 * @ClassName CloseMgntStatusDAO.java
 * @Description CloseMgntStatusDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.03.10   ksm        최초생성
 * 
 * </pre>
 * @author ksm
 * @since 2022.03.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmf/closeMgntStatusDAO")
public class CloseMgntStatusDAO extends DefaultDAO {
	
	/**
	 * 마감관리현황(브랜드) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.closeMgntStatusDAO.selectList", mapParam);
	}
	
	/**
	 * 마감관리현황(브랜드) 브랜드유통 관리부서 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBrandTm(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.closeMgntStatusDAO.selectBrandTm", mapParam);
	}

	/**
	 * 마감관리현황(브랜드)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.closeMgntStatusDAO.update", mapParam);
	}	
}
