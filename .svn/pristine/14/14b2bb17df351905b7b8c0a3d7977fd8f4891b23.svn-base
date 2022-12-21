package com.hwfs.sm.ssi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 영업 지불유형을 관리하는 SalePaymentTypeMgnt DAO
 * 
 * @ClassName SalePaymentTypeMgntDAO.java
 * @Description SalePaymentTypeMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.17   	유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.03.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/ssi/salePaymentTypeMgntDAO")
public class SalePaymentTypeMgntDAO extends DefaultDAO {
	
	/**
	 * 영업 지불유형 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.ssi.salePaymentTypeMgntDAO.selectList", mapParam);
	}
	
	/**
	 * 영업 지불유형 중복체크를 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectExists(Map<String, Object> mapParam) throws Exception{
		return super.queryForInt("sm.ssi.salePaymentTypeMgntDAO.selectExists", mapParam);
	}

	/**
	 * 영업 지불유형(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.salePaymentTypeMgntDAO.insert", mapParam);
	}
	
	/**
	 * 영업 지불유형(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.salePaymentTypeMgntDAO.update", mapParam);
	}
	
	/**
	 * 영업 지불유형(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.salePaymentTypeMgntDAO.delete", mapParam);
	}
	
}
