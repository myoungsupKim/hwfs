package com.hwfs.batch.fm.fms.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

/**
 * FMS JOB Schedule Dao Class
 *
 * @ClassName FmsCrtCrdInfoDAO.java
 * @Description FmsCrtCrdInfoDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.05.30   kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : kihoon
 * @since 2018.05.30
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/fm/fms/fmsBuySaleSumDAO")
public class FmsBuySaleSumDAO extends DefaultBatchDAO {

	/**
	 * 매출집계정보 실행
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> callCheckExcute(Map<String, Object> inParam) throws Exception {
		
		SqlParameter[] sqlParameter = new SqlParameter[]{
				new SqlParameter("P_GUBUN",		Types.VARCHAR),
				new SqlOutParameter("O_RTN",    Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};
		return callProcedure("SP_FMS_BUY_SALE_SUM_EXEC_PRO", sqlParameter, inParam);	
	}

}
