package com.hwfs.batch.fm.fmb.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

/**
 * FMS JOB Schedule Dao Class
 *
 * @ClassName FmbSetsaledatajobProDAO.java
 * @Description FmbSetsaledatajobProDAO Class
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
@Repository("/batch/sc/fmb/fmbSetsaledatajobProDAO")
public class FmbSetsaledatajobProDAO extends DefaultBatchDAO {

    /**
     * 매출데이터 강제생성
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> fmbSetsaledatajobPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("PI_DATE_F",         Types.VARCHAR),
            new SqlParameter("PI_DATE_T",         Types.VARCHAR),
            new SqlParameter("PI_PART_CODE",      Types.VARCHAR),
            new SqlParameter("PI_SABUN",          Types.VARCHAR),
            new SqlOutParameter("PO_RTN",         Types.VARCHAR),
            new SqlOutParameter("PO_CNT",         Types.INTEGER),
            new SqlOutParameter("PO_RTNMSG",      Types.VARCHAR)
        };

        String procedureName = "FMB_SETSALEDATA_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

}
