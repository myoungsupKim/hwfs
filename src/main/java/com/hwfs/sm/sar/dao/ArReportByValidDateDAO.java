package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * AR잔액조회(유효일자별)하는 ArReportByValidDate DAO
 * 
 * @ClassName ArReportByValidDateDAO.java
 * @Description ArReportByValidDateDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.11   	유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.05.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/arReportByValidDateDAO")
public class ArReportByValidDateDAO extends DefaultDAO {
	
	/**
	 * AR잔액조회(유효일자별) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.arReportByValidDateDAO.selectList", mapParam);
	}
	public RecordSet selectListSimple(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.arReportByValidDateDAO.selectListSimple", mapParam);
	}

	/**
	 * AR잔액조회(유효일자별)(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arReportByValidDateDAO.insert", mapParam);
	}
	
	/**
	 * AR잔액조회(유효일자별)(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arReportByValidDateDAO.update", mapParam);
	}
	
	/**
	 * AR잔액조회(유효일자별)(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arReportByValidDateDAO.delete", mapParam);
	}
	
}
