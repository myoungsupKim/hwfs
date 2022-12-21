package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 신용카드승인정보팝업하는 CardApprvPopup DAO
 * 
 * @ClassName CardApprvPopupDAO.java
 * @Description CardApprvPopupDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.03   	유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.06.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/cardApprvPopupDAO")
public class CardApprvPopupDAO extends DefaultDAO {
	
	/**
	 * 신용카드승인정보팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.cardApprvPopupDAO.selectList", mapParam);
	}

	/**
	 * 신용카드승인정보팝업(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.cardApprvPopupDAO.insert", mapParam);
	}
	
	/**
	 * 신용카드승인정보팝업(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.cardApprvPopupDAO.update", mapParam);
	}
	
	/**
	 * 신용카드승인정보팝업(을)를 취소한다.
	 * @param mapParam
	 * @return
	 */
	public int cardApprvInfoCancel(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.cardApprvPopupDAO.cardApprvInfoCancel", mapParam);
	}
	
	/**
	 * 신용카드승인정보팝업(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.cardApprvPopupDAO.delete", mapParam);
	}
	
}
