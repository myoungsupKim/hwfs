package com.hwfs.sm.spm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 선수금을 대체처리하는 AdvanceAlterPop DAO
 * 
 * @ClassName AdvanceAlterPopDAO.java
 * @Description AdvanceAlterPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.02   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.04.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/spm/advanceAlterPopDAO")
public class AdvanceAlterPopDAO extends DefaultDAO {

	/**
	 * 선수금 대체번호에 따른 선수금대체정보(조회조건)를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet getAdvanceAltMst(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.spm.advanceAlterPopDAO.getAdvanceAltMst", mapParam);
	}
	
	/**
	 * 선수금대체처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.spm.advanceAlterPopDAO.selectList", mapParam);
	}

}
