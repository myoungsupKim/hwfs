package com.hwfs.sc.scu.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사용자별 업장을 조회하는 UserByUpjangRetv DAO
 *
 * @ClassName UserByUpjangRetvDAO.java
 * @Description UserByUpjangRetvDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.31   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.31
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scu/userByUpjangRetvDAO")
public class UserByUpjangRetvDAO extends DefaultDAO {

	/**
	 * 사용자별 업장 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scu.userByUpjangRetvDAO.selectList", mapParam);
	}
}
