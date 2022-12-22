package com.hwfs.fm.fmc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 발주대비클레임건수하는 OrderClaimCnt DAO
 * 
 * @ClassName OrderClaimCntDAO.java
 * @Description OrderClaimCntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.29   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통하영업 최영준
 * @since 2015.05.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmc/orderClaimCntDAO")
public class OrderClaimCntDAO extends DefaultDAO {
	
	/**
	 * 발주대비클레임건수 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet upjangSearch(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.upjangSearch", mapParam);
	}
	
	/**
	 * 발주대비클레임건수 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet custSearch(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.custSearch", mapParam);
	}
	
	/**
	 * 발주대비클레임건수 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet custDetailSearch(Map<String, Object> mapParam) throws Exception {
		if ( "NEW".equals(mapParam.get("schType").toString()) ) {
			return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.custDetailSearch_rvn", mapParam);
		} else {
			return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.custDetailSearch", mapParam);
		}
		
	}
	
	/**
	 * 발주대비클레임건수 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet subCustSearch(Map<String, Object> mapParam) throws Exception {
		if ( "NEW".equals(mapParam.get("schType").toString()) ) {
			return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.subCustSearch_rvn", mapParam);
		} else {
			return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.subCustSearch", mapParam);
		}
		
	}
	
	/**
	 * 발주대비클레임건수 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet itemSearch(Map<String, Object> mapParam) throws Exception {
		if ( "NEW".equals(mapParam.get("schType").toString()) ) {
			return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.itemSearch_rvn", mapParam);
		} else {
			return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.itemSearch", mapParam);
		}
	}

	/**
	 * 일자기간 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet dayTermSearchVs(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.dayTermSearchVs", mapParam);
	}
	
	/**
	 * 일자기간 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet dayTermSearch(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.dayTermSearch", mapParam);
	}
	
	/**
	 * 월별 기간 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet monthTermSearch(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.monthTermSearch", mapParam);
	}
	
	/**
	 * 유형별 클레임발생현황을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet chartSearch(Map<String, Object> mapParam) throws Exception {
		if ( "01".equals(mapParam.get("schTgGnb").toString()) ) {	// 영업
			return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.chartSearchFc", mapParam);
		} else {
			return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.chartSearch", mapParam);
		}
	}
	
	/**
	 * 유형별 클레임발생현황을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet typeSearch(Map<String, Object> mapParam) throws Exception {
		
		if ( "01".equals(mapParam.get("schTgGnb").toString()) ) {	// 영업
			return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.typeSearchFc", mapParam);
		} else {
			return super.queryForRecordSet("fm.fmc.orderClaimCntDAO.typeSearch", mapParam);
		}
	}
	
	/**
	 * 발주대비클레임건수(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.orderClaimCntDAO.insert", mapParam);
	}
	
	/**
	 * 발주대비클레임건수(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.orderClaimCntDAO.update", mapParam);
	}
	
	/**
	 * 발주대비클레임건수(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.orderClaimCntDAO.delete", mapParam);
	}
	
}
