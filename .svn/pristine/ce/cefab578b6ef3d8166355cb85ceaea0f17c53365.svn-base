package com.hwfs.sm.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 선수금정보 공통 AdvanceCommon DAO
 * 
 * @ClassName AdvanceCommonDAO.java
 * @Description AdvanceCommonDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.04.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/cmn/advanceCommonDAO")
public class AdvanceCommonDAO extends DefaultDAO {
	
	/**
	 * 선수금정보 조회
	 * @return RecordSet
	 */
	public RecordSet selectAdvanceMst(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.advanceCommonDAO.selectAdvanceMst", mapParam);
	}

	/**
	 * 선수금 환불 대상 정보 조회
	 * @return RecordSet
	 */
	public RecordSet selectAdvanceRefundMst(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.advanceCommonDAO.selectAdvanceRefundMst", mapParam);
	}

	/**
	 * 선수금 대체 정보 조회(조회조건)
	 * @return RecordSet
	 */
	public RecordSet selectAdvanceAltMst(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.advanceCommonDAO.selectAdvanceAltMst", mapParam);
	}
	
	/**
	 * 선수금 입금 수단 조회
	 * @return RecordSet
	 */
	public RecordSet selectAdvanceReceiveWay(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.advanceCommonDAO.selectAdvanceReceiveWay", mapParam);
	}
	
	/**
	 * 선수금번호 채번
	 * @param mapParam
	 * @return
	 */
	public String getMaxAdvanceNum(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.cmn.advanceCommonDAO.getMaxAdvanceNum", mapParam, null);
	}
	
	/**
	 * 선수금 대체번호 채번
	 * @param mapParam
	 * @return
	 */
	public String getMaxAtlNum(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.cmn.advanceCommonDAO.getMaxAtlNum", mapParam, null);
	}

///////////////////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * 선수금 대체 마스터 정보를 등록한다.
	 * @param mapParam
	 * @return
	 */
	public int insertAdvanceAltMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.insertAdvanceAltMst", mapParam);
	}
	
	//이관전 등록
	public int insertAdvanceAltMst2(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.insertAdvanceAltMst2", mapParam);
	}
	
	/**
	 * 선수금 대체 마스터 정보를 수정한다.
	 * @param mapParam
	 * @return
	 */
	public int updateAdvanceAltMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.updateAdvanceAltMst", mapParam);
	}
	
	/**
	 * 선수금 대체 디테일 정보를 등록한다.
	 * @param mapParam
	 * @return
	 */
	public int insertAdvanceAltDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.insertAdvanceAltDtl", mapParam);
	}
	
	//이관전 등록
	public int insertAdvanceAltDtl2(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.insertAdvanceAltDtl2", mapParam);
	}

	/**
	 * 선수금 대체 디테일 정보를 수정한다.
	 * @param mapParam
	 * @return
	 */
	public int updateAdvanceAltDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.updateAdvanceAltDtl", mapParam);
	}

	/**
	 * 단건 대체취소 (ApplyAmt = 0) - 선수금 대체디테일정보 삭제
	 * 
	 * @param mapParam
	 * @return
	 */
	public int deleteAdvanceAltDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.deleteAdvanceAltDtl", mapParam);
	}
	
	/**
	 * 선수금 대체시 선수금 마스터정보의 적용금액을 변경한다.
	 * @param mapParam
	 * @return
	 */
	public int updateAdvanceApplyAmtProc(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.updateAdvanceApplyAmtProc", mapParam);
	}

///////////////////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * 선수금 대체취소시 마스터정보 잔액 초기화.
	 * @param mapParam
	 * @return
	 */
	public int updateAdvanceApplyAmtCancel(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.updateAdvanceApplyAmtCancel", mapParam);
	}

	/**
	 * 선수금 대체취소시 선수금 대체 마스터 정보를 삭제한다.
	 * @param mapParam
	 * @return
	 */
	public int cancelAdvanceAltMaster(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.cancelAdvanceAltMaster", mapParam);
	}	
	
	/**
	 * 선수금 대체취소시 선수금 대체 디테일 정보를 삭제한다.
	 * @param mapParam
	 * @return
	 */
	public int cancelAdvanceAltDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.cancelAdvanceAltDetail", mapParam);
	}

///////////////////////////////////////////////////////////////////////////////////////////////
	/**
	 * 신규 선수금마스터 저장(발생)
	 * @param mapParam
	 * @return
	 */
	public int insertAdvanceMaster(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.insertAdvanceMaster", mapParam);
	}
	
	//이관전 등록
	public int insertAdvanceMaster2(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.insertAdvanceMaster2", mapParam);
	}
	
	/**
	 * 지불 수단 저장(발생)
	 * @param mapParam
	 * @return
	 */
	public int insertAdvanceReceiveWay(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.insertAdvanceReceiveWay", mapParam);
	}

	//이관전 등록
	public int insertAdvanceReceiveWay2(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.insertAdvanceReceiveWay2", mapParam);
	}
	
	/**
	 * 선수금 입금수단 발생
	 * @param mapParam
	 * @return
	 */
	public int insertOriAdvanceReceiveWay(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.insertOriAdvanceReceiveWay", mapParam);
	}
	
	/**
	 * 신규 선수금번호 저장(거래처/업장 이관시 사용)
	 * @param mapParam
	 * @return
	 */
	public int insertAdvanceMasterTrans(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.insertAdvanceMasterTrans", mapParam);
	}
	
	public int insertAdvanceMasterTrans2(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.insertAdvanceMasterTrans2", mapParam);
	}

	/**
	 * 수정 선수금번호 저장(거래처/업장 이관시 사용)
	 * @param mapParam
	 * @return
	 */
	public int updateAdvanceMasterTrans(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.updateAdvanceMasterTrans", mapParam);
	}
	
	/**
	 * 선수금 마스터정보 수정(쿠폰판매)
	 * @param mapParam
	 * @return
	 */
	public int updateAdvanceMasterCoupon(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.updateAdvanceMasterCoupon", mapParam);
	}
	
	/**
	 * 선수금 이관취소시 선수금 마스터 정보를 삭제한다.(거래처/업장 이관시 사용)
	 * @param mapParam
	 * @return
	 */
	public int cancelAdvanceMaster(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.cancelAdvanceMaster", mapParam);
	}
	
	/**
	 * 선수금 취소시 선수금 마스터 정보를 삭제한다.
	 * @param mapParam
	 * @return
	 */
	public int mstAdvanceCancel(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.mstAdvanceCancel", mapParam);
	}

	/**
	 * 단건 대체취소 - 선수금 마스터정보 적용금액 (-) => 사용안함
	 * 
	 * @param mapParam
	 * @return
	 */
	public int updateAdvanceApplyAmt(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.updateAdvanceApplyAmt", mapParam);
	}
	
	/**
	 * 단건 대체취소 (ApplyAmt = 0) - 선수금 대체마스터정보 적용금액 (-) => 사용안함
	 * 
	 * @param mapParam
	 * @return
	 */
	public int updateAdvanceAltApplyAmtCancel(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.updateAdvanceAltApplyAmtCancel", mapParam);
	}
	
	/**
	 * 선수금 취소시 선수금 입금수단 정보를 삭제한다.
	 * @param mapParam
	 * @return
	 */
	public int advanceReceiveWayCancel(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.advanceReceiveWayCancel", mapParam);
	}

	/**
	 * 재이관 여부 체크
	 * @return RecordSet
	 */
	public RecordSet chkAdvanceTransInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.advanceCommonDAO.chkAdvanceTransInfo", mapParam);
	}

	/**
	 * 이관취소 가능여부
	 * @return RecordSet
	 */
	public RecordSet chkAdvanceTransCancel(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.advanceCommonDAO.chkAdvanceTransCancel", mapParam);
	}
	
	/**
	 * 계정코드 등록
	 * 
	 * @param mapParam
	 * @return
	 */
	public int setAcctCd(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.setAcctCd", mapParam);
	}
	
	/**
	 * 선수금잔액 조회
	 * @return RecordSet
	 */
	public RecordSet selectTotalAdvanceAmt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.advanceCommonDAO.selectTotalAdvanceAmt", mapParam);
	}
	
	/**
	 * MAS_TICKET_MST(식권환불/이관) 등록
	 * 
	 * @param mapParam
	 * @return
	 */
	public int insertMasTicketMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.insertMasTicketMst", mapParam);
	}
	
	/**
	 * MAS_TICKET_MST(식권환불/이관) 삭제
	 * 
	 * @param mapParam
	 * @return
	 */
	public int deleteMasTicketMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.cmn.advanceCommonDAO.deleteMasTicketMst", mapParam);
	}
	
	/**
	 * 선수금잔액 체크
	 * @param mapParam
	 * @return
	 */
	public String getAdvanceAltYn(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.cmn.advanceCommonDAO.getAdvanceAltYn", mapParam, null);
	}
}
