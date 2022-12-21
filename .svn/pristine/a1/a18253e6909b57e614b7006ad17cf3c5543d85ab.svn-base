package com.hwfs.fm.fms.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 반환/교환/증정발주 ReturnOrderBySales DAO
 * 
 * @ClassName ReturnOrderBySalesDAO.java
 * @Description ReturnOrderBySalesDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.07.21    Jaey        최초생성
 * </pre>
 * @author Jaey
 * @since 2021.07.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/returnOrderBySalesDAO")
public class ReturnOrderBySalesDAO extends DefaultDAO {
	

	/**
	 * 반환/교환/증정발주 목록 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectReturnOrderBySalesList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.returnOrderBySalesDAO.selectReturnOrderBySalesList", mapParam);
	}
	
	/**
	 * 반환 주문유형의 주문일자 선택시 정상주문 유형여부 확인 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectRtnOrderYn(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.returnOrderBySalesDAO.selectRtnOrderYn", mapParam);
	}

	/**
	 * 반환/교환/증정발주 prNum체크
	 *
	 * @param mapParam
	 * @return
	 */
	public Record selectPrNumChk(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("fm.fms.returnOrderBySalesDAO.selectPrNumChk", mapParam);
	}
	
	/**
	 * 반환/교환/증정발주 prNum채번
	 *
	 * @param mapParam
	 * @return
	 */
	public Record selectGetPrNum(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("fm.fms.returnOrderBySalesDAO.selectGetPrNum", mapParam);
	}	
	
	/**
	 * 반환/교환/증정발주 prId채번
	 *
	 * @param mapParam
	 * @return
	 */
	public Record selectGetPrId(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("fm.fms.returnOrderBySalesDAO.selectGetPrId", mapParam);
	}	
	
	/**
	 * 반환/교환/증정발주를 등록
	 *
	 * @param mapParam
	 * @return
	 */
	
	public int insertReturnOrderBySalesInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.returnOrderBySalesDAO.insertReturnOrderBySalesInfo", mapParam);
	}	
	/**
	 * 반환/교환/증정발주를 수정
	 *
	 * @param mapParam
	 * @return
	 */
	
	public int updateReturnOrderBySalesInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.returnOrderBySalesDAO.updateReturnOrderBySalesInfo", mapParam);
	}	

	/**
	 * 반환/교환/증정발주를 삭제(수정)
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteReturnOrderBySalesInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.returnOrderBySalesDAO.deleteReturnOrderBySalesInfo", mapParam);
	}	
	
	/**
	 * 임시 테이블에 저장(FMP_PR_ID_TEMP)
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertFmpPrIdTemp(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.returnOrderBySalesDAO.insertFmpPrIdTemp", mapParam);
	}
	
	/**
	 * 임시 테이블에 삭제(FMP_PR_ID_TEMP)
	 *
	 * @param mapParam
	 * @return
	 */	
	public int deleteFmpPrIdTemp(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fms.returnOrderBySalesDAO.deleteFmpPrIdTemp", mapParam);
	}	
	/**
	 * 수발주 스케쥴에 따른 유효성 체크
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectReturnOrderBySalesCheck1(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.returnOrderBySalesDAO.selectReturnOrderBySalesCheck1", mapParam);
	}	
	
	/**
	 * 구매 자재신청 유효성 체크
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectReturnOrderBySalesCheck2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.returnOrderBySalesDAO.selectReturnOrderBySalesCheck2", mapParam);
	}	 
	
	/**
	 * sms 정보조회
	 *
	 * @param parameter
	 * @return
	 */
//	public RecordSet selectReturnOrderBySalesSmsInfo(Map<String, Object> mapParam) throws Exception {
//		return super.queryForRecordSet("fm.fms.returnOrderBySalesDAO.selectReturnOrderBySalesSmsInfo", mapParam);
//	}
	public Record selectReturnOrderBySalesSmsInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("fm.fms.returnOrderBySalesDAO.selectReturnOrderBySalesSmsInfo", mapParam);
	}	 
}
