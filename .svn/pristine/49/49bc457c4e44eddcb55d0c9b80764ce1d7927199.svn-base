package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 권한에 따른 시스템을 표시하는 SystemChange DAO
 *
 * @ClassName SystemChangeDAO.java
 * @Description SystemChangeDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.15
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/systemChangeDAO")
public class SystemChangeDAO extends DefaultDAO {

	/**
	 * 권한에 따른 시스템 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		return super.queryForRecordSet("sc.cmn.systemChangeDAO.selectList", mapParam);
	}

	public RecordSet selectAuthList() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		return super.queryForRecordSet("sc.cmn.systemChangeDAO.selectAuthList", mapParam);
	}
}
