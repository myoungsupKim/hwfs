package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
* SAP HWFC 거래처별 잔액비교 SapHwfcGapMon DAO Interface
* 
* @ClassName SapHwfcGapMonDAO.java
* @Description SapHwfcGapMonDAO Class
* @Modification-Information
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2018.09.20    김호석        최초생성
* </pre>
* @author 
* @since 2018.09.20
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2018 by HANWHA System/ICT CO.,LTD. All right reserved.
* </pre>
*/
@Repository("/sm/sar/sapHwfcGapMonDAO")
public class SapHwfcGapMonDAO extends DefaultDAO {
	
	/**
	 * SAP HWFC 거래처별 잔액비교 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.sapHwfcGapMonDAO.selectList", mapParam);
	}

}
