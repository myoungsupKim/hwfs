package com.hwfs.sc.app.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.util.DateUtil;
import com.hwfs.sc.app.dao.DefaultfdappDAO;
 /**
 * 식재앱 마리아DB 인터페이스 DAO
 * 
 * @ClassName MaintenanceMariadbDAO.java
 * @Description MaintenanceMariadbDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.12.15.   김명섭        최초생성
 * </pre>
 */
@Repository("/sc/app/maintenanceMariadbDAO")
public class MaintenanceMariadbDAO extends DefaultfdappDAO {

	/**
	 * 단가 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectFsale(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.maintenanceMariadbDAO.selectFsale", parameter);
	}

	public int sendFsale(Map<String, Object> parameter) throws Exception{
		return super.update("sc.app.maintenanceMariadbDAO.sendFsale", parameter);
	}
	
}
