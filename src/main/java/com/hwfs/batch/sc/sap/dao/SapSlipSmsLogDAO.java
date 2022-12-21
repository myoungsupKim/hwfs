package com.hwfs.batch.sc.sap.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;


 /**
 * SapSlipSmsLogDAO에 대한 설명 작성
 * @ClassName SapSlipSmsLogDAO.java
 * @Description SapSlipSmsLogDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 02. 12.   김동표        최초생성
 * </pre>
 * @author FC종합전산구축 : 김동표
 * @since 2016. 02. 12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/sap/sapSlipSmsLogDAO")
public class SapSlipSmsLogDAO extends DefaultBatchDAO {

	/**
     * 전표전소 오류 SMS 문자 전송
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> sapSlipSmsLogPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlOutParameter("O_RTN_CD",            Types.VARCHAR),
            new SqlOutParameter("O_RTN_NM",            Types.VARCHAR),
        };

        String procedureName = "SAP_SLIP_SMS_LOG_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }
}
