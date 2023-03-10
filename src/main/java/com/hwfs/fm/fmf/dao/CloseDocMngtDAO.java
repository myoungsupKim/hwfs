package com.hwfs.fm.fmf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 마감장관리(브랜드) CloseDocMngt DAO
 * 
 * @ClassName CloseDocMngt.java
 * @Description CloseDocMngt Class
 * @Modification-Information
 * <pre>
 *    수정일                  수정자               수정내용
 *  ----------   ----------   -------------------------------
 *  2021.09.15     dev03	      최초생성
 * </pre>
 * @author dev03
 * @since 2021.09.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmf/closeDocMngtDAO")
public class CloseDocMngtDAO extends DefaultDAO {
	
	/**
	 * 월별매출집계 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.closeDocMngtDAO.selectList", mapParam);
	}
	
	/**
	 * 마감장관리(브랜드)(TOBE) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.closeDocMngtDAO.selectList2", mapParam);
	}

	/**
	 * selectSubList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.closeDocMngtDAO.selectSubList", mapParam);
	}

	/**
	 * selectSubByOrder1List 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubByOrder1List(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.closeDocMngtDAO.selectSubByOrder1List", mapParam);
	}
	
	/**
	 * selectSubByOrder1List 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubByOrderNList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.closeDocMngtDAO.selectSubByOrderNList", mapParam);
	}
	
	/**
	 * selectSubByOrder1List 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubByDateList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.closeDocMngtDAO.selectSubByDateList", mapParam);
	}
	
	/**
	 * 마감장관리(브랜드)(TOBE) selectSubList2 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.closeDocMngtDAO.selectSubList2", mapParam);
	}

	/**
	 * 마감장관리(브랜드)(TOBE) selectSubByOrder1List2 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubByOrder1List2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.closeDocMngtDAO.selectSubByOrder1List2", mapParam);
	}
	
	/**
	 * 마감장관리(브랜드)(TOBE) selectSubByOrder1List2 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubByOrderNList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.closeDocMngtDAO.selectSubByOrderNList2", mapParam);
	}
	
	/**
	 * 마감장관리(브랜드)(TOBE) selectSubByOrder1List2 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubByDateList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.closeDocMngtDAO.selectSubByDateList2", mapParam);
	}
}
