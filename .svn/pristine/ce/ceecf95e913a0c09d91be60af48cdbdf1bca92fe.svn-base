package com.hwfs.ms.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 모바일 공통 서비스하는 MobileCommon DAO
 * 
 * @ClassName MobileCommonDAO.java
 * @Description MobileCommonDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.13   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.04.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/cmn/mobileCommonDAO")
public class MobileCommonDAO extends DefaultDAO {
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.cmn.mobileCommonDAO.selectList", mapParam);
	}
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMenuAuthList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.cmn.mobileCommonDAO.selectMenuAuthList", mapParam);
	}

	/**
	 * 수신된 PUSH알림 검색.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPushList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.cmn.mobileCommonDAO.selectPushList", mapParam);
	}	
	
	/**
	 * PUSH알림 전송.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.cmn.mobileCommonDAO.insert", mapParam);
	}	
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMenuList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.cmn.mobileCommonDAO.selectMenuList", mapParam);
	}
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectComboAuthMenuList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.cmn.mobileCommonDAO.selectComboAuthMenuList", mapParam);
	}
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDualUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.cmn.mobileCommonDAO.selectDualUpjangList", mapParam);
	}
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectLimsAuthLevels(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.cmn.mobileCommonDAO.selectLimsAuthLevels", mapParam);
	}

}
