package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 특약사항조회하는 SpContFactSearch DAO
 * 
 * @ClassName SpContFactSearchDAO.java
 * @Description SpContFactSearchDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.02   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.07.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/spContFactSearchDAO")
public class SpContFactSearchDAO extends DefaultDAO {
	/**
	 * 특약사항조회 사용창고 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubinv(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.spContFactSearchDAO.selectSubinv", mapParam);
	}
	
	/**
	 * 특약사항조회 사용업장 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSpUpjang(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.spContFactSearchDAO.selectSpUpjang", mapParam);
	}

	/**
	 * 특약사항조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.spContFactSearchDAO.selectList", mapParam);
	}
	
	/**
	 * 특약사항조회(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactSearchDAO.insert", mapParam);
	}
	
	/**
	 * 특약사항조회(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactSearchDAO.update", mapParam);
	}
	
	/**
	 * 특약사항조회(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactSearchDAO.delete", mapParam);
	}
	
}
