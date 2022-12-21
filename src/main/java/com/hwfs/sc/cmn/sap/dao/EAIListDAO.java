package com.hwfs.sc.cmn.sap.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * EAIListDAO에 대한 설명 작성
 *
 * @ClassName EAIListDAO.java
 * @Description EAIListDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 22.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 5. 22.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("EAIListDAO")
public class EAIListDAO extends DefaultDAO {

	/**
	 * 다건의 자료를 생성한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param queryId
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int insert(String queryId, List<?> mapParam) throws Exception {
		return super.batchUpdate2(queryId, mapParam);
	}
	
//	public void callSlipStatusProcedure() {
//		SqlParameter[] sqlParameter = new SqlParameter[] {
//	            new SqlParameter("P_DATE",             Types.VARCHAR)
//	    };
//
//	    Map<String, Object> parameter = new HashMap<String, Object>();
//	    parameter.put("P_DATE", "20150622");
//		
//		// procedure 호출
//        callProcedure("SAP_IFC_SLIP_STATUS2_PRO", sqlParameter, parameter);
//	}
}
