package com.hwfs.sc.cmn.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 그룹웨어 연동하는 GwIf DAO
 * 
 * @ClassName GwIfDAO.java
 * @Description GwIfDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.03.18
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/gwIfDAO")
public class GwIfDAO extends DefaultDAO {
	
	/**
	 * 그룹웨어 연동 테이블 SIGN_IF.TB_EVT_INFO에서 미처리된 건을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUntreatedList() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object> ();
		return super.queryForRecordSet("sc.cmn.gwIfDAO.selectUntreatedList", mapParam);
	}

	/**
	 * 그룹웨어 연동 테이블 SIGN_IF.TB_EVT_INFO에서 처리정보를 수정한다.
	 *
	 * @param record
	 * @return
	 */
	public int updateTreated(Record record) throws Exception {
		return super.update("sc.cmn.gwIfDAO.updateTreated", record);
	}

	/**
	 * 전자결재진행정보를 Insert or Update한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveSignInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.gwIfDAO.saveSignInfo", mapParam);
	}

	/**
	 * 전자결재진행정보를 Insert or Update한다.
	 *
	 * @param record
	 * @return
	 */
	public int saveSignInfo(Record record) throws Exception {
		return super.update("sc.cmn.gwIfDAO.saveSignInfo", record);
	}

//	/**
//	 * 그룹웨어 연동 목록을 조회한다.
//	 *
//	 * @param mapParam
//	 * @return
//	 */
//	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
//		return super.queryForRecordSet("sc.cmn.gwIfDAO.selectList", mapParam);
//	}

//	/**
//	 * 그룹웨어 연동(을)를 등록한다.
//	 *
//	 * @param mapParam
//	 * @return
//	 */
//	public int insert(Map<String, Object> mapParam) throws Exception {
//		return super.update("sc.cmn.gwIfDAO.insert", mapParam);
//	}
	
	
//	/**
//	 * 그룹웨어 연동(을)를 삭제한다.
//	 *
//	 * @param mapParam
//	 * @return
//	 */
//	public int delete(Map<String, Object> mapParam) throws Exception {
//		return super.update("sc.cmn.gwIfDAO.delete", mapParam);
//	}
	
}
