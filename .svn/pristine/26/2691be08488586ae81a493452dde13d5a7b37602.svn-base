package com.hwfs.sc.cmn.dao;

import hone.core.util.record.Record;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 비밀번호를 변경하는하는 PwdChg DAO
 *
 * @ClassName PwdChgDAO.java
 * @Description PwdChgDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.24   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.24
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/pwdChgDAO")
public class PwdChgDAO extends DefaultDAO {

	/**
	 * 비밀번호을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Record select(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("sc.cmn.pwdChgDAO.select", mapParam);
	}

	/**
	 * 비밀번호(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.pwdChgDAO.update", mapParam);
	}
}
