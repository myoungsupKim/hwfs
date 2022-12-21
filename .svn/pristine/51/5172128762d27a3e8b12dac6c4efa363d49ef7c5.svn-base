package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.cmn.service.PropertiesService;

 /**
 *  SMS발송 관리 SendSmsMgmt DAO
 * 
 * @ClassName SendSmsMgmtDAO.java
 * @Description SendSmsMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.07.25   	kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 kihoon
 * @since 2016.07.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2016 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/smsSendMgmtDAO")
public class SmsSendMgmtDAO extends DefaultDAO {
	
	/** PropertyService DI */
	@Resource(name = "propertiesService")
	protected PropertiesService propertiesService;
	
	/**
	 * 업장목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.smsSendMgmtDAO.selectList", mapParam);
	}
	
	/**
	 * 고객목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCustList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.smsSendMgmtDAO.selectCustList", mapParam);
	}
	
	/**
	 * SMS목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSmsLogList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.smsSendMgmtDAO.selectSmsLogList", mapParam);
	}
	
	/**
	 * SMS 발송로그를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSmsLog(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.smsSendMgmtDAO.insertSmsLog", mapParam);
	}
	
	/**
	 * LMS목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	/*
	public RecordSet selectLmsMgmtList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.smsSendMgmtDAO.selectLmsMgmtList", mapParam);
	}
	*/
}
