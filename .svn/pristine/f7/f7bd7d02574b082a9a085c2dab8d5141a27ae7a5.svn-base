package com.hwfs.ms.mom.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 추가발주현황 조회하는 AdditionOrderReport DAO
 * 
 * @ClassName AdditionOrderReportDAO.java
 * @Description AdditionOrderReportDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.09   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 현장지원_모바일 강대성
 * @since 2015.06.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/mom/additionOrderReportDAO")
public class AdditionOrderReportDAO extends DefaultDAO {
	
	/**
	 * 추가발주현황 조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mom.additionOrderReportDAO.selectList", mapParam);
	}
	
	/**
	 * 추가발주현황 조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListOld(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mom.additionOrderReportDAO.selectListOld", mapParam);
	}

	/**
	 * 추가발주현황(상세) 조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDetailList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mom.additionOrderReportDAO.selectDetailList", mapParam);
	}
	
}
