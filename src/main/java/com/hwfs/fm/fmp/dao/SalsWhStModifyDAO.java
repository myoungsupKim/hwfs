package com.hwfs.fm.fmp.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

import hone.core.util.record.RecordSet;

/**
 * 매출창고 강제변경 Dao Class
 *
 * @ClassName SalsWhStModifyDAO.java
 * @Description SalsWhStModifyDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 21.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 8. 21.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmp/salsWhStModifyDAO")
public class SalsWhStModifyDAO extends DefaultDAO {

    /**
     * 매출창고 강제변경 목록을 조회한다
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fm.fmp.salsWhStModifyDAO.selectList", parameter);
    }

    /**
     * 사업장 창고 정보 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectUpjangWh(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fm.fmp.salsWhStModifyDAO.selectUpjangWh", parameter);
    }

    /**
     * 사업장 여신 정보 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectUpjangCredit(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fm.fmp.salsWhStModifyDAO.selectUpjangCredit", parameter);
    }
    
    /**
     * 변경후 창고 정보 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectUpjangWhChg(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fm.fmp.salsWhStModifyDAO.selectUpjangWhChg", parameter);
    }

    /**
     * 창고별 일괄 저장
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int modifyList(Map<String, Object> parameter) throws Exception {
        return super.update("fm.fmp.salsWhStModifyDAO.modifyList", parameter);
    }

    /**
     * 창고별 일괄 저장2
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int modifyList2(Map<String, Object> parameter) throws Exception {
        return super.update("fm.fmp.salsWhStModifyDAO.modifyList2", parameter);
    }

    /**
     * 창고별 일괄 저장3
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int modifyList3(Map<String, Object> parameter) throws Exception {
        return super.update("fm.fmp.salsWhStModifyDAO.modifyList3", parameter);
    }
    
    
    /**
     * 매출창고 변경 이력 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insertHistory(Map<String, Object> mapParam) throws Exception {
        return super.update("fm.fmp.salsWhStModifyDAO.insertHistory", mapParam);
    }

	
	/**
	 * 식재매출마감시 여신 집계 프로시저 호출
	 *
	 * @param mapParam
	 * @return
       
	 */
	public Map<String, Object> sp_Fms_Credit_Sum_Proc(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_UPJANG_CD",      	Types.VARCHAR),
            new SqlParameter("P_APPLY_DATE",      		Types.VARCHAR),
            new SqlParameter("P_OCCUR_CLASS",       Types.VARCHAR),
            new SqlParameter("P_OCCUR_AMT",        		Types.VARCHAR),
            new SqlParameter("P_OCCUR_AMT_BEFORE",      	Types.VARCHAR),
            new SqlParameter("P_CLASS_CD",      		Types.VARCHAR),
            new SqlParameter("P_OCCUR_TABLE",       Types.VARCHAR),
            new SqlParameter("P_KEY_NM",        		Types.VARCHAR),
            new SqlParameter("P_KEY_VALUE01",      	Types.VARCHAR),
            new SqlParameter("P_KEY_VALUE02",      		Types.VARCHAR),
            new SqlParameter("P_KEY_VALUE03",       Types.VARCHAR),
            new SqlParameter("P_KEY_VALUE04",        		Types.VARCHAR),
            new SqlParameter("P_KEY_VALUE05",      	Types.VARCHAR),
            new SqlParameter("P_OCCUR_PRG_ID",      		Types.VARCHAR),
            new SqlParameter("P_OCCUR_PRG_NM",       Types.VARCHAR),
            new SqlParameter("P_USER",        		Types.VARCHAR),
            new SqlOutParameter("O_RTN",  		Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",   		Types.VARCHAR)
        };
        String procedureName = "FMS_CREDIT_SUM_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
	}
		
	   
    

}
