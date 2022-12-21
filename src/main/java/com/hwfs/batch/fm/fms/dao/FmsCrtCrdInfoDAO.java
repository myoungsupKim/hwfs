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
 * @ClassName FmsCrtCrdInfoDAO.java
 * @Description FmsCrtCrdInfoDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 1. 21.   lionfrnd        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS lionfrnd
 * @since 2016. 1. 21.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/fm/fms/fmsCrtCrdInfoDAO")
public class FmsCrtCrdInfoDAO extends DefaultBatchDAO {

    /**
     * 식재영업 일별 여신정보 및 월별데이터 자동생성 PROCEDURE
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> fmsCrtCrdInfoJobPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            //new SqlParameter("P_UPJANG",            Types.VARCHAR),
            //new SqlParameter("P_SUBINV_CODE",       Types.VARCHAR),
            //new SqlParameter("PI_DATE",              Types.VARCHAR),
            //new SqlParameter("P_CUSER",             Types.VARCHAR),
        	new SqlOutParameter("PO_RTN",            Types.VARCHAR),
        	new SqlOutParameter("PO_CNT",            Types.INTEGER),
            new SqlOutParameter("PO_RTNMSG",         Types.VARCHAR)
        };

        String procedureName = "FMS_CRTCRDINFO_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

}
