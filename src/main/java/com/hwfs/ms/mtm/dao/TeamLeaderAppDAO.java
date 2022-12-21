package com.hwfs.ms.mtm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등)하는 TeamLeaderApp DAO
 * 
 * @ClassName TeamLeaderAppDAO.java
 * @Description TeamLeaderAppDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.08   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 현장지원_모바일 강대성
 * @since 2015.04.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/mtm/teamLeaderAppDAO")
public class TeamLeaderAppDAO extends DefaultDAO {
	
	/**
	 * 각종팀장승인(추가발주) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList001(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mtm.teamLeaderAppDAO.selectList001", mapParam);
	}
	
	/**
	 * 각종팀장승인(취소신청팀장승인) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList002(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mtm.teamLeaderAppDAO.selectList002", mapParam);
	}
	
	/**
	 * 각종팀장승인(케이터링_기기기물 팀장승인) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList003(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mtm.teamLeaderAppDAO.selectList003", mapParam);
	}
	
	/**
	 * 각종팀장승인(이벤트_기기기물 팀장승인) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList004(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mtm.teamLeaderAppDAO.selectList004", mapParam);
	}
	
	/**
	 * 각종팀장승인(식권폐기승인) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList005(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mtm.teamLeaderAppDAO.selectList005", mapParam);
	}
	
	/**
	 * 각종팀장승인(시험접수승인_LIMS) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList006(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mtm.teamLeaderAppDAO.selectList006", mapParam);
	}
	
	/**
	 * 각종팀장승인(시험접수승인_LIMS) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDetailList006(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mtm.teamLeaderAppDAO.selectDetailList006", mapParam);
	}
	
	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등)(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update001(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mtm.teamLeaderAppDAO.update001", mapParam);
	}

	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등)(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateApprov002(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mtm.teamLeaderAppDAO.updateApprov002", mapParam);
	}
	
	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등)(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateTeamMst002(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mtm.teamLeaderAppDAO.updateTeamMst002", mapParam);
	}
	
	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등)(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete002(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mtm.teamLeaderAppDAO.delete002", mapParam);
	}
	
	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등)(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertHst002(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mtm.teamLeaderAppDAO.insertHst002", mapParam);
	}
	
	/**
	 * 각종팀장승인(케터링_기물 승인) 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update003(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mtm.teamLeaderAppDAO.update003", mapParam);
	}
	
	/**
	 * 각종팀장승인(이벤트_기기기물 승인) 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update004(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mtm.teamLeaderAppDAO.update004", mapParam);
	}
	
	
	/**
	 * 각종팀장승인(식권폐기승인_마스터) 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateApprov005(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mtm.teamLeaderAppDAO.updateApprov005", mapParam);
	}
	
	/**
	 * 각종팀장승인(식권폐기승인_팀장) 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateTeamMst005(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mtm.teamLeaderAppDAO.updateTeamMst005", mapParam);
	}
	
	/**
	 * 추가발주승인시 저장 체크.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet saveChk001(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mtm.teamLeaderAppDAO.saveChk001", mapParam);
	}	
	
	/**
	 * 마감취소승인 저장 체크.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet saveChk002(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mtm.teamLeaderAppDAO.saveChk002", mapParam);
	}	
	
	/**
	 * 식권폐기승인시 저장 체크.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet saveChk005(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mtm.teamLeaderAppDAO.saveChk005", mapParam);
	}	
	
	/**
	 * 각종팀장반려처리(이벤트_기기기물 승인) 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReturn004(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mtm.teamLeaderAppDAO.updateReturn004", mapParam);
	}
	
	/**
	 * 각종팀장반려처리(식권폐기팀장승인_마스터) 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateApprovReturn005(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mtm.teamLeaderAppDAO.updateApprovReturn005", mapParam);
	}
	
	/**
	 * 각종팀장반려처리(식권폐기팀장승인_팀장) 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateTeamMstReturn005(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mtm.teamLeaderAppDAO.updateTeamMstReturn005", mapParam);
	}
	
	/**
	 * 팀별 추가발주승인이 필요한 총 건수
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCount001(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mtm.teamLeaderAppDAO.selectCount001", mapParam);
	}
	
}
