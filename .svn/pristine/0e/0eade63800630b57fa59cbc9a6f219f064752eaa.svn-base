package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 가수금 계좌번호 조회팝업하는 BankNumPopup DAO
 * 
 * @ClassName BankNumPopupDAO.java
 * @Description BankNumPopupDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.15   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/bankNumPopupDAO")
public class BankNumPopupDAO extends DefaultDAO {
	
	/**
	 * 가수금 계좌번호 조회팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.bankNumPopupDAO.selectList", mapParam);
	}

	/**
	 * 가수금 계좌번호 조회팝업(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.bankNumPopupDAO.insert", mapParam);
	}
	
	/**
	 * 가수금 계좌번호 조회팝업(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.bankNumPopupDAO.update", mapParam);
	}
	
	/**
	 * 가수금 계좌번호 조회팝업(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.bankNumPopupDAO.delete", mapParam);
	}
	
}
