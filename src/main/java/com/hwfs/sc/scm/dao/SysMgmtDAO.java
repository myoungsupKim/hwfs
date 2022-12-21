package com.hwfs.sc.scm.dao;

import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SystemMgmtDAO에 대한 설명 작성
 * @ClassName SystemMgmtDAO.java
 * @Description SystemMgmtDAO Class 
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
@Repository("/sc/scm/sysMgmtDAO")
public class SysMgmtDAO extends DefaultDAO {
	
	/**
	 * 시스템구분에 해당하는 시스템 정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) {
		return super.queryForRecordSet("sc.scm.sysMgmtDAO.selectList", parameter);
	}
	
	/**
	 * 새로운 시스템 정보를 추가한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertList(Map<String, Object> parameter) {
		return super.update("sc.scm.sysMgmtDAO.insertList", parameter);
	}

	/**
	 * 변경된 시스템정보를 갱신한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateList(Map<String, Object> parameter) {
		return super.update("sc.scm.sysMgmtDAO.updateList", parameter);
	}

	/**
	 * 시스템 정보를 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteList(Map<String, Object> parameter) {
		return super.update("sc.scm.sysMgmtDAO.deleteList", parameter);
	}
}
