package com.hwfs.batch.sc.sap.dao;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;
import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SapFI06602InUseDAO에 대한 설명 작성
 * @ClassName SapFI06602InUseDAO.java
 * @Description SapFI06602InUseDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 22.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 6. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/sap/sapFI06602InUseDAO")
public class SapFI06602InUseDAO extends DefaultBatchDAO {

	public Map<String, Object> create() throws Exception {
//        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_DATE",             Types.VARCHAR)
        };

        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("P_DATE", "20150622");

       // String procedureName = "FMS_SUBULCREATE_JOB_PRO";

        // procedure 호출
        return callProcedure("SCC_SAP_FI06602_PRO", sqlParameter, parameter);
    }
}
