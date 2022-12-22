package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사업부-팀에 속하는 부서를 조회하는 FindDept DAO
 * 
 * @ClassName FindDeptDAO.java
 * @Description FindDeptDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.16   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.06.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/findDeptDAO")
public class FindDeptDAO extends DefaultDAO {
	
	/**
	 * 사업부에 속하는 팀 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTeamList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.findDeptDAO.selectTeamList", mapParam);
	}

	/**
	 * 사업부-팀에 속하는 부서 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDeptList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.findDeptDAO.selectDeptList", mapParam);
	}
	
}
