package com.hwfs.fs.fse.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 등록된 업장을 승인하는 EventApproval DAO
 * 
 * @ClassName EventApprovalDAO.java
 * @Description EventApprovalDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.28   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.07.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fse/eventApprovalDAO")
public class EventApprovalDAO extends DefaultDAO {
	
	/**
	 * 업장승인 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.eventApprovalDAO.selectList", mapParam);
	}
	
	/**
	 * 업장승인(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fse.eventApprovalDAO.update", mapParam);
	}
	
	public RecordSet selectLog(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fse.eventApprovalDAO.selectLog", mapParam);
	}
}
