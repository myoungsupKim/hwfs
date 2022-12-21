package com.hwfs.fm.fmc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 클레임처리현황하는 ClaimProcStatus DAO
 * 
 * @ClassName ClaimProcStatusDAO.java
 * @Description ClaimProcStatusDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.28   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.05.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmc/claimProcStatusDAO")
public class ClaimProcStatusDAO extends DefaultDAO {
	
	/**
	 * 클레임처리현황 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimProcStatusDAO.selectList", mapParam);
	}

	/**
	 * 클레임처리현황(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimProcStatusDAO.insert", mapParam);
	}
	
	/**
	 * 클레임처리현황(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimProcStatusDAO.update", mapParam);
	}
	
	/**
	 * 클레임처리현황(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimProcStatusDAO.delete", mapParam);
	}
	
	/**
	 * 창고 목록을 조회한다.
	 *
	 * @return
	 */
	public RecordSet subinvSearch(Map <String, Object> parm) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimProcStatusDAO.subinvSearch", parm);
	}
	
	/**
	 * 반품자재 목록을 조회한다.
	 *
	 * @return
	 */
	public RecordSet returnItemSearch(Map <String, Object> parm) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimProcStatusDAO.returnItemSearch", parm);
	}
	
	
	
}
