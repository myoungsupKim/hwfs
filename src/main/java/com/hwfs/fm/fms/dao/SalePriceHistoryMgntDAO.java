package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 판매단가를 강제변경하는 SalePriceStChg DAO
 * 
 * @ClassName SalePriceStChgDAO.java
 * @Description SalePriceStChgDAO Class
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
@Repository("/fm/fms/salePriceHistoryMgntDAO")
public class SalePriceHistoryMgntDAO extends DefaultDAO {
	
	
	/**
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPeriod(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceHistoryMgntDAO.selectPeriod", mapParam);
	}
	
	/**
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceHistoryMgntDAO.selectList", mapParam);
	}
	
	/**
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCondList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceHistoryMgntDAO.selectCondList", mapParam);
	}
	
	/**
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTrendList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceHistoryMgntDAO.selectTrendList", mapParam);
	}
	
	/**
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTrendList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceHistoryMgntDAO.selectTrendList2", mapParam);
	}
	
	
	public RecordSet selectStatusList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceHistoryMgntDAO.selectStatusList", mapParam);
	}
	
	public RecordSet selectLstOrderList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceHistoryMgntDAO.selectLstOrderList", mapParam);
	}
	
	public RecordSet selectContractList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceHistoryMgntDAO.selectContractList", mapParam);
	}
	
	public RecordSet selectArrageList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceHistoryMgntDAO.selectArrageList", mapParam);
	}
	
	public int saveContractList(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceHistoryMgntDAO.saveContractList", mapParam);
	}
}
