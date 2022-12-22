package com.hwfs.fs.fsm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 코드를 조회하는 MachineCodePop DAO
 * 
 * @ClassName MachineCodePopDAO.java
 * @Description MachineCodePopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.13   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.03.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsm/machineCodePopDAO")
public class MachineCodePopDAO extends DefaultDAO {
	
	/**
	 * 코드 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPopCodeList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsm.machineCodePopDAO.selectPopCodeList", mapParam);
	}
	
}
