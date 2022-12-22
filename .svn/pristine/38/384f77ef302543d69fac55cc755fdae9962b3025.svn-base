package com.hwfs.fs.fsc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 케터링 스케줄보고하는 CateringSchlRept DAO
 * 
 * @ClassName CateringSchlReptDAO.java
 * @Description CateringSchlReptDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18   	yanghj        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 yanghj
 * @since 2015.03.18
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsc/cateringSchlReptDAO")
public class CateringSchlReptDAO extends DefaultDAO {
	
	/**
	 * 케터링 스케줄보고(사업장 주요행사 계획<행사실적>) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCeleList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsc.cateringSchlReptDAO.selectCeleList", mapParam);
	}
	
	/**
	 * 케터링 스케줄보고(사업장 인력지원 계획<조리인력>) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCookHumanList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsc.cateringSchlReptDAO.selectCookHumanList", mapParam);
	}
	
	/**
	 * 케터링 스케줄보고(개인별근무 스케줄 리스트) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPlanList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsc.cateringSchlReptDAO.selectPlanList", mapParam);
	}

	
	/**
	 * 케터링 스케줄보고(개인별근무 스케줄 달력) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCalendarList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsc.cateringSchlReptDAO.selectCalendarList", mapParam);
	}

	/**
	 * 케터링 스케줄보고(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsc.cateringSchlReptDAO.insert", mapParam);
	}
	
	/**
	 * 케터링 스케줄보고(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsc.cateringSchlReptDAO.update", mapParam);
	}
	
	/**
	 * 케터링 스케줄보고(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsc.cateringSchlReptDAO.delete", mapParam);
	}
	
}
