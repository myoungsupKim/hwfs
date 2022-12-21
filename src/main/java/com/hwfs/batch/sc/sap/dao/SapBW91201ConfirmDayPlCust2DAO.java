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
 * SapBW91201ConfirmDayPlCust2DAO에 대한 설명 작성
 * @ClassName SapBW91201ConfirmDayPlCust2DAO.java
 * @Description SapBW91201ConfirmDayPlCust2DAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 11. 06.   강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 강대성
 * @since 2015. 11. 06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/sap/sapBW91201ConfirmDayPlCust2DAO")
public class SapBW91201ConfirmDayPlCust2DAO extends DefaultBatchDAO {

	/**
     * 식재 매입매출 집계 BW 배치
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> sapBW91201ConfirmDayPlCust2Pro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlOutParameter("O_RTN_CD",            Types.VARCHAR),
            new SqlOutParameter("O_RTN_NM",            Types.VARCHAR),
        };

        String procedureName = "SCC_SAP_BW91201_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }
}
