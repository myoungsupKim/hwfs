package com.hwfs.sc.app.dao;

import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 공통 인터페이스용  DAO 개체
 * @ClassName CommonDAO.java
 * @Description  CommonDAO Class 
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
@Repository("/sc/app/commonDAO")
public class CommonDAO extends DefaultDAO {
	
	/**
	 * 공통코드 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCommonCode(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.commonDAO.selectCommonCode", parameter);
	}

	/**
	 * 동의어 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectSameText(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.commonDAO.selectSameText", parameter);
	}

	/**
	 * 공지사항 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet SelectBbsInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.commonDAO.SelectBbsInfo", parameter);
	}

	/**
	 * 시스템작업일시 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectConstruction(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.commonDAO.selectConstruction", parameter);
	}
	
	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.commonDAO.logInsert", parameter);
	}
	
}
