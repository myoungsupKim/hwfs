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
 * @ClassName FmsSpFmSaleBatchProcDAO.java
 * @Description FmsSpFmSaleBatchProcDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 11.   최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015. 7. 11.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/fms/fmsSpFmSaleBatchProcDAO")
public class FmsSpFmSaleBatchProcDAO extends DefaultBatchDAO {

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
    public Map<String, Object> fmsSpFmSaleBatchProc(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_SALE_DATE",         Types.VARCHAR),
            new SqlParameter("P_UPJANG",            Types.VARCHAR),
            new SqlParameter("P_SUBINV_CODE",       Types.VARCHAR),
            new SqlParameter("P_USER",              Types.VARCHAR),
            new SqlOutParameter("O_RTN",            Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",         Types.VARCHAR)
        };

        String procedureName = "SP_FM_SALE_BATCH_PROC";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

}
