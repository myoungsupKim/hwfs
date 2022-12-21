package com.hwfs.fs.fse.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 이벤트 조회 팝업하는 EventPop DAO
 * 
 * @ClassName EventPopDAO.java
 * @Description EventPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.11   	남기빈        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 남기빈
 * @since 2015.03.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fse/eventPopDAO")
public class EventPopDAO extends DefaultDAO {
	
	/**
	 * 이벤트 Master 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectEventPopList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.eventPopDAO.selectEventPopList", mapParam);
	}

	/**
	 * 이벤트 Master 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectEventProcessInfoList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.eventPopDAO.selectEventProcessInfoList", mapParam);
	}

	/**
	 * 분류 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCodeMclass() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		return super.queryForRecordSet("fs.fse.eventPopDAO.selectCodeMclass", mapParam);
	}
	
	/**
	 * 테마 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCodeSclass() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		return super.queryForRecordSet("fs.fse.eventPopDAO.selectCodeSclass", mapParam);
	}

}
