package com.hwfs.fm.fmc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 물류요청서등록하는 DistributionRequestRptReg DAO
 * 
 * @ClassName DistributionRequestRptRegDAO.java
 * @Description DistributionRequestRptRegDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.06   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.03.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmc/distributionRequestRptRegDAO")
public class DistributionRequestRptRegDAO extends DefaultDAO {
	
	/**
	 * 물류요청서 목록을 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("fm.fmc.distributionRequestRptRegDAO.selectList", parameter);
	}
	
	/**
	 * 물류요청서 마스터 목록을 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectMast(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("fm.fmc.distributionRequestRptRegDAO.selectMast", parameter);
	}
	

	/**
	 * 물류요청서(을)를 등록한다.
	 *
	 * @param parameter
	 * @return
	 */
	public int insert(Map<String, Object> parameter) throws Exception {
		return super.update("fm.fmc.distributionRequestRptRegDAO.insert", parameter);
	}
	
	/**
	 * 물류요청서 마스터(을)를 등록한다.
	 *
	 * @param parameter2
	 * @return
	 */
	public int insertMast(Map<String, Object> parameter2) throws Exception {
		return super.update("fm.fmc.distributionRequestRptRegDAO.insertMast", parameter2);
	}
	
	
	/**
	 * 물류요청서(을)를 수정한다.
	 *
	 * @param parameter
	 * @return
	 */
	public int update(Map<String, Object> parameter) throws Exception {
		return super.update("fm.fmc.distributionRequestRptRegDAO.update", parameter);
	}
	
	/**
	 * 물류요청서(을)를 삭제한다.
	 *
	 * @param parameter
	 * @return
	 */
	public int delete(Map<String, Object> parameter) throws Exception {
		return super.update("fm.fmc.distributionRequestRptRegDAO.delete", parameter);
	}
	
}
