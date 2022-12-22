package com.hwfs.fm.fms.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 반환발주 ReturnOrderByCust DAO
 * 
 * @ClassName ReturnOrderByCustDAO.java
 * @Description ReturnOrderByCustDAO Class
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
@Repository("/fm/fms/returnOrderByCustDAO")
public class ReturnOrderByCustDAO extends DefaultDAO {
	

	/**
	 * 반환발주 목록 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectReturnOrderByCustList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.returnOrderByCustDAO.selectReturnOrderByCustList", mapParam);
	}
	
	/**
	 * 반환발주 정상주문일자(so_pr)조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectSoPrGetNeedDate(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.returnOrderByCustDAO.selectSoPrGetNeedDate", mapParam);
	}
	
	/**
	 * 반환발주 반환가능업장 확인
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectRtnOrderYn(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.returnOrderByCustDAO.selectRtnOrderYn", mapParam);
	}

	/**
	 * 반환발주 prNum체크
	 *
	 * @param mapParam
	 * @return
	 */
	public Record selectPrNumChk(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("fm.fms.returnOrderByCustDAO.selectPrNumChk", mapParam);
	}
	
	/**
	 * 반환발주 prNum채번
	 *
	 * @param mapParam
	 * @return
	 */
	public Record selectGetPrNum(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("fm.fms.returnOrderByCustDAO.selectGetPrNum", mapParam);
	}	
	
	/**
	 * 반환발주 prId채번
	 *
	 * @param mapParam
	 * @return
	 */
	public Record selectGetPrId(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("fm.fms.returnOrderByCustDAO.selectGetPrId", mapParam);
	}	
	
	/**
	 * 반환발주를 등록
	 *
	 * @param mapParam
	 * @return
	 */
	
	public int insertReturnOrderByCustInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.returnOrderByCustDAO.insertReturnOrderByCustInfo", mapParam);
	}	
	/**
	 * 반환발주를 수정
	 *
	 * @param mapParam
	 * @return
	 */
	
	public int updateReturnOrderByCustInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.returnOrderByCustDAO.updateReturnOrderByCustInfo", mapParam);
	}	

	/**
	 * 반환발주를 삭제(수정)
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteReturnOrderByCustInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.returnOrderByCustDAO.deleteReturnOrderByCustInfo", mapParam);
	}	
	
	/**
	 * sms 정보조회
	 *
	 * @param parameter
	 * @return
	 */
	public Record selectReturnOrderByCustSmsInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("fm.fms.returnOrderByCustDAO.selectReturnOrderByCustSmsInfo", mapParam);
	}
	
	/**
	 * 문자발송후 영업사원 사번UPDATE(중복발송방지)
	 *
	 * @param mapParam
	 * @return
	 */
	
	public int updateWmsIntSabunInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.returnOrderByCustDAO.updateWmsIntSabunInfo", mapParam);
	}	
}
