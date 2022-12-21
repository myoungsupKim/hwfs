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
 * @ClassName FmsEventMgntJobProDAO.java
 * @Description FmsEventMgntJobProDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.07.26.   Jaey        최초생성
 * </pre>
 * @author FC종합전산구축 : Jaey
 * @since 2021.07.26
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/fms/fmsEventMgntJobProDAO")
public class FmsEventMgntJobProDAO extends DefaultBatchDAO {

    /**
     * 행사관리 이벤트상태 및 사용여부 자동갱신 PROCEDURE
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> fmsEventMgntJobPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlOutParameter("O_CNT",            Types.INTEGER),
            new SqlOutParameter("O_RTN",            Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",         Types.VARCHAR)
        };

        String procedureName = "FMS_EVENT_MST_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }
    

}
