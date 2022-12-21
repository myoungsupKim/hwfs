package com.hwfs.sc.app.dao;

import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 승인신청 인터페이스용  DAO 개체
 * @ClassName ApproveDAO.java
 * @Description  ApproveDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.09.08.   구승모        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.09.08.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/app/approveDAO")
public class ApproveDAO extends DefaultDAO {
//	/**
//	 * 입금내역 조회
//	 *
//	 * @param parameter
//	 * @return
//	 */
//	public RecordSet selectDepositInfo(Map<String, Object> parameter) throws Exception {
//		return super.queryForRecordSet("sc.app.approveDAO.selectDepositInfo", parameter);
//	}
	
	/**
	 * 승인신청 코드조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectApproveType(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.approveDAO.selectApproveType", parameter);
	}
	
	/**
	 * 추가발주 사유1
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectApproveReason1(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.approveDAO.selectApproveReason1", parameter);
	}
	
	/**
	 * 추가발주 사유2
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectApproveReason2(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.approveDAO.selectApproveReason2", parameter);
	}
	
	/**
	 * 추가구매 승인신청 유효성체크
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet saveChk001(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.approveDAO.saveReqChk001", parameter);
	}

	/**
	 * 마감취소 승인신청 유효성체크
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet saveChk002(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.approveDAO.saveReqChk002", parameter);
	}

	/**
	 * 추가발주신청 저장
	 *
	 * @param parameter
	 * @return
	 */
	public int saveApprove001(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.approveDAO.saveApprove001", parameter);
	}
	
	/**
	 * 마감취소신청 저장
	 *
	 * @param parameter
	 * @return
	 */
	public int saveApprove002(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.approveDAO.saveApprove002", parameter);
	}
	
	/**
	 * 승인신청 등록내역 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectApproveList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.approveDAO.selectApproveList", parameter);
	}
	
	/**
	 * 추가구매승인 유효성체크
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet saveTlChk001(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.approveDAO.saveTlChk001", parameter);
	}

	/**
	 * 마감취소승인 유효성체크
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet saveTlChk002(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.approveDAO.saveTlChk002", parameter);
	}
	
	/**
	 * 추가발주승인 저장
	 *
	 * @param parameter
	 * @return
	 */
	public int saveTlApprove001(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.approveDAO.saveTlApprove001", parameter);
	}
	
	/**
	 * 마감취소승인 저장
	 *
	 * @param parameter
	 * @return
	 */
	public int saveTlApprove002(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.approveDAO.saveTlApprove002", parameter);
	}
	
	/**
	 * 마감취소시 기존건 삭제
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteTlApprove002(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.approveDAO.deleteTlApprove002", parameter);
	}
	
	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.approveDAO.logInsert", parameter);
	}
	
}
