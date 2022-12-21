package com.hwfs.batch.sc.sap.dao;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;
import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SapFI03601AcctMmSumDAO에 대한 설명 작성
 * @ClassName SapFI03601AcctMmSumDAO.java
 * @Description SapFI03601AcctMmSumDAO Class
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
@Repository("/batch/sc/sap/sapFI02801WholeSaleMmSumDAO")
public class SapFI02801WholeSaleMmSumDAO extends DefaultBatchDAO {

	/**
     * 도매유통 수불 집계내역
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> sapFI02801WholeSaleMmSumPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlOutParameter("O_RTN_CD",            Types.VARCHAR),
            new SqlOutParameter("O_RTN_NM",            Types.VARCHAR),
        };

        String procedureName = "SCC_SAP_FI02801_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }
}
