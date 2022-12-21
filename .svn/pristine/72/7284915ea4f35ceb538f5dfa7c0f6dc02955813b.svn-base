package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import java.math.BigDecimal;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 입금처리하는 ReceiveMgntPop DAO
 * 
 * @ClassName ReceiveMgntPopDAO.java
 * @Description ReceiveMgntPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/receiveMgntPopDAO")
public class ReceiveMgntPopDAO extends DefaultDAO {
	
	/**
	 * 입금처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveMgntPopDAO.selectList", mapParam);
	}

	/**
	 * 입금처리 번호를 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String selectMaxReceiveNum(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.sar.receiveMgntPopDAO.selectMaxReceiveNum", mapParam, null);
	}
	
	/**
	 * 채권대체번호를 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public BigDecimal selectMaxArAltNum(Map<String, Object> mapParam) throws Exception {
		return (BigDecimal) super.queryForObject("sm.sar.receiveMgntPopDAO.selectMaxArAltNum", mapParam, null);
	}
	
	/**
	 * 입금처리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.insertMst", mapParam);
	}
	
	/**
	 * 입금처리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.updateMst", mapParam);
	}
	
	/**
	 * 입금처리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancleMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.cancleMst", mapParam);
	}
	
	/**
	 * 입금처리(을)를 대체번호 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateMstAtlNum(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.updateMstAtlNum", mapParam);
	}

	/**
	 *입금처리 상세 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDetail(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveMgntPopDAO.selectDetail", mapParam);
	}
	
	/**
	 * 입금수단을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectReceiveWayList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveMgntPopDAO.selectReceiveWayList", mapParam);
	}


	/**
	 * 입금처리 상세(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.insertDetail", mapParam);
	}
	
	/**
	 * 입금처리 상세(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.updateDetail", mapParam);
	}
	
	/**
	 * 입금상세처리(을)를 취소 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancleDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.cancleDetail", mapParam);
	}

	/**
	 * 입금상세처리(을)를 삭제 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.deleteDetail", mapParam);
	}

	/**
	 * 입금처리 수단(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertReceiveWay(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.insertReceiveWay", mapParam);
	}
	
	/**
	 * 입금처리 수단(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReceiveWay(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.updateReceiveWay", mapParam);
	}
	
	/**
	 * 입금처리 수단 대체번호(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReceiveWayAtlNum(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.updateReceiveWayAtlNum", mapParam);
	}

	/**
	 *  입금처리 수단(을)를 취소 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancleReceiveWay(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.cancleReceiveWay", mapParam);
	}
	
	/**
	 * 공제사항(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertDeduc(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.insertDeduc", mapParam);
	}
	
	/**
	 * 공제사항 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDeduc(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveMgntPopDAO.selectDeduc", mapParam);
	}

	/**
	 * 공제사항(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateDeduc(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.updateDeduc", mapParam);
	}

	/**
	 * 공제사항(을)를 삭제 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteDeduc(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.deleteDeduc", mapParam);
	}

	/**
	 *  공제사항(을)를 취소 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancleDeduc(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.cancleDeduc", mapParam);
	}
	
	/**
	 *  입금수단(을)를 삭제 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteReceiveWay(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntPopDAO.deleteReceiveWay", mapParam);
	}
	
	/**
	 * 입금처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCharge(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveMgntPopDAO.selectCharge", mapParam);
	}
}
