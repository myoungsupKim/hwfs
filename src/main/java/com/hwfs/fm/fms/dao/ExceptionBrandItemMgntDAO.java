package com.hwfs.fm.fms.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 발주제한상품(브랜드) 등록 ExceptionBrandItemMgnt DAO
 * 
 * @ClassName ExceptionBrandItemMgntDAO.java
 * @Description ExceptionBrandItemMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.10.24    hye.jin94        최초생성
 * </pre>
 * @author Jaey
 * @since 2021.07.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/exceptionBrandItemMgntDAO")
public class ExceptionBrandItemMgntDAO extends DefaultDAO {
	
	/**
	 *브랜드 업장 목록 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.exceptionBrandItemMgntDAO.selectUpjangList", mapParam);
	}
	
	/**
	 *발주제한상품 목록 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectItemList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.exceptionBrandItemMgntDAO.selectItemList", mapParam);
	}
	
	/**
	 * 발주제한상품 중복cnt
	 *
	 * @param mapParam
	 * @return
	 */
	public Record selectItemDupCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("fm.fms.exceptionBrandItemMgntDAO.selectItemDupCnt", mapParam);
	}	
	
	/**
	 * 발주제한상품(을)를 등록
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertItemInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionBrandItemMgntDAO.insertItemInfo", mapParam);
	}
	
	/**
	 * 발주제한상품(을)를 수정
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateItemInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionBrandItemMgntDAO.updateItemInfo", mapParam);
	}

	/**
	 * 발주제한상품 DATA를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteExceptionItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionBrandItemMgntDAO.deleteExceptionItem", mapParam);
	}	
	
	/**
	 * 발주제한상품관리엑셀 목록 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectItemListExcel(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.exceptionBrandItemMgntDAO.selectItemListExcel", mapParam);
	}
	
	
	
	
	
	/**
	 *행사그룹관리 목록 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectEventList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.exceptionBrandItemMgntDAO.selectEventList", mapParam);
	}

	/**
	 * 행사그룹관리(을)를 등록
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertEventInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionBrandItemMgntDAO.insertEventInfo", mapParam);
	}
	
	/**
	 * 행사그룹관리(을)를 수정
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateEventInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionBrandItemMgntDAO.updateEventInfo", mapParam);
	}
	
	/**
	 * 행사거래처관리 종료일 수정
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUpjangApplyEd(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionBrandItemMgntDAO.updateUpjangApplyEd", mapParam);
	}
	
		
	/**
	 * 행사거래처관리 중복cnt
	 *
	 * @param mapParam
	 * @return
	 */
	public Record selectUpjangDupCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("fm.fms.exceptionBrandItemMgntDAO.selectUpjangDupCnt", mapParam);
	}	

	/**
	 * 행사거래처관리(을)를 등록
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUpjangInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionBrandItemMgntDAO.insertUpjangInfo", mapParam);
	}
	
	/**
	 * 행사거래처관리(을)를 수정
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUpjangInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionBrandItemMgntDAO.updateUpjangInfo", mapParam);
	}
	
	/**
	 *행사거래처관리엑셀 목록 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectUpjangListExcel(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.exceptionBrandItemMgntDAO.selectUpjangListExcel", mapParam);
	}	

	
	/** 
	 * 행사이력 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectEventHistList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.exceptionBrandItemMgntDAO.selectEventHistList", mapParam);
	}
	
	/**
	 * 행사거래처 삭제 시 히스토리를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUpjangDeleteHist(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionBrandItemMgntDAO.insertUpjangDeleteHist", mapParam);
	}
	
	/**
	 * 행사거래처 DATA를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteEventUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionBrandItemMgntDAO.deleteEventUpjang", mapParam);
	}	
	
	/**
	 * 행사상품 삭제 시 히스토리를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertItemDeleteHist(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionBrandItemMgntDAO.insertItemDeleteHist", mapParam);
	}
	
	
	
	/**
	 * 행사그룹 삭제 시 사용여부 'N' 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateEventUseYn(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.exceptionBrandItemMgntDAO.updateEventUseYn", mapParam);
	}
	
}
