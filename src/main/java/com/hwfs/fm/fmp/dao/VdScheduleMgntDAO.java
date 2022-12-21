package com.hwfs.fm.fmp.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 수발주 스케쥴관리하는 VdScheduleMgnt DAO
 * 
 * @ClassName VdScheduleMgntDAO.java
 * @Description VdScheduleMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.25   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재영업 강대성
 * @since 2015.11.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmp/vdScheduleMgntDAO")
public class VdScheduleMgntDAO extends DefaultDAO {
	
	/**
	 * 수발주 스케쥴관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmp.vdScheduleMgntDAO.selectList", mapParam);
	}
	
	/**
	 * 단가업장 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPopList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("fm.fmp.vdScheduleMgntDAO.selectPopList", parameter);
	}

	/**
	 * 수발주 스케쥴관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmp.vdScheduleMgntDAO.insert", mapParam);
	}
	
	/**
	 * 수발주 스케쥴관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmp.vdScheduleMgntDAO.update", mapParam);
	}
	
	/**
	 * 수발주 스케쥴관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmp.vdScheduleMgntDAO.delete", mapParam);
	}
	
}
