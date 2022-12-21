package com.hwfs.fs.fsf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 고인별 판매품목 출고/반품관리하는 FuneralSingleGoodsOutReturn DAO
 * 
 * @ClassName FuneralSingleGoodsOutReturnDAO.java
 * @Description FuneralSingleGoodsOutReturnDAO Class
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
@Repository("/fs/fsf/funeralSingleGoodsOutReturnDAO")
public class FuneralSingleGoodsOutReturnDAO extends DefaultDAO {
	
	/**
	 * 상품구분 코드 조회.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSetCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSingleGoodsOutReturnDAO.selectSetCd", mapParam);
	}
	
	/**
	 * 상품분류, 상세상품 코드리스트를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCodeList1(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSingleGoodsOutReturnDAO.selectCodeList1", mapParam);
	}
	public RecordSet selectCodeList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSingleGoodsOutReturnDAO.selectCodeList2", mapParam);
	}
	public RecordSet selectCodeList3(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSingleGoodsOutReturnDAO.selectCodeList3", mapParam);
	}
	
	/**
	 * 반품대상 상품의 총 판매수량을 조회한다.(입력시, 반품 수량 실시간 체크)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet searchSaleCount(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSingleGoodsOutReturnDAO.searchSaleCount", mapParam);
	}
	
	/**
	 * 고인 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDeadGuestList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSingleGoodsOutReturnDAO.selectDeadGuestList", mapParam);
	}
	
	/**
	 * 고인별 판매품목 판매/반품 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectGoodsSaleoutReturn(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSingleGoodsOutReturnDAO.selectGoodsSaleoutReturn", mapParam);
	}
	
	/**
	 * 고인별 총액산출내역을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAdjustAmt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSingleGoodsOutReturnDAO.selectAdjustAmt", mapParam);
	}
	
	/**
	 * 반품건 적합성여부 내역을 조회한다.(반품은 판매에 한해서 가능하며, 마이너스 반품은 불가)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSaleReturnCheck(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSingleGoodsOutReturnDAO.selectSaleReturnCheck", mapParam);
	}

	/**
	 * 고인별 판매품목 출고/반품관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertGoodsSale(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralSingleGoodsOutReturnDAO.insertGoodsSale", mapParam);
	}
	
	/**
	 * 고인별 판매품목 출고/반품관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateGoodsSale(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralSingleGoodsOutReturnDAO.updateGoodsSale", mapParam);
	}
	
	/**
	 * 고인별 판매품목 출고/반품관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteGoodsSale(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralSingleGoodsOutReturnDAO.deleteGoodsSale", mapParam);
	}
	
}
