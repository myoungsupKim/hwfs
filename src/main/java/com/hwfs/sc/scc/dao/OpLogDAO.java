package com.hwfs.sc.scc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 운영로그 내역을 관리하는 OpLog DAO
 * 
 * @ClassName OpLogDAO.java
 * @Description OpLogDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.13   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scc/opLogDAO")
public class OpLogDAO extends DefaultDAO {
	
	/**
	 * 운영로그 내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scc.opLogDAO.selectList", mapParam);
	}

	/**
	 * 운영로그 내역(을)를 삭제한다.
	 * <pre>
	 * - 특정 로그를 삭제
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.opLogDAO.delete", mapParam);
	}

	/**
	 * 전일 운영로그 내역 전체(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteDayBefore(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.opLogDAO.deleteDayBefore", mapParam);
	}

}
