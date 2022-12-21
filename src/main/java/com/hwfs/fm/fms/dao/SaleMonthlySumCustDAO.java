package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SaleMonthlySumCustDAO
 * 
 * @ClassName SaleMonthlySumCustDAO.java
 * @Description SaleMonthlySumCustDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.06.04   	kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 kihoon
 * @since 2018.06.0
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/saleMonthlySumCustDAO")
public class SaleMonthlySumCustDAO extends DefaultDAO {
	
	
	/**
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPeriod(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.saleMonthlySumCustDAO.selectPeriod", mapParam);
	}
	
	/**
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMaxDt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.saleMonthlySumCustDAO.selectMaxDt", mapParam);
	}
	
	/**
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.saleMonthlySumCustDAO.selectList", mapParam);
	}
}
