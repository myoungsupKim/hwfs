package com.hwfs.batch.ma.map.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

/**
 * FMS JOB Schedule Dao Class
 *
 * @ClassName MapDayActjobPro3Dao.java
 * @Description MapDayActjobPro3Dao Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 10. 13.   김태윤        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김태윤
 * @since 2015. 10. 13.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/map/MapDayActjobPro3DAO")
public class MapDayActjobPro3DAO extends DefaultBatchDAO {

    /**
     * 매출데이터 강제생성
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> mapDayactjobPro3(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            //new SqlParameter("I_DATE_F",         Types.VARCHAR),
            //new SqlParameter("I_DATE_T",         Types.VARCHAR),
            //new SqlParameter("I_PART_CODE",      Types.VARCHAR),
            //new SqlParameter("I_SABUN",          Types.VARCHAR),
            new SqlOutParameter("O_RTN",         Types.VARCHAR),
            new SqlOutParameter("O_CNT",         Types.INTEGER),
            new SqlOutParameter("O_RTNMSG",      Types.VARCHAR)
        };

        String procedureName = "MAP_DAY_CUST_INSERT_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

}
