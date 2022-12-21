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
 * @ClassName FmsMenupriceupdProDAO.java
 * @Description FmsMenupriceupdProDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 22.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 6. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/fms/fmsMenupriceupdProDAO")
public class FmsMenupriceupdProDAO extends DefaultBatchDAO {

    /**
     * 식재영업 식단작성 단가 재 생성 PROCEDURE
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> fmsMenupriceupdPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_DATE",              Types.VARCHAR),
            new SqlParameter("P_UPJANG",            Types.VARCHAR),
            new SqlOutParameter("O_CNT",            Types.INTEGER),
            new SqlOutParameter("O_RTN",            Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",         Types.VARCHAR)
        };

        String procedureName = "FMS_MENUPRICEUPD_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

}
