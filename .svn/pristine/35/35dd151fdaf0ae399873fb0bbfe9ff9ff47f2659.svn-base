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
 * @ClassName FmpUpjangOpRateUpdateProDAO.java
 * @Description FmpUpjangOpRateUpdateProDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 11. 06.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재 dskang815
 * @since 2015. 11. 06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/fm/fms/fmsPydTempDao")
public class FmsPydTempDao extends DefaultBatchDAO {

    /**
     * 용대 배치 테스트
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> fmsPydTestPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlOutParameter("PO_RTN",            Types.VARCHAR),
            new SqlOutParameter("PO_CNT",            Types.INTEGER),
            new SqlOutParameter("PO_RTNMSG",         Types.VARCHAR)
        };

        //String procedureName = "FMS_PYD_TEMP_PRO";
        String procedureName = "FMS_CRTCRDINFO_PRO";
        
        System.out.println("####################################");
        System.out.println("System.out.println 용대 테스트 ");
        System.out.println("####################################");
        
        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

}
