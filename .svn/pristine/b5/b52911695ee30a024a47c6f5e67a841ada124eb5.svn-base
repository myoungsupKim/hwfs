package com.hwfs.sc.cmn.dao;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SlipNumDAO에 대한 설명 작성
 * @ClassName SlipNumDAO.java
 * @Description SlipNumDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 18.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 6. 18.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/slipNumDAO")
public class SlipNumDAO extends DefaultDAO {
	public String getSlipNum() throws Exception {
		SqlParameter[] sqlParameter = new SqlParameter[] {
	            new SqlOutParameter("O_SLIP_NUM", Types.VARCHAR)
			};

		Map<String, Object> parameter = new HashMap<String, Object>();
        Map<String, Object> output = super.callProcedure("SCC_SLIP_NUM_PRO", sqlParameter, parameter);

        return output.get("O_SLIP_NUM").toString();
	}
}
