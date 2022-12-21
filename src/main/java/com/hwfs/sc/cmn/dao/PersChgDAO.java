package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 개인정보를 변경하는 PersChg DAO
 *
 * @ClassName PersChgDAO.java
 * @Description PersChgDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.29
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/persChgDAO")
public class PersChgDAO extends DefaultDAO {

	/**
	 * 개인정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet select() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		return super.queryForRecordSet("sc.cmn.persChgDAO.select", mapParam);
	}
	
	/**
	 * 개인정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUserSms(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.persChgDAO.selectUserSms", mapParam);
	}
	
	/**
	 * 개인정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.persChgDAO.update", mapParam);
	}
}
