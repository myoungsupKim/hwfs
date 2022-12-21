package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 상품권 청구하는 GiftBilling DAO
 * 
 * @ClassName GiftBillingDAO.java
 * @Description GiftBillingDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/giftBillingDAO")
public class GiftBillingDAO extends DefaultDAO {
	
	/**
	 * 상품권 청구 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.giftBillingDAO.selectList", mapParam);
	}
	
	/**
	 * 상품권환불금 잔액 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBalanceList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.giftBillingDAO.selectBalanceList", mapParam);
	}

	/**
	 * 상품권 청구(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.giftBillingDAO.insert", mapParam);
	}
	
	/**
	 * 상품권 청구(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.giftBillingDAO.update", mapParam);
	}
	
	/**
	 * 상품권 청구(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.giftBillingDAO.delete", mapParam);
	}
	
}
