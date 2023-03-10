package com.hwfs.sc.app.dao;

import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 메인 인터페이스용  DAO 개체
 * @ClassName MainDAO.java
 * @Description  MainDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.06.20.   김명섭        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.06.20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/app/mainDAO")
public class MainDAO extends DefaultDAO {
	
	/**
	 * 테스트 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectTest(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.mainDAO.selectTest", parameter);
	}

	/**
	 * 업장 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectUpjang(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.mainDAO.selectUpjang", parameter);
	}

	/**
	 * 창고,디데이 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectSubinv(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.mainDAO.selectSubinv", parameter);
	}

	/**
	 * 입고통제일 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCtrlday(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.mainDAO.selectCtrlday", parameter);
	}

	/**
	 * FS입고통제일 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectFsCtrlday(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.mainDAO.selectFsCtrlday", parameter);
	}
	
	/**
	 * 요일통제 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCtrlord(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.mainDAO.selectCtrlord", parameter);
	}
	
//	/**
//	 * 운영단가율 조회
//	 *
//	 * @param parameter
//	 * @return
//	 */
//	public RecordSet selectOprate(Map<String, Object> parameter) throws Exception {
//		return super.queryForRecordSet("sc.app.mainDAO.selectOprate", parameter);
//	}

	/**
	 * 행사정보 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectEvent(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.mainDAO.selectEvent", parameter);
	}

	/**
	 * 품목분류 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectItemClass(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.mainDAO.selectItemClass", parameter);
	}	
	
	/**
	 * 금지자재 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectOrdlimit(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.mainDAO.selectOrdlimit", parameter);
	}

	/**
	 * 수발주요일제한 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectOrdSchdule(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.mainDAO.selectOrdSchdule", parameter);
	}

	/**
	 * 여신 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectLoan(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.mainDAO.selectLoan", parameter);
	}

	/**
	 * 추가정보 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectSubinv2(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.mainDAO.selectSubinv2", parameter);
	}
	
	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.mainDAO.logInsert", parameter);
	}
	
}
