package com.hwfs.sc.scc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
 /**
 * HnrFicsOrderInterfaceSqlDAO
 * 
 * @ClassName HnrFicsOrderInterfaceSqlDAO.java
 * @Description HnrFicsOrderInterfaceSqlDAO Class
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
@Repository("/sc/scc/hnrFicsOrderInterfaceSqlDAO")
public class HnrFicsOrderInterfaceSqlDAO extends DefaultDAO {
	
	public RecordSet selectBatchOrderList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.scc.HnrFicsOrderInterfaceSqlDAO.selectBatchOrderList", parameter);
	}
	
	public int updateInterfaceOrderListAllY(Map<String, Object> parameter) throws Exception{
		return super.update("sc.scc.HnrFicsOrderInterfaceSqlDAO.updateInterfaceOrderListAllY", parameter);
	}
	
	public int updateInterfaceOrderListAllN(Map<String, Object> parameter) throws Exception{
		return super.update("sc.scc.HnrFicsOrderInterfaceSqlDAO.updateInterfaceOrderListAllN", parameter);
	}
	
	

}
