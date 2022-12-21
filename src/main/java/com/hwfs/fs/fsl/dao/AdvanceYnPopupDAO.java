package com.hwfs.fs.fsl.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 선수금 선택하는 AdvanceYnPopup DAO
 * 
 * @ClassName AdvanceYnPopupDAO.java
 * @Description AdvanceYnPopupDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.30   	이지운        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 이지운
 * @since 2015.07.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsl/advanceYnPopupDAO")
public class AdvanceYnPopupDAO extends DefaultDAO {
	
	/**
	 * 선수금 선택 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAdvanceYnList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.advanceYnPopupDAO.selectAdvanceYnList", mapParam);
	}

	/**
	 * 선수금 선택 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAdvanceYnDetailList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.advanceYnPopupDAO.selectAdvanceYnDetailList", mapParam);
	}
	
}
