package com.hwfs.fs.fso.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장 정보 활용장표하는 UpjangInfoCycleRept DAO
 * 
 * @ClassName UpjangInfoCycleReptDAO.java
 * @Description UpjangInfoCycleReptDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.07   	박준석        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 박준석
 * @since 2015.07.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fso/upjangInfoCycleReptDAO")
public class UpjangInfoCycleReptDAO extends DefaultDAO {
	
	/**
	 * 업장 정보 활용장표 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.upjangInfoCycleReptDAO.selectList", mapParam);
	}
	
	/**
	 * 업장 정보 활용장표 목록(급식)을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.upjangInfoCycleReptDAO.selectUpjangList2", mapParam);
	}

	/**
	 * 업장 정보 활용장표 목록을 상세조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.upjangInfoCycleReptDAO.selectUpjangInfo", mapParam);
	}

	/**
	 * 업장 메뉴 및 식단가 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangMenu(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.upjangInfoCycleReptDAO.selectUpjangMenu", mapParam);
	}
	
	/**
	 * 임대/보증금 현황 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectGuarantyAmtInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.upjangInfoCycleReptDAO.selectGuarantyAmtInfo", mapParam);
	}
	
	/**
	 * 아이템 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.upjangInfoCycleReptDAO.selectItem", mapParam);
	}
	
	/**
	 * P/L 정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPlinfoListA(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.upjangInfoCycleReptDAO.selectPlinfoListA", mapParam);
	}
	public RecordSet selectPlinfoListB(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.upjangInfoCycleReptDAO.selectPlinfoListB", mapParam);
	}
	
	/**
	 * P/L 정보 열람 가능여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPlviewCheck(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.upjangInfoCycleReptDAO.selectPlviewCheck", mapParam);
	}
	
	/**
	 * P/L 정보 열람관리 중복대상을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPlviewDupCheck(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.upjangInfoCycleReptDAO.selectPlviewDupCheck", mapParam);
	}
	
	/**
	 * P/L 정보 열람관리를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPlviewSignList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.upjangInfoCycleReptDAO.selectPlviewSignList", mapParam);
	}
	
	/**
	 * P/L 정보 열람관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertPlviewSign(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.upjangInfoCycleReptDAO.insertPlviewSign", mapParam);
	}
	
	/**
	 * P/L 정보 열람관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updatePlviewSign(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.upjangInfoCycleReptDAO.updatePlviewSign", mapParam);
	}
	
	/**
	 * P/L 정보 열람관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deletePlviewSign(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.upjangInfoCycleReptDAO.deletePlviewSign", mapParam);
	}
	
}
