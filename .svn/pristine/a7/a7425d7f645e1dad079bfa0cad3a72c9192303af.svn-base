package com.hwfs.batch.sc.cmn.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

 /**
 * HwfcHrIFDAO에 대한 설명 작성
 * @ClassName HwfcHrIFDAO.java
 * @Description HwfcHrIFDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.04.11.   김명섭        최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2019.04.11.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/cmn/dao/HwfcHrIFDAO")
public class HwfcHrIFDAO extends DefaultBatchDAO {

    public Map<String, Object> hwfcHrIFPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("strInParams",         Types.VARCHAR),
            new SqlParameter("strUserID",           Types.VARCHAR),
            new SqlParameter("strUserIP",           Types.VARCHAR),
            new SqlParameter("strHPtr",             Types.VARCHAR),
            new SqlOutParameter("lngRtn",           Types.INTEGER),
            new SqlOutParameter("lngCount",         Types.INTEGER),
            new SqlOutParameter("strDesc",          Types.VARCHAR)
        };

        String procedureName = "IF_HWFC_HR_INFO_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

}
