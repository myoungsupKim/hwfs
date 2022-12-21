package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 표준 vs 실제 원가 대비 보고서하는 RecipeCostReport DAO
 * 
 * @ClassName RecipeCostReportDAO.java
 * @Description RecipeCostReportDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.28   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.10.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/recipeCostReportDAO")
public class RecipeCostReportDAO extends DefaultDAO {
	
	/**
	 * 표준 vs 실제 원가 대비 보고서 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeCostReportDAO.selectList", mapParam);
	}

	/**
	 * 표준 vs 실제 원가 대비 보고서(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCostReportDAO.insert", mapParam);
	}
	
	/**
	 * 표준 vs 실제 원가 대비 보고서(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCostReportDAO.update", mapParam);
	}
	
	/**
	 * 표준 vs 실제 원가 대비 보고서(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeCostReportDAO.delete", mapParam);
	}
	
}
