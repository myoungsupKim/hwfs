package com.hwfs.fs.fsf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 고인별 판매품목 출고/반품관리하는 FuneralDeadSaleGoodsOutReturn DAO
 * 
 * @ClassName FuneralDeadSaleGoodsOutReturnDAO.java
 * @Description FuneralDeadSaleGoodsOutReturnDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.20   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsf/funeralDeadSaleGoodsOutReturnDAO")
public class FuneralDeadSaleGoodsOutReturnDAO extends DefaultDAO {
	
//	/**
//	 * 상품분류 목록을 조회한다.
//	 *
//	 * @param mapParam
//	 * @return
//	 */
//	public RecordSet selectGoodsType() throws Exception {
//		Map<String, Object> mapParam = new HashMap<String, Object>();
//		return super.queryForRecordSet("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.selectGoodsType", mapParam);
//	}
//	
//	/**
//	 * 상세상품 목록을 조회한다.
//	 *
//	 * @param mapParam
//	 * @return
//	 */
//	public RecordSet selectDetailGoods() throws Exception {
//		Map<String, Object> mapParam = new HashMap<String, Object>();
//		return super.queryForRecordSet("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.selectDetailGoods", mapParam);
//	}
	
	/**
	 * 상품구분 코드 조회.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSetCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.selectSetCd", mapParam);
	}
	
	/**
	 * 상품분류, 상세상품 코드리스트를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCodeList1(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.selectCodeList1", mapParam);
	}
	public RecordSet selectCodeList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.selectCodeList2", mapParam);
	}
	public RecordSet selectCodeList3(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.selectCodeList3", mapParam);
	}
	
	/**
	 * 마감여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCloseYn(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.selectCloseYn", mapParam);
	}
	
	/**
	 * 고인 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDeadGuestList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.selectDeadGuestList", mapParam);
	}
	
	/**
	 * 고인별 판매품목 판매/반품 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectGoodsSaleoutReturn(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.selectGoodsSaleoutReturn", mapParam);
	}
	
	/**
	 * 결제수단 등록 여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPayWayYn(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.selectPayWayYn", mapParam);
	}
	
	/**
	 * 고인별 총액산출내역을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAdjustAmt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.selectAdjustAmt", mapParam);
	}
	
	/**
	 * 반품건 적합성여부 내역을 조회한다.(반품은 판매에 한해서 가능하며, 마이너스 반품은 불가)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSaleReturnCheck(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.selectSaleReturnCheck", mapParam);
	}

	/**
	 * 고인별 판매품목 출고/반품관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertGoodsSale(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.insertGoodsSale", mapParam);
	}
	
	/**
	 * 고인별 판매품목 출고/반품관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateGoodsSale(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.updateGoodsSale", mapParam);
	}
	
	/**
	 * 고인별 판매품목 출고/반품관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteGoodsSale(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadSaleGoodsOutReturnDAO.deleteGoodsSale", mapParam);
	}
	
}
