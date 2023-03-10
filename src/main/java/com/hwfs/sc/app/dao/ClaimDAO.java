package com.hwfs.sc.app.dao;

import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 클레임관리 인터페이스용  DAO 개체
 * @ClassName ClaimDAO.java
 * @Description  ClaimDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.09.05.   김명섭        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.09.05.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/app/claimDAO")
public class ClaimDAO extends DefaultDAO {
	
	/**
	 * 창고 정보 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectSubinv(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.claimDAO.selectSubinv", parameter);
	}

	/**
	 * 발주내역조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectClaimReqInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.claimDAO.selectClaimReqInfo", parameter);
	}

	/**
	 * 클레임이미지조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectClaimImg(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.claimDAO.selectClaimImg", parameter);
	}
	
	/**
	 * 클레임 중복 등록 여부를 확인 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int claiminsertYn(Map<String, Object> parameter) throws Exception {
		return super.queryForInt("sc.app.claimDAO.claiminsertYn", parameter);
	}
	
	/**
	 * 클레임 식권클레임 가능 여부 확인.
	 *
	 * @param mapParam
	 * @return
	 */
	public String ticketFlag(Map<String, Object> parameter) throws Exception {
		return (String)super.queryForObject("sc.app.claimDAO.ticketFlag", parameter , null);
	}
	
	/**
	 * 클레임요청(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveClaim(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.claimDAO.saveClaim", parameter);
	}
	
	/**
	 * 클레임 상태값 재조회.
	 *
	 * @param mapParam
	 * @return
	 */
	public String claimStatus(Map<String, Object> parameter) throws Exception {
		return (String)super.queryForObject("sc.app.claimDAO.claimStatus", parameter , null);
	}
	
	/**
	 * 요청 취소 클레임 저장.
	 *
	 * @param mapParam
	 * @return
	 */
	public int claimHistorySave(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.claimDAO.claimHistorySave", parameter);
	}

	/**
	 * 클레임요청(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteClaim(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.claimDAO.deleteClaim", parameter);
	}

	/**
	 * 클레임 이미지 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteClaimImgP(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.claimDAO.deleteClaimImgP", parameter);
	}

	/**
	 * 클레임 이미지 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteClaimImgM(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.claimDAO.deleteClaimImgM", parameter);
	}
	
	/**
	 * 클레임 이미지 등록
	 *
	 * @param mapParam
	 * @return
	 */
	public int claimImgSave(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.claimDAO.claimImgSave", parameter);
	}

	/**
	 * 첨부파일 삭제
	 *
	 * @param mapParam
	 * @return
	 */
	public int appendFileDelete(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.claimDAO.appendFileDelete", parameter);
	}
	
	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.claimDAO.logInsert", parameter);
	}
	
}
