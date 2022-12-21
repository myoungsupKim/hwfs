package com.hwfs.fs.fsl.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 선수금 식권 관리조회하는 UpjangMealTicketMgntPopup DAO
 * 
 * @ClassName UpjangMealTicketMgntPopupDAO.java
 * @Description UpjangMealTicketMgntPopupDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.21   	이지운        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 이지운
 * @since 2015.07.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsl/upjangMealTicketMgntPopupDAO")
public class UpjangMealTicketMgntPopupDAO extends DefaultDAO {
	
	/**
	 * 선수금 식권 관리조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangMealTicketMgntPopupList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangMealTicketMgntPopupDAO.selectUpjangMealTicketMgntPopupList", mapParam);
	}
	
	/**
	 * 선수금 식권 관리조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangMealTicketDetail(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangMealTicketMgntPopupDAO.selectUpjangMealTicketDetail", mapParam);
	}

	/**
	 * 선수금 식권 관리조회(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketMgntPopupDAO.insert", mapParam);
	}
	
	/**
	 * 선수금 식권 관리조회(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketMgntPopupDAO.update", mapParam);
	}
	
	/**
	 * 선수금 식권 관리조회(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketMgntPopupDAO.delete", mapParam);
	}
	
	
	/**
	 * 식권 판매 관리(을)를 등록, 삭제 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int ticket_insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketMgntPopupDAO.ticket_insert", mapParam);
	}
	
	public int ticket_update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketMgntPopupDAO.ticket_update", mapParam);
	}
	
	
	public int ticket_delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsl.upjangMealTicketMgntPopupDAO.ticket_delete", mapParam);
	}
	
	public String ticketMstGroupSeq(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fs.fsl.upjangMealTicketMgntPopupDAO.ticketMstGroupSeq", mapParam , null);
	}
	
	/**
	 * 선수금등록 매출 회수 내역
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangMealSaleRcvyMgntPopupList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangMealTicketMgntPopupDAO.selectUpjangMealSaleRcvyMgntPopupList", mapParam);
	}
	
	/**
	 * 선수금등록 입금 처리 내역
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangMealRecvDlngMgntPopupList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.upjangMealTicketMgntPopupDAO.selectUpjangMealRecvDlngMgntPopupList", mapParam);
	}
}
