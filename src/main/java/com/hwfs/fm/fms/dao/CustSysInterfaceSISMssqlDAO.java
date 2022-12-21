package com.hwfs.fm.fms.dao;

import java.util.Map;
import org.springframework.stereotype.Repository;
import com.hwfs.sc.cmn.defaults.DefaultSISDAO;
/**
 *
 *
 */
@Repository("/fm/fms/custSysInterfaceSISMssqlDAO")
public class CustSysInterfaceSISMssqlDAO extends DefaultSISDAO {
	public int updateSubinvInfo(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceSISMssqlDAO.updateSISSubinv", mapParam);
	}
	public int updateSuspenseInfo(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.custSysInterfaceSISMssqlDAO.updateSISSuspense", mapParam);
	}
}
