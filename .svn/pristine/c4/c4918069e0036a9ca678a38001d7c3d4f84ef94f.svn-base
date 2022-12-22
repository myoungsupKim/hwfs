package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 카드 결제내역 조회하는 CardSettleDescInquiry DAO
 * 
 * @ClassName CardSettleDescInquiryDAO.java
 * @Description CardSettleDescInquiryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15   	유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.05.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/cardSettleDescInquiryDAO")
public class CardSettleDescInquiryDAO extends DefaultDAO {
	
	/**
	 * 카드 결제내역 조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.cardSettleDescInquiryDAO.selectList", mapParam);
	}

	/**
	 * 카드 결제내역 조회(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.cardSettleDescInquiryDAO.insert", mapParam);
	}
	
	/**
	 * 카드 결제내역 조회(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.cardSettleDescInquiryDAO.update", mapParam);
	}
	
	/**
	 * 카드 결제내역 조회(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.cardSettleDescInquiryDAO.delete", mapParam);
	}
	
}
