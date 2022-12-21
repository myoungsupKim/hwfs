package com.hwfs.sc.scm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * PrgMgmtDAO에 대한 설명 작성
 * @ClassName PrgMgmtDAO.java
 * @Description PrgMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 26.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 1. 26.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scm/prgMgmtDAO")
public class PrgMgmtDAO extends DefaultDAO {
	
	/**
	 * 조회 조건에 해당하는 프로그램을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) {
		return super.queryForRecordSet("sc.scm.prgMgmtDAO.selectList", parameter);
	}
	
	/**
	 * 시스템구분에 따른 Service Id를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectServiceIdList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.scm.prgMgmtDAO.selectServiceIdList", parameter);
	}
	
	/**
	 * 이미 등록되어 있는지를 중복체크한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int selectExists(Map<String, Object> parameter) {
		return super.queryForInt("sc.scm.prgMgmtDAO.selectExists", parameter);
	}
	
	/**
	 * 신규로 추가되는 프로그램 정보를 저장한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertList(Map<String, Object> parameter) {
		return super.update("sc.scm.prgMgmtDAO.insertList", parameter);
	}
	
	/**
	 * 변경되는 프로그램 정보를 저장한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateList(Map<String, Object> parameter) {
		return super.update("sc.scm.prgMgmtDAO.updateList", parameter);
	}
	
	/**
	 * 프로그램을 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteList(Map<String, Object> parameter) {
		return super.update("sc.scm.prgMgmtDAO.deleteList", parameter);
	}
}
