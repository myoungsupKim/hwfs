package com.hwfs.fs.fso.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 물건정보 특이사항 관리 Dao Class
 *
 * @ClassName RemarkPopupDAO.java
 * @Description RemarkPopupDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.12.18.  김명섭       최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2018.12.18.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fso/remarkPopupDAO")
public class RemarkPopupDAO extends DefaultDAO {
	
    /**
     * 물건정보 특이사항 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("fs.fso.remarkPopupDAO.selectList", mapParam);
    }

	/**
	 * 물건정보 특이사항을 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.remarkPopupDAO.insert", mapParam);
	}
	
	/**
	 * 물건정보 특이사항을 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.remarkPopupDAO.update", mapParam);
	}
	
	/**
	 * 물건정보 특이사항을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.remarkPopupDAO.delete", mapParam);
	}
    
}