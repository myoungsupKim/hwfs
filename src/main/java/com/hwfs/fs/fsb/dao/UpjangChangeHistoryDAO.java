package com.hwfs.fs.fsb.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장이력조회하는 UpjangChangeHistory DAO
 * 
 * @ClassName UpjangPackHistoryDAO.java
 * @Description UpjangPackHistoryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsb/upjangChangeHistoryDAO")
public class UpjangChangeHistoryDAO extends DefaultDAO {
	
	/**
	 * 회계정보,운영현황,운영정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangChangeHistory(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangChangeHistoryDAO.selectUpjangChangeHistory", mapParam);
	}
	
	/**
	 * 식단가현황 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMpriceInfoHistory(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangChangeHistoryDAO.selectMpriceInfoHistory", mapParam);
	}	
}
