package com.hwfs.fs.fsc.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 위생점검 평가내용 관리 Dao Class
 *
 * @ClassName FSC00020E_PopupDAO.java
 * @Description FSC00020E_PopupDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.03.06.  김명섭       최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2019.03.06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsc/FSC00020E_PopupDAO")
public class FSC00020E_PopupDAO extends DefaultDAO {
	
    /**
     * 위생점검 평가내용을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("fs.fsc.FSC00020E_PopupDAO.selectList", mapParam);
    }

	/**
	 * 위생점검 평가내용을 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsc.FSC00020E_PopupDAO.update", mapParam);
	}
	   
}