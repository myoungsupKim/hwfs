package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 채권채무 상계처리하는 ArDebitOffsetClearPop DAO
 * 
 * @ClassName ArDebitOffsetClearPopDAO.java
 * @Description ArDebitOffsetClearPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.27   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/arDebitOffsetClearPopDAO")
public class ArDebitOffsetClearPopDAO extends DefaultDAO {
	
	/**
	 * 채권채무 상계처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.arDebitOffsetClearPopDAO.selectList", mapParam);
	}

	/**
	 * 채권채무 상계처리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arDebitOffsetClearPopDAO.insert", mapParam);
	}
	
	/**
	 * 채권채무 상계처리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arDebitOffsetClearPopDAO.update", mapParam);
	}
	
	/**
	 * 채권채무 상계처리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arDebitOffsetClearPopDAO.delete", mapParam);
	}
	
}
