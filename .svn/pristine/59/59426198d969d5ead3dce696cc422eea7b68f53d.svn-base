package com.hwfs.sc.scc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * CodeMgmtDAO에 대한 설명 작성
 * @ClassName CodeMgmtDAO.java
 * @Description CodeMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 19.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 1. 19.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scc/codeMgmtDAO")
public class CodeMgmtDAO extends DefaultDAO {
	
	/**
	 * 공통그룹코드에 대하여 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public RecordSet selectGroupList(Map<String, Object> parameter) {
		return super.queryForRecordSet("sc.scc.codeMgmtDAO.selectGroupList", parameter);
	}
	
	/**
	 * 특정 그룹코드에 맞는 공통코드를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public RecordSet selectCodeList(Map<String, Object> parameter) {
		return super.queryForRecordSet("sc.scc.codeMgmtDAO.selectCodeList", parameter);
	}
	
	/**
	 * 공통그룹코드를 생성한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertGroupList(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("sc.scc.codeMgmtDAO.insertGroupList", parameter);
	}
	
	/**
	 * 공통그룹코드를 수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateGroupList(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("sc.scc.codeMgmtDAO.updateGroupList", parameter);
	}

	/**
	 * 공통코드를 생성한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertCodeList(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("sc.scc.codeMgmtDAO.insertCodeList", parameter);
	}

	/**
	 * 공통코드를 수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateCodeList(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("sc.scc.codeMgmtDAO.updateCodeList", parameter);
	}
	
	/**
	 * 그룹코드의 사용상태가 [사용안함] 상태인 경우에는 전체 공통코드를 [사용안함] 상태로 변경한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateUseAllCode(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("sc.scc.codeMgmtDAO.updateUseAllCode", parameter);
	}
}
