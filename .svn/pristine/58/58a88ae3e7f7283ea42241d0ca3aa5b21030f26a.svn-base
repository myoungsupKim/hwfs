package com.hwfs.sm.cmn.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 마감처리/취소 하는 CloseCommon DAO
 * 
 * @ClassName CloseCommonDAO.java
 * @Description CloseCommonDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.27   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/cmn/closeCommonDAO")
public class CloseCommonDAO extends DefaultDAO {
	
	/**
	 * 마감처리/취소 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> callCloseProcedure(Map<String, Object> inParam, String callProcName) throws Exception {
		//전달 순서대로 설정
		SqlParameter[] sqlParameter = new SqlParameter[] {
		    new SqlParameter("P_OCCUR_DATE",    Types.VARCHAR),
		    new SqlParameter("P_SYS_CLASS",    	Types.VARCHAR),
		    new SqlParameter("P_UPJANG_CD",		Types.VARCHAR),
            new SqlOutParameter("O_RTN",    	Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG", 	Types.VARCHAR)
		};

		// procedure 호출
		return callProcedure(callProcName, sqlParameter, inParam);
	}
	
}
