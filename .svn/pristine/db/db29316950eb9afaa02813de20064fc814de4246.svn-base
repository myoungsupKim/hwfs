package com.hwfs.batch.rc.sle.dao;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;
import com.hwfs.sc.cmn.util.DateUtil;

 /**
 * SleMenuSumDAO에 대한 설명 작성
 * @ClassName SleMenuSumDAO.java
 * @Description SleMenuSumDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 02.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 포스 영업관리
 * @since 2015.9. 02.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/rc/sle/sleEodMagamMgmtDAO")
public class SleEodMagamMgmtDAO extends DefaultBatchDAO {

	public Map<String, Object> create() throws Exception {
//        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("V_DATE", Types.VARCHAR),
            new SqlOutParameter("O_RTN", Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
        };

        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("V_DATE", DateUtil.addDay(-1, "yyyyMMdd"));

      
       // String procedureName = "FMS_SUBULCREATE_JOB_PRO";

        // procedure 호출
        return super.callProcedure("SLE_UPJANG_MAGAM_PRO", sqlParameter, parameter);
    }
}
