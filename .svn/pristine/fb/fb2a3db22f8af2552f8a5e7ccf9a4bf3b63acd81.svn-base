package com.hwfs.sc.scc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 접속사용자를 조회하는 ConnectUser DAO
 *
 * @ClassName ConnectUserDAO.java
 * @Description ConnectUserDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.08   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.08
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scc/connectUserDAO")
public class ConnectUserDAO extends DefaultDAO {

	/**
	 * CC별 접속자수를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCcByConnectList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.scc.connectUserDAO.selectCcByConnectList", mapParam);
	}

	/**
	 * 접속사용자 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scc.connectUserDAO.selectList",
				mapParam);
	}
}
