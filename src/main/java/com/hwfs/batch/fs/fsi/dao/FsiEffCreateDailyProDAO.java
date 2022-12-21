package com.hwfs.batch.fs.fsi.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

/**
 * FSI JOB Schedule Dao Class
 *
 * @ClassName FsiDutyCreateDailyProDAO.java
 * @Description FsiDutyCreateDailyProDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 06.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 8. 06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/fsi/fsiEffCreateDailyProDAO")
public class FsiEffCreateDailyProDAO extends DefaultBatchDAO {

    /**
     * 기획자재 집계 일배치 PROCEDURE
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> fsiDutyCreateDailyPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] { new SqlParameter("P_BASE_DD", Types.VARCHAR),
                new SqlParameter("P_CUSER", Types.VARCHAR), new SqlOutParameter("O_CNT", Types.INTEGER),
                new SqlOutParameter("O_RTN", Types.VARCHAR), new SqlOutParameter("O_RTNMSG", Types.VARCHAR) };

        String procedureName = "FSI_EFF_CREATE_DAILY_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

}
