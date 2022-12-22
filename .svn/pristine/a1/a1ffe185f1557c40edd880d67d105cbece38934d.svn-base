package com.hwfs.sc.scm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * MenuMgmtDAO에 대한 설명 작성
 * @ClassName MenuMgmtDAO.java
 * @Description MenuMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 27.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 1. 27.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scm/menuMgmtDAO")
public class MenuMgmtDAO extends DefaultDAO {
	
	/**
	 * 조건에 맞는 메뉴정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) {
		return super.queryForRecordSet("sc.scm.menuMgmtDAO.selectList", parameter);
	}

	/**
	 * 새로운 메뉴정보를 추가한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertList(Map<String, Object> parameter) {
		return super.update("sc.scm.menuMgmtDAO.insertList", parameter);
	}

	/**
	 * 변경된 메뉴정보를 수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateList(Map<String, Object> parameter) {
		return super.update("sc.scm.menuMgmtDAO.updateList", parameter);
	}

	/**
	 * 메뉴정보를 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteList(Map<String, Object> parameter) {
		return super.update("sc.scm.menuMgmtDAO.deleteList", parameter);
	}
}
