package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 채권 거래처/업장 이관 처리하는 ArCustTransferPop DAO
 * 
 * @ClassName ArCustTransferPopDAO.java
 * @Description ArCustTransferPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.28   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/arCustTransferPopDAO")
public class ArCustTransferPopDAO extends DefaultDAO {
	
	/**
	 * 채권 거래처/업장 이관 처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.arCustTransferPopDAO.selectList", mapParam);
	}
	
	/**
	 * 채권 거래처/업장 이관 처리 시 거래처에 해당되는 업장 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.arCustTransferPopDAO.selectUpjangList", mapParam);
	}
	
	/**
	 * 업장번호 채번
	 * @param mapParam
	 * @return
	 */
	public String selectMaxUpjangSalsNum(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.sar.arCustTransferPopDAO.selectMaxUpjangSalsNum", mapParam, null);
	}

	/**
	 * 채권 거래처/업장 이관 처리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arCustTransferPopDAO.insert", mapParam);
	}
	
	/**
	 * 업장매출확보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUpjangSals(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arCustTransferPopDAO.insertUpjangSals", mapParam);
	}
	
	/**
	 * 업장매출확보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUpjangSals(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arCustTransferPopDAO.updateUpjangSals", mapParam);
	}
	
	/**
	 * 업장매출확보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjangSals(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arCustTransferPopDAO.update", mapParam);
	}
	
	/**
	 * 채권 거래처/업장 이관 처리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arCustTransferPopDAO.update", mapParam);
	}
	
	/**
	 * 채권 거래처/업장 이관 처리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arCustTransferPopDAO.delete", mapParam);
	}
}
