package com.hwfs.batch.ma.mag.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

/**
 * FMS JOB Schedule Dao Class
 *
 * @ClassName MapDayActjobProDao.java
 * @Description MapDayActjobProDao Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 24.   박준석        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 박준석
 * @since 2015. 9. 24.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/ma/mag/magDayCloseJobProDAO")
public class MagDayCloseJobProDAO extends DefaultBatchDAO {

    /**
     * 사업장 일마감 마감 일배치
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> magDayCloseJobPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_OCCUR_DATE",         Types.VARCHAR),
            new SqlParameter("P_SYS_CLASS",         Types.VARCHAR),
            //new SqlParameter("I_PART_CODE",      Types.VARCHAR),
            //new SqlParameter("I_SABUN",          Types.VARCHAR),
            new SqlOutParameter("O_RTN",         Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",      Types.VARCHAR)
        };

        String procedureName = "SP_SLA_SALS_POS_MAGAM_PROC_JOB";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

}
