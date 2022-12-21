package com.hwfs.fs.fsf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 판매상품군 정보관리하는 FuneralSaleGoodsInfoMgnt DAO
 * 
 * @ClassName FuneralSaleGoodsInfoMgntDAO.java
 * @Description FuneralSaleGoodsInfoMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsf/funeralSaleGoodsInfoMgntDAO")
public class FuneralSaleGoodsInfoMgntDAO extends DefaultDAO {
	
	/**
	 * 세트등록(TAB2) 세트명 Combo을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSetCdCombo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleGoodsInfoMgntDAO.selectSetCdCombo", mapParam);
	}
	
	/**
	 * 판매상품등록(TAB1)_매점상품 팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectStoreClassPopupList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleGoodsInfoMgntDAO.selectStoreClassPopupList", mapParam);
	}
	
	/**
	 * 판매상품등록(TAB1),세트등록(TAB2) 식사류,매점상품,기타상품 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSaleRegClassList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleGoodsInfoMgntDAO.selectSaleRegClassList", mapParam);
	}
	
	/**
	 * 장례식장별 상품군코드 전체 maxcd 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectGoodsInputMax(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleGoodsInfoMgntDAO.selectGoodsInputMax", mapParam);
	}
	
	/**
	 * 장례식장별 MAX 세트코드 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMclassMax(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleGoodsInfoMgntDAO.selectMclassMax", mapParam);
	}
	
	/**
	 * 장례식장별 세트명(MCLASS) 중복 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMclassDupFlag(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleGoodsInfoMgntDAO.selectMclassDupFlag", mapParam);
	}
	
	/**
	 * 장례식장별 세트별 상세 maxcd 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSclassDtlMax(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleGoodsInfoMgntDAO.selectSclassDtlMax", mapParam);
	}
	
	/**
	 * 장례식장별 생성대상 상세코드(SCLASS) 중복 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSclassDupFlag(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleGoodsInfoMgntDAO.selectSclassDupFlag", mapParam);
	}
		
	/**
	 * 세트등록(TAB2) 세트명 입력 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMclassList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleGoodsInfoMgntDAO.selectMclassList", mapParam);
	}
		
	/**
	 * 세트등록(TAB2) 세트등록 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSclassList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleGoodsInfoMgntDAO.selectSclassList", mapParam);
	}
	
	/**
	 * 판매상품목록(TAB3) 현황 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSaleGoodsTotalList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleGoodsInfoMgntDAO.selectSaleGoodsTotalList", mapParam);
	}
	
	/**
	 * 판매상품등록(TAB1)_상품 삭제가능 여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectGoodsDeleteYn(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleGoodsInfoMgntDAO.selectGoodsDeleteYn", mapParam);
	}
	public RecordSet selectSetDeleteYn(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralSaleGoodsInfoMgntDAO.selectSetDeleteYn", mapParam);
	}
			
	/**
	 * 판매상품등록(TAB1)_식사류,매점상품,기타상품 목록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSaleRegClassList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralSaleGoodsInfoMgntDAO.insertSaleRegClassList", mapParam);
	}
	
	/**
	 * 판매상품등록(TAB1)_식사류,매점상품,기타상품 목록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSaleRegClassList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralSaleGoodsInfoMgntDAO.updateSaleRegClassList", mapParam);
	}
	
	/**
	 * 판매상품등록(TAB1)_식사류,매점상품,기타상품 목록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteSaleRegClassList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralSaleGoodsInfoMgntDAO.deleteSaleRegClassList", mapParam);
	}
	
	/**
	 * 세트등록(TAB2)_세트명등록 목록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertMclassGoodsList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralSaleGoodsInfoMgntDAO.insertMclassGoodsList", mapParam);
	}
	
	/**
	 * 세트등록(TAB2)_세트명등록 목록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateMclassGoodsList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralSaleGoodsInfoMgntDAO.updateMclassGoodsList", mapParam);
	}
	
	/**
	 * 세트등록(TAB2)_세트명등록 목록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteMclassGoodsList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralSaleGoodsInfoMgntDAO.deleteMclassGoodsList", mapParam);
	}
	
	/**
	 * 세트등록(TAB2) 세트등록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSclassGoodsList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralSaleGoodsInfoMgntDAO.insertSclassGoodsList", mapParam);
	}
	
	/**
	 * 세트등록(TAB2) 세트등록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSclassGoodsList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralSaleGoodsInfoMgntDAO.updateSclassGoodsList", mapParam);
	}
	
	/**
	 * 세트등록(TAB2) 세트등록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteSclassGoodsList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralSaleGoodsInfoMgntDAO.deleteSclassGoodsList", mapParam);
	}
}
