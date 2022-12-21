package com.hwfs.batch.fm.fmp.dao;

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
@Repository("/batch/sc/fmp/fmpUpjangOpRateUpdateProDAO")
public class FmpUpjangOpRateUpdateProDAO extends DefaultBatchDAO {

    /**
     * 식재영업 판매가일괄업데이트(배치-스케쥴)를 위한 프로시져
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> fmpUpjangOpRateUpdatePro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlOutParameter("PO_RTN",            Types.VARCHAR),
            new SqlOutParameter("PO_CNT",            Types.INTEGER),
            new SqlOutParameter("PO_RTNMSG",         Types.VARCHAR)
        };

        String procedureName = "FMP_UPJANG_OPRATE_MODIFY_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

}
