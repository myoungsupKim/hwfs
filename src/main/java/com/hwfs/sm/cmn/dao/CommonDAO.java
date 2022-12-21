package com.hwfs.sm.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 공통 Common DAO
 * 
 * @ClassName CommonDAO.java
 * @Description CommonDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.12   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.03.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/cmn/commonDAO")
public class CommonDAO extends DefaultDAO {

	/**
	 * 공통코드의 정보를 조회한다.
	 * @return RecordSet
	 */
	public RecordSet selectComCode(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.commonDAO.selectComCode",mapParam);
	}
	
	/**
	 * 사업부(Combo)를 조회한다.
	 * @return RecordSet
	 */
	public RecordSet selectMuCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.commonDAO.selectMuCd",mapParam);
	}

	/**
	 * 영업유형코드(Combo)를 조회한다.
	 * @return RecordSet
	 */
	public RecordSet selectTypeCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.commonDAO.selectTypeCd",mapParam);
	}

	/**
	 * 전표유형에 해당하는 시스템코드Combo 조회
	 * @return RecordSet
	 */
	public RecordSet selectSysClassBySlipType(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.commonDAO.selectSysClassBySlipType",mapParam);
	}

	/**
	 * 사업부에 해당하는 시스템코드Combo 조회
	 * @return RecordSet
	 */
	public RecordSet selectSysClassByMuCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.commonDAO.selectSysClassByMuCd",mapParam);
	}
	
	/**
	 * 사업부에 해당하는 전표유형Combo 조회
	 * @return RecordSet
	 */
	public RecordSet selectSlipTypeByMuCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.commonDAO.selectSlipTypeByMuCd",mapParam);
	}
	
	/**
	 * 용역 시급정보(Combo)를 조회한다.
	 * @return RecordSet
	 */
	public RecordSet selectDutyAmt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.commonDAO.selectDutyAmt",mapParam);
	}

	/**
	 * 보유계좌정보를 조회한다.
	 * @return RecordSet
	 */
	public RecordSet selectAcntCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.commonDAO.selectAcntCd",mapParam);
	}
	
	/**
	 * 회사코드(BU_CD)를 조회한다.
	 * @return RecordSet
	 */
	public RecordSet selectBuCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.commonDAO.selectBuCd",mapParam);
	}
	
	/**
	 * 사업부를 조회한다.(영업회계 공통)
	 * @return RecordSet
	 */
	public RecordSet getMuCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.commonDAO.getMuCd",mapParam);
	}
	
	/**
	 * 팀을 조회한다.(영업회계 공통)
	 * @return RecordSet
	 */
	public RecordSet getTmCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.commonDAO.getTmCd",mapParam);
	}
	
	/**
	 * CC를 조회한다.(영업회계 공통)
	 * @return RecordSet
	 */
	public RecordSet getCcCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.commonDAO.getCcCd",mapParam);
	}
	
	/**
	 * 업장을 조회한다.(영업회계 공통)
	 * @return RecordSet
	 */
	public RecordSet getUpjangCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.cmn.commonDAO.getUpjangCd",mapParam);
	}
	
	/**
	 * 영업현금 잔액 체크
	 * @param mapParam
	 * @return
	 */
	public String getCashAltYn(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.cmn.commonDAO.getCashAltYn", mapParam, null);
	}
	
	/**
	 * 채권(입금) 잔액 체크
	 * @param mapParam
	 * @return
	 */
	public String getArReceiveYn(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.cmn.commonDAO.getArReceiveYn", mapParam, null);
	}
}
