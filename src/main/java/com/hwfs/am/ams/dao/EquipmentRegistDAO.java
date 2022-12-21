package com.hwfs.am.ams.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 전산장비 등록 관리 Dao Class
 *
 * @ClassName EquipmentRegistDAO.java
 * @Description EquipmentRegistDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.12.12.  김명섭       최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2018.12.12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/am/ams/equipmentRegistDAO")
public class EquipmentRegistDAO extends DefaultDAO {
	
    /**
     * 전산장비 관리자 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectAdminList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("am.ams.equipmentRegistDAO.selectAdminList", mapParam);
    }

    public RecordSet selectBarprtList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("am.ams.equipmentRegistDAO.selectBarprtList", mapParam);
    }
    
    /**
     * 전산장비 등록정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("am.ams.equipmentRegistDAO.selectList", mapParam);
    }

	/**
	 * 전산장비관리번호를 체번한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String selectEqno(Map<String, Object> mapParam) throws Exception {
        return (String) super.queryForObject("am.ams.equipmentRegistDAO.selectEqno", mapParam, null);
	}
    
	/**
	 * 전산장비 등록정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("am.ams.equipmentRegistDAO.insert", mapParam);
	}
	
	/**
	 * 전산장비 등록정보를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("am.ams.equipmentRegistDAO.update", mapParam);
	}
	
	/**
	 * 전산장비 등록정보를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("am.ams.equipmentRegistDAO.delete", mapParam);
	}

	/**
	 * 전산장비 등록정보를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateA(Map<String, Object> mapParam) throws Exception {
		return super.update("am.ams.equipmentRegistDAO.updateA", mapParam);
	}
	
    /**
     * 전산장비 마스터를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectEqList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("am.ams.equipmentRegistDAO.selectEqList", mapParam);
    }

    /**
     * 전산장비 히스토리 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectHist(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("am.ams.equipmentRegistDAO.selectHist", mapParam);
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

    /**
     * 전산장비 AS정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectAsList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("am.ams.equipmentRegistDAO.selectAsList", mapParam);
    }

	/**
	 * 전산장비 AS등록정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertAs(Map<String, Object> mapParam) throws Exception {
		return super.update("am.ams.equipmentRegistDAO.insertAs", mapParam);
	}
	
	/**
	 * 전산장비 AS등록정보를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateAs(Map<String, Object> mapParam) throws Exception {
		return super.update("am.ams.equipmentRegistDAO.updateAs", mapParam);
	}
	
	/**
	 * 전산장비 AS등록정보를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAs(Map<String, Object> mapParam) throws Exception {
		return super.update("am.ams.equipmentRegistDAO.deleteAs", mapParam);
	}

	/**
	 * 전산장비 출력정보를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updatePrt(Map<String, Object> mapParam) throws Exception {
		return super.update("am.ams.equipmentRegistDAO.updatePrt", mapParam);
	}

    /**
     * 상세 코드 일괄 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectCodeDtlBatchList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("am.ams.equipmentRegistDAO.selectCodeDtlBatchList", parameter);
    }
	
}