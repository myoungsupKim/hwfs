package com.hwfs.sm.srm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SAP 전표 전송 내역을 조회하는 SapSlipSendReptPop DAO
 * 
 * @ClassName SapSlipSendReptPopDAO.java
 * @Description SapSlipSendReptPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.26   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.08.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/srm/sapSlipSendReptPopDAO")
public class SapSlipSendReptPopDAO extends DefaultDAO {
	
	/**
	 * SAP 전표 전송 내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipSendReptPopDAO.selectList", mapParam);
	}
	
}
