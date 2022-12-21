package com.hwfs.am.ams.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 전산장비 요청 관리 Dao Class
 *
 * @ClassName EquipmentRequestDAO.java
 * @Description EquipmentRequestDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.12.06.  김명섭       최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2018.12.06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/am/ams/equipmentRequestDAO")
public class EquipmentRequestDAO extends DefaultDAO {
	
    /**
     * 전산장비 관리자 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectAdminList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("am.ams.equipmentRequestDAO.selectAdminList", mapParam);
    }

    /**
     * 전산장비 요청 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("am.ams.equipmentRequestDAO.selectList", mapParam);
    }

	/**
	 * 전산장비 요청을 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("am.ams.equipmentRequestDAO.insert", mapParam);
	}
	
	/**
	 * 전산장비 요청을 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("am.ams.equipmentRequestDAO.update", mapParam);
	}
	
	/**
	 * 전산장비 요청을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("am.ams.equipmentRequestDAO.delete", mapParam);
	}
    
    /**
     * 전산장비 마스터를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectEqList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("am.ams.equipmentRequestDAO.selectEqList", mapParam);
    }

	/**
	 * 전산장비 마스터를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateMstA(Map<String, Object> mapParam) throws Exception {
		return super.update("am.ams.equipmentRequestDAO.updateMstA", mapParam);
	}

	/**
	 * 전산장비 마스터를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateMstB(Map<String, Object> mapParam) throws Exception {
		return super.update("am.ams.equipmentRequestDAO.updateMstB", mapParam);
	}

	/**
	 * 전산장비 마스터를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateMstC(Map<String, Object> mapParam) throws Exception {
		return super.update("am.ams.equipmentRequestDAO.updateMstC", mapParam);
	}

	/**
	 * 이력관리 프로시져호출
	 *
	 * @param inParam
	 * @param callProcName
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> callAmsProcedure(Map<String, Object> inParam, String callProcName) throws Exception{
		//전달 순서대로 생성
		SqlParameter[] sqlParameter = new SqlParameter[]{
			new SqlParameter("P_EQ_NO",     Types.VARCHAR),
			new SqlParameter("P_CHG_GUBUN", Types.VARCHAR),
			new SqlParameter("P_CHG_TEXT",  Types.VARCHAR),
			new SqlParameter("P_CUSER",     Types.VARCHAR),
			new SqlOutParameter("O_RTN",    Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
		};
		
		// Procedure Call
		return callProcedure(callProcName, sqlParameter, inParam);
	}
	
}