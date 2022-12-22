package com.hwfs.ei.isa.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 통합회계에서 특판상품을 주문 처리하는 FsspOrder DAO
 * 
 * @ClassName FsspOrderDAO.java
 * @Description FsspOrderDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.23   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : 정보기획팀 김재섭
 * @since 2015.11.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ei/isa/fsspOrderDAO")
public class FsspOrderDAO extends DefaultDAO {
	
	/**
	 * 특판상품 주문 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectGoodsList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspOrderDAO.selectGoodsList", mapParam);
	}

	/**
	 * 상품주문내역을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectGoodsOrderList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspOrderDAO.selectGoodsOrderList", mapParam);
	}

	/**
	 * 마감시간과 재고수량에 대하여 Validation을 수행한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public Record selectValidation(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("ei.isa.fsspOrderDAO.selectValidation", mapParam);
	}
	
	/**
	 * 주문을 등록한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int insertOrder(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspOrderDAO.insertOrder", mapParam);
	}

	/**
	 * 주문을 수정한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateOrder(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspOrderDAO.updateOrder", mapParam);
	}
	
	/**
	 * 주문/신청자 정보를 생성한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int insertOrderInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspOrderDAO.insertOrderInfo", mapParam);
	}
	
	/**
	 * 주문/신청자 정보를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateOrderInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("ei.isa.fsspOrderDAO.updateOrderInfo", mapParam);
	}
}
