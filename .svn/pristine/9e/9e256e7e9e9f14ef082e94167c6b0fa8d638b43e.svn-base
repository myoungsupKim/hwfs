package com.hwfs.ma.mak.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * DriveMgnt DAO
 * 
 * @ClassName DriveMgntDAO.java
 * @Description DriveMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.02.11   	kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 kihoon
 * @since 2019.02.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ma/mak/driveMgntDAO")
public class DriveMgntDAO extends DefaultDAO {
	
	/**
	 * 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCarList(Map<String, Object> mapParam) throws Exception {
			return super.queryForRecordSet("ma.mak.driveMgntDAO.selectCarList", mapParam);
	}
	
	public RecordSet selectCarDetail(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ma.mak.driveMgntDAO.selectCarDetail", mapParam);
	}
	
	public RecordSet selectCheckCarInfo(Map<String, Object> mapParam) {
		return super.queryForRecordSet("ma.mak.driveMgntDAO.selectCheckCarInfo", mapParam);
	}
	
	public int insertCarInfo(Map<String, Object> parameter) {
		return super.update("ma.mak.driveMgntDAO.insertCarInfo", parameter);
	}
	
	public int updateCarInfo(Map<String, Object> parameter) {
		return super.update("ma.mak.driveMgntDAO.updateCarInfo", parameter);
	}
	
	public int updateCarInfoReset(Map<String, Object> parameter) {
		return super.update("ma.mak.driveMgntDAO.updateCarInfoReset", parameter);
	}
	
	public int deleteCarInfo(Map<String, Object> parameter) {
		return super.update("ma.mak.driveMgntDAO.deleteCarInfo", parameter);
	}
	
	public Record selectGwDraftMst(Map<String, Object> parameter) {
		return super.queryForRecord("ma.mak.driveMgntDAO.selectGwDraftMst", parameter);
	}
	
	public int updateSignInfo(Map<String, Object> parameter) {
		return super.update("ma.mak.driveMgntDAO.updateSignInfo", parameter);
	}
}
