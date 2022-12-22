package com.hwfs.sc.sca.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 권한별 사용자를 조회하는 AuthByUserRetv DAO
 *
 * @ClassName AuthByUserRetvDAO.java
 * @Description AuthByUserRetvDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.31   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.31
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/sca/authByUserRetvDAO")
public class AuthByUserRetvDAO extends DefaultDAO {

	/**
	 * 권한별 사용자 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.sca.authByUserRetvDAO.selectList",
				mapParam);
	}

	public RecordSet selectBoardSysType(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.sca.authByUserRetvDAO.selectBoardSysType",
				mapParam);
	}
	
	public RecordSet selectBbsRoleUser(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.sca.authByUserRetvDAO.selectBbsRoleUser",
				mapParam);
	}
}
