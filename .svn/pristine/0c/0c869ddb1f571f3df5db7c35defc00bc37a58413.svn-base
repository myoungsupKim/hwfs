package com.hwfs.sc.sca.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 권한변경을 요청하는 AuthChngRequest DAO
 *
 * @ClassName AuthChngRequestDAO.java
 * @Description AuthChngRequestDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.13   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.07.13
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/sca/authChngRequestDAO")
public class AuthChngRequestDAO extends DefaultDAO {

	/**
	 * 권한변경 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.sca.authChngRequestDAO.selectList", mapParam);
	}

	public Record selectGwDraftMst(Map<String, Object> parameter) throws Exception {
        return super.queryForRecord("sc.sca.authChngRequestDAO.selectGwDraftMst", parameter);
    }
	/**
	 * 권한변경(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.sca.authChngRequestDAO.insert", mapParam);
	}
	/**
	 * 권한변경(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.sca.authChngRequestDAO.update", mapParam);
	}

	/**
	 * 권한변경(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveGwInstanceId(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.sca.authChngRequestDAO.saveGwInstanceId", mapParam);
	}

}
