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
 *  2015. 12. 09.   손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015. 12. 09.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/ma/mag/spSlaPosArAdjustBatchJobProDAO")
public class SpSlaPosArAdjustBatchJobProDAO extends DefaultBatchDAO {

    /**
     * 외식 일 배치 매출 마감 프로시저
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> spSlaPosArAdjustBatchJobPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlOutParameter("O_RTN",         Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",      Types.VARCHAR)
        };

        String procedureName = "SP_SLA_POS_AR_ADJUST_BATCH";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

}
