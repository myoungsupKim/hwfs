package com.hwfs.fm.fmc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 물류요청서처리하는 DistributionRequestRptProc DAO
 * 
 * @ClassName DistributionRequestRptProcDAO.java
 * @Description DistributionRequestRptProcDAO Class
 * @Modification-Informationf
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.11   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.03.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmc/distributionRequestRptProcDAO")
public class DistributionRequestRptProcDAO extends DefaultDAO {
	
	/**
	 * 물류요청서 목록을 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("fm.fmc.distributionRequestRptProcDAO.selectList", parameter);
	}
	/**
	 * 물류요청서 마스터 목록을 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectMast(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("fm.fmc.distributionRequestRptProcDAO.selectMast", parameter);
	}

	/**
	 * 물류요청서(을)를 등록한다.
	 *
	 * @param parameter
	 * @return
	 */
	public int insert(Map<String, Object> parameter) throws Exception {
		return super.update("fm.fmc.distributionRequestRptProcDAO.insert", parameter);
	}
	
	/**
	 * 물류요청서 마스터(을)를 등록한다.
	 *
	 * @param parameter
	 * @return
	 */
	public int insertMast(Map<String, Object> parameter) throws Exception {
		return super.update("fm.fmc.distributionRequestRptProcDAO.insertMast", parameter);
	}
	
	/**
	 * 물류요청서(을)를 수정한다.
	 *
	 * @param parameter
	 * @return
	 */
	public int update(Map<String, Object> parameter) throws Exception {
		return super.update("fm.fmc.distributionRequestRptProcDAO.update", parameter);
	}
	
	/**
	 * 물류요청서 마스터(을)를 수정한다.
	 *
	 * @param parameter
	 * @return
	 */
	public int updateMast(Map<String, Object> parameter) throws Exception {
		return super.update("fm.fmc.distributionRequestRptProcDAO.updateMast", parameter);
	}
	
	/**
	 * 물류요청서 마스터 파일(을)를 수정한다.
	 *
	 * @param parameter
	 * @return
	 */
	public int updateMastFile(Map<String, Object> inVar) throws Exception {
		return super.update("fm.fmc.distributionRequestRptProcDAO.updateMastFile", inVar);
	}
	
	
	/**
	 * 물류요청서(을)를 삭제한다.
	 *
	 * @param parameter
	 * @return
	 */
	public int delete(Map<String, Object> parameter) throws Exception {
		return super.update("fm.fmc.distributionRequestRptProcDAO.delete", parameter);
	}
}
