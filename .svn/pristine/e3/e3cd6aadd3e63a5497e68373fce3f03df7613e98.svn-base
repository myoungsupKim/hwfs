package com.hwfs.batch.sm.spm.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;


 /**
 * AdvanceTransDAO에 대한 설명 작성
 * @ClassName AdvanceTransDAO.java
 * @Description AdvanceTransDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019. 02. 18.   김호석        최초생성
 * </pre>
 * @author FC종합전산구축 : 김호석
 * @since 2019. 02. 18.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sm/spm/dao/AdvanceTransDAO")
public class AdvanceTransDAO extends DefaultBatchDAO {

	/**
     * 선수금이관 승인 처리
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> advanceTransPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlOutParameter("O_RTN",         Types.VARCHAR),
            new SqlOutParameter("O_CNT",         Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",        Types.VARCHAR)          
        };

        String procedureName = "IF_ADV_TRANS_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }
}
