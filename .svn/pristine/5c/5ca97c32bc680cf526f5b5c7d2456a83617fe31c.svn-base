package com.hwfs.sc.scp.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 개인정보 파기요청을 관리하는 PersDstryReq DAO
 * 
 * @ClassName PersDstryReqDAO.java
 * @Description PersDstryReqDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scp/persDstryReqDAO")
public class PersDstryReqDAO extends DefaultDAO {
	
	/**
	 * 개인정보 파기요청 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scp.persDstryReqDAO.selectList", mapParam);
	}

	/**
	 * 개인정보 파기요청에 이미 등록된 건수를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectAlreadyExistsCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("sc.scp.persDstryReqDAO.selectAlreadyExistsCnt", mapParam);
	}

	/**
	 * 개인정보 파기요청(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scp.persDstryReqDAO.insert", mapParam);
	}
	
	/**
	 * 개인정보 파기요청(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scp.persDstryReqDAO.update", mapParam);
	}
	
	/**
	 * 개인정보 파기요청(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scp.persDstryReqDAO.delete", mapParam);
	}
	
	/**
	 * 개인정보 파기요청 상신 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Record selectGwDraftList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("sc.scp.persDstryReqDAO.selectGwDraftList", mapParam);
	}

	/**
	 * 전자결재정보를 Update 처리한다.
	 * <pre>
	 * - Instance ID와 결재진행상태 Update
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateSign(Map<String, Object> parameter) throws Exception {
		return super.update("sc.scp.persDstryReqDAO.updateSign", parameter);
	}
	
	/**
	 * 개인정보파기요청에서 결재승인이 난 건 중 개인정보파기이력에 Insert하지 않은 건을 조회한다.
	 *
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectPersDstryReqApprovForLog() throws Exception {
		return super.queryForRecordSet("sc.scp.persDstryReqDAO.selectPersDstryReqApprovForLogIns", new HashMap<String, Object>());
	}
	
	/**
	 * 파기이력처리여부 'Y'로 Update한다.
	 *
	 * @param parameter
	 * @return
	 */
	public int updateLogProcYn(Map<String, Object> parameter) throws Exception {
		return super.update("sc.scp.persDstryReqDAO.updateLogProcYn", parameter);
	}

}
