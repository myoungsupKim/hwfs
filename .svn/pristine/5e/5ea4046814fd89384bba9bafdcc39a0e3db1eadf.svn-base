package com.hwfs.ei.isa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 특판상품관리하는 FsspGoods DAO
 * 
 * @ClassName FsspGoodsDAO.java
 * @Description FsspGoodsDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.17   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : 특판 김재섭
 * @since 2015.12.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ei/isa/fsspGoodsDAO")
public class FsspGoodsDAO extends DefaultDAO {
	
	/**
	 * 특판상품 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectGoods(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspGoodsDAO.selectGoods", mapParam);
	}

	/**
	 * 특판상품(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertGoods(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspGoodsDAO.insertGoods", mapParam);
	}
	
	/**
	 * 특판상품(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateGoods(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspGoodsDAO.updateGoods", mapParam);
	}
	
	/**
	 * 특판상품(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertPrice(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspGoodsDAO.insertPrice", mapParam);
	}
	
	/**
	 * 특판상품(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updatePrice(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspGoodsDAO.updatePrice", mapParam);
	}
}
