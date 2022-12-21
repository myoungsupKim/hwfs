package com.hwfs.sm.spm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 잡이익/이자수익 처리하는 SuspenseAlter DAO
 * 
 * @ClassName SuspenseAlterDAO.java
 * @Description SuspenseAlterDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.12   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/spm/suspenseAlterDAO")
public class SuspenseAlterDAO extends DefaultDAO {
	
	/**
	 * 잡이익/이자수익을 처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.spm.suspenseAlterDAO.selectList", mapParam);
	}

	/**
	 * 잡이익/이자수익을 처리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.spm.suspenseAlterDAO.insert", mapParam);
	}
	
	/**
	 * 잡이익/이자수익을 처리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.spm.suspenseAlterDAO.update", mapParam);
	}
	
	/**
	 * 잡이익/이자수익을 처리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.spm.suspenseAlterDAO.delete", mapParam);
	}
	
}
