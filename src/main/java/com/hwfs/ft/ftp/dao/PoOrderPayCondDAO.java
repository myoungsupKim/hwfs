package com.hwfs.ft.ftp.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 구매 주문 지불 조건하는 PoOrderPayCond DAO
 * 
 * @ClassName PoOrderPayCondDAO.java
 * @Description PoOrderPayCondDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.20   	KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 KJJ
 * @since 2015.03.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/ftp/poOrderPayCondDAO")
public class PoOrderPayCondDAO extends DefaultDAO {
	
	/**
	 * 구매 주문 지불 조건 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ft.ftp.poOrderPayCondDAO.selectList", mapParam);
	}

	/**
	 * 구매 주문 지불 조건 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.ftp.poOrderPayCondDAO.insert", mapParam);
	}
	
	/**
	 * 구매 주문 지불 조건 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.ftp.poOrderPayCondDAO.update", mapParam);
	}
	
	/**
	 * 구매 주문 지불 조건 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.ftp.poOrderPayCondDAO.delete", mapParam);
	}

	/**
	 * 구매 주문 지불 조건 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deletePay(Map<String, Object> mapParam) throws Exception {
		return super.update("ft.ftp.poOrderPayCondDAO.deletePay", mapParam);
	}

}
