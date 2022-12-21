package com.hwfs.batch.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

/**
 * FMS JOB Schedule Dao Class
 *
 * @ClassName FmsReturnOrderConfirmJobProDAO.java
 * @Description FmsReturnOrderConfirmJobProDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.09.14   DEV02        최초생성
 * </pre>
 * @author FC종합전산구축 : [PJT]주문채널통합
 * @since 2021.09.14
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/fms/fmsReturnOrderConfirmJobProDAO")
public class FmsReturnOrderConfirmJobProDAO extends DefaultBatchDAO {

    /**
     * 반환/교환/증정 주문 확정 / 검증 PROCEDURE
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> fmsReturnOrderConfirmJobPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_HHMM",              Types.VARCHAR),
            new SqlOutParameter("O_CNT",            Types.INTEGER),
            new SqlOutParameter("O_RTN",            Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",         Types.VARCHAR)
        };

        String procedureName = "FMS_RETURN_ORDER_CONFIRM_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }
    
}
