package com.hwfs.sc.app.dao;

import java.util.Map;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 팝업 인터페이스용  DAO 개체
 * @ClassName PopupDAO.java
 * @Description  PopupDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.21.  구승모        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.07.21.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/app/popupDAO")
public class PopupDAO extends DefaultDAO {
	
	/**
	 * 테스트 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectTest(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.popupDAO.selectTest", parameter);
	}
	
	/**
	 * 업장 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectUpjangPop(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.popupDAO.selectUpjangPop", parameter);
	}

	/**
	 * 메인업장 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectMainUpjangPop(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.popupDAO.selectMainUpjangPop", parameter);
	}
	
	/**
	 * 브랜드업장 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectBrandUpjangPop(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.popupDAO.selectBrandUpjangPop", parameter);
	}
	
	/**
	 * 브랜드 메인업장 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectBrandMainUpjangPop(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.popupDAO.selectBrandMainUpjangPop", parameter);
	}
	
	/**
	 * 사용자 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectUserPop(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.popupDAO.selectUserPop", parameter);
	}
	
	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.popupDAO.logInsert", parameter);
	}
	
}
