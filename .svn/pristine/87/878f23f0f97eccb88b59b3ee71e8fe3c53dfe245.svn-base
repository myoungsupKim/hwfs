package com.hwfs.sm.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 가수금정보 공통 SuspenseCommon DAO
 * 
 * @ClassName SuspenseCommonDAO.java
 * @Description SuspenseCommonDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/cmn/suspenseCommonDAO")
public class SuspenseCommonDAO extends DefaultDAO {
	
	/**
	 * 가수금정보 조회
	 * @return RecordSet
	 */
	public RecordSet selectSuspenseList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.suspenseCommonDAO.selectSuspenseList", mapParam);
	}
	
	/**
	 * 가수금정보 내역조회
	 * @return RecordSet
	 */
	public RecordSet selectSuspenseHistory(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.suspenseCommonDAO.selectSuspenseHistory", mapParam);
	}

	/**
	 * 가수금 대체 정보 조회
	 * @return RecordSet
	 */
	public RecordSet selectSuspenseAltMst(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.suspenseCommonDAO.selectSuspenseAltMst", mapParam);
	}
	
	/**
	 * 가수금번호 채번
	 * @param mapParam
	 * @return
	 */
	public String getMaxSuspenseNum(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.cmn.suspenseCommonDAO.getMaxSuspenseNum", mapParam, null);
	}
	
	/**
	 * 가수금 대체번호 채번
	 * @param mapParam
	 * @return
	 */
	public String getMaxAtlNum(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.cmn.suspenseCommonDAO.getMaxAtlNum", mapParam, null);
	}

///////////////////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * 가수금 대체 마스터 정보를 등록한다.
	 * @param mapParam
	 * @return
	 */
	public int insertSuspenseAltMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.suspenseCommonDAO.insertSuspenseAltMst", mapParam);
	}
	
	/**
	 * 가수금 대체 마스터 정보를 수정한다.
	 * @param mapParam
	 * @return
	 */
	public int updateSuspenseAltMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.suspenseCommonDAO.updateSuspenseAltMst", mapParam);
	}
	
	/**
	 * 가수금 대체 디테일 정보를 등록한다.
	 * @param mapParam
	 * @return
	 */
	public int insertSuspenseAltDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.suspenseCommonDAO.insertSuspenseAltDtl", mapParam);
	}

	/**
	 * SAP IFC 가수금 입금 반제
	 * @param mapParam
	 * @return
	 */
	public int insertSapIfcSuspenseReceive(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.suspenseCommonDAO.insertSapIfcSuspenseReceive", mapParam);
	}

	/**
	 * SAP IFC 가수금 입금 반제
	 * @param mapParam
	 * @return
	 */
	public int deleteSapIfcSuspenseReceive(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.suspenseCommonDAO.deleteSapIfcSuspenseReceive", mapParam);
	}
	
	/**
	 * 가수금 대체 디테일 정보를 수정한다.
	 * @param mapParam
	 * @return
	 */
	public int updateSuspenseAltDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.suspenseCommonDAO.updateSuspenseAltDtl", mapParam);
	}

	/**
	 * 단건 대체취소 (ApplyAmt = 0) - 가수금 대체디테일정보 삭제
	 * 
	 * @param mapParam
	 * @return
	 */
	public int deleteSuspenseAltDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.suspenseCommonDAO.deleteSuspenseAltDtl", mapParam);
	}
	
	/**
	 * 가수금 대체시 가수금 마스터정보의 적용금액을 변경한다.
	 * @param mapParam
	 * @return
	 */
	public int updateSuspenseApplyAmtProc(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.suspenseCommonDAO.updateSuspenseApplyAmtProc", mapParam);
	}

///////////////////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * 가수금 대체취소시 마스터정보 잔액 초기화.
	 * @param mapParam
	 * @return
	 */
	public int updateSuspenseApplyAmtCancel(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.suspenseCommonDAO.updateSuspenseApplyAmtCancel", mapParam);
	}

	/**
	 * 가수금 대체취소시 가수금 대체 마스터 정보를 삭제한다.
	 * @param mapParam
	 * @return
	 */
	public int cancelSuspenseAltMaster(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.suspenseCommonDAO.cancelSuspenseAltMaster", mapParam);
	}	
	
	/**
	 * 가수금 대체취소시 가수금 대체 디테일 정보를 삭제한다.
	 * @param mapParam
	 * @return
	 */
	public int cancelSuspenseAltDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.suspenseCommonDAO.cancelSuspenseAltDetail", mapParam);
	}

///////////////////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * 단건 대체취소 - 가수금 마스터정보 적용금액 (-) => 사용안함
	 * 
	 * @param mapParam
	 * @return
	 */
	public int updateSuspenseApplyAmt(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.suspenseCommonDAO.updateSuspenseApplyAmt", mapParam);
	}
	
	/**
	 * 단건 대체취소 (ApplyAmt = 0) - 가수금 대체마스터정보 적용금액 (-) => 사용안함
	 * 
	 * @param mapParam
	 * @return
	 */
	public int updateSuspenseAltApplyAmtCancel(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.suspenseCommonDAO.updateSuspenseAltApplyAmtCancel", mapParam);
	}

	/**
	 * 가수금잔액 조회
	 * @return RecordSet
	 */
	public RecordSet selectTotalSuspenseAmt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.suspenseCommonDAO.selectTotalSuspenseAmt", mapParam);
	}
	
	/**
	 * 가수금잔액 체크
	 * @param mapParam
	 * @return
	 */
	public String getSuspenseAltYn(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.cmn.suspenseCommonDAO.getSuspenseAltYn", mapParam, null);
	}
	/**
	 * 가수금잔액 체크
	 * @param mapParam
	 * @return
	 */
	public String selectSabun(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.cmn.suspenseCommonDAO.selectSabun", mapParam, null);
	}

	/**
	 * 가수금 대체 순번체크
	 * @param mapParam
	 * @return
	 */
	public int selectAltSeq(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("sm.cmn.suspenseCommonDAO.selectAltSeq", mapParam);
	}
	
	/**
	 * 외식사업부 구CC 조회
	 * @return RecordSet
	 */
	public String selectCc(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.cmn.suspenseCommonDAO.selectCc", mapParam, null);
	}

}
