package com.hwfs.sc.scc.dao;

import hone.core.util.record.RecordSet;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 조직에 대한 환경을 설정하는 HnrInterfaceResult DAO
 * 
 * @ClassName HnrInterfaceResultDAO.java
 * @Description HnrInterfaceResultDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  
 * </pre>
 * @author 
 * @since 
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scc/hnrInterfaceResultDAO")
public class HnrInterfaceResultDAO extends DefaultDAO {
	
	public RecordSet selectHnrInterfaceResult(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scc.hnrInterfaceResultDAO.selectHnrInterfaceResult", mapParam);
	}
	
	public int updateInterfaceOrderListAllY(Map<String, Object> parameter) throws Exception{
		return super.update("sc.scc.hnrInterfaceResultDAO.updateInterfaceOrderListAllY", parameter);
	}
	
	public int updateInterfaceOrderListAllN(Map<String, Object> parameter) throws Exception{
		return super.update("sc.scc.hnrInterfaceResultDAO.updateInterfaceOrderListAllN", parameter);
	}
	
	public int selectBatchExecution() throws Exception{
		return super.queryForInt("sc.scc.hnrInterfaceResultDAO.selectBatchExecution", "");
	}
	
}
