package com.hwfs.ma.mas.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식권교환하는 TicketTrade DAO
 * 
 * @ClassName TicketTradeDAO.java
 * @Description TicketTradeDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.19   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.11.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ma/mas/ticketTradeDAO")
public class TicketTradeDAO extends DefaultDAO {
	
	/**
	 * 식권교환 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int ticketQty(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("ma.mas.ticketTradeDAO.ticketQty", mapParam);
	}
	
	/**
	 * 식권교환 순번을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet ticketSeq(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ma.mas.ticketTradeDAO.ticketSeq", mapParam);
	}
	
	/**
	 * 식권교환 순번을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int masTicketMstS(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("ma.mas.ticketTradeDAO.masTicketMstS", mapParam);
	}
	

	/**
	 * 식권교환(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertS(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.mas.ticketTradeDAO.insertS", mapParam);
	}
	public int insertE(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.mas.ticketTradeDAO.insertE", mapParam);
	}
	
	/**
	 * 식권교환(을)를 히스토리 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertHis(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.mas.ticketTradeDAO.insertHis", mapParam);
	}
	
	/**
	 * 식권교환(을)를 His 상태를 D로 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteChg(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.mas.ticketTradeDAO.deleteChg", mapParam);
	}
	
	/**
	 * 식권교환(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.mas.ticketTradeDAO.delete", mapParam);
	}
	
	/**
	 * 식권교환(을)를 식권 삭제 여부 확인한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String delYn(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("ma.mas.ticketTradeDAO.delYn", mapParam, null);
	}
	
	/**
	 * 식권교환(을)를 식권 선수금등록 여부 확인한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String selectReceiptNum(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("ma.mas.ticketTradeDAO.selectReceiptNum", mapParam, null);
	}
	
	
	
}
