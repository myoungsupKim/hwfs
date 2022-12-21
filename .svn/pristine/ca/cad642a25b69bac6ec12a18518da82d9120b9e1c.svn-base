package com.hwfs.batch.sc.cmn.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

 /**
 * CmnEhrGntDAO에 대한 설명 작성
 * @ClassName CmnEhrGntDAO.java
 * @Description CmnEhrGntDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018. 8. 13.   901X5L        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 901X5L
 * @since 2018. 8. 13.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/cmn/dao/CmnEhrGntDAO")
public class CmnEhrGntDAO extends DefaultBatchDAO {
	 /**
     * e-HR 근태정보 복사 PROCEDURE
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> cmnEhrGntPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {    
                //new SqlOutParameter("PI_DATE",            Types.VARCHAR),
                //new SqlOutParameter("PI_SABUN",            Types.VARCHAR),
                new SqlOutParameter("O_RTN",         Types.VARCHAR),
                new SqlOutParameter("O_RTNMSG",        Types.VARCHAR)                
        };

        String procedureName = "IF_EHR_GNT_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }
}
