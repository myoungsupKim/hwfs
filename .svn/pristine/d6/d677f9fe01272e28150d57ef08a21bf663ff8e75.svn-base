package com.hwfs.batch.fm.fms.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

/**
 * FMS JOB Schedule Dao Class
 *
 * @ClassName FmsJobScheduleDAO.java
 * @Description FmsJobScheduleDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 19.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 6. 19.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/fms/fmsJobScheduleDAO")
public class FmsJobScheduleDAO extends DefaultBatchDAO {

    /**
     * 식재영업 일별 수불 자동생성 PROCEDURE
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> fmsSubulcreateJobPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_UPJANG",            Types.VARCHAR),
            new SqlParameter("P_SUBINV_CODE",       Types.VARCHAR),
            new SqlParameter("P_DATE",              Types.VARCHAR),
            new SqlParameter("P_CUSER",             Types.VARCHAR),
            new SqlOutParameter("O_CNT",            Types.INTEGER),
            new SqlOutParameter("O_RTN",            Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",         Types.VARCHAR)
        };

        String procedureName = "FMS_SUBULCREATE_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }
    
    /**
     * 식재사업부 채권선수금 자동대체 PROCEDURE
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> fmsArAdJobPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {    
                new SqlParameter("P_OCCUR_DATE",        Types.VARCHAR),
                new SqlParameter("P_MU_CD",       		Types.VARCHAR),
                new SqlParameter("P_CUSER",             Types.VARCHAR),
                //new SqlOutParameter("O_CNT",            Types.INTEGER),
                new SqlOutParameter("O_RTN",            Types.VARCHAR),
                new SqlOutParameter("O_RTNMSG",         Types.VARCHAR)
        };

        String procedureName = "SP_SLA_AR_REV_ADVANCE_PROC";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

}
