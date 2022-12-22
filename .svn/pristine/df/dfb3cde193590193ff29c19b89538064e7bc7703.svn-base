package com.hwfs.fm.fmc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 클레임요청하는 ClaimReg DAO
 * 
 * @ClassName ClaimRegDAO.java
 * @Description ClaimRegDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06    최영준        최초생성
 *  2015.07.13	  손형민		인수인계
 *  2021.08.09    DEV02         [PJT]주문채널통합
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmc/claimRegDAO")
public class ClaimRegDAO extends DefaultDAO {
	
	/**
	 * 업장별 창고리스트 목록을 조회한다.
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubinv(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimRegDAO.selectSubinv", mapParam);
	}
	

	
	/**
	 * 클레임요청 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimRegDAO.selectList", mapParam);
	}
	
	/**
	 * 클레임요청 목록을 조회한다.
	 * [PJT]주문채널통합
	 * 
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBrandList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimRegDAO.selectBrandList", mapParam);
	}
	
	/**
	 * 공통코드 목록을 조회한다.
	 *
	 * @return
	 */
	public RecordSet commonList(Map <String, Object> parm) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimRegDAO.commonList", parm);
	}
	
	
	/**
	 * 클레임요청(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimRegDAO.insert", mapParam);
	}
	
	/**
	 * 클레임요청(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimRegDAO.update", mapParam);
	}
	
	/**
	 * 클레임요청(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimRegDAO.delete", mapParam);
	}
	
	/**
	 * PC사진 목록(을)를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPC(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimRegDAO.selectPC", mapParam);
	}
	
	/**
	 * PC사진 목록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertPC(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimRegDAO.insertPC", mapParam);
	}
	
	/**
	 * PC사진 목록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updatePC(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimRegDAO.updatePC", mapParam);
	}
	
	/**
	 * PC사진 목록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deletePC(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimRegDAO.deletePC", mapParam);
	}
	
	/**
	 * Mobile사진 목록(을)를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMobile(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimRegDAO.selectMobile", mapParam);
	}
	
	/**
	 * 자재별 재고량 확인.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet itemQty(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimRegDAO.itemQty", mapParam);
	}
	
	/**
	 * 클레임 상태값 재조회.
	 *
	 * @param mapParam
	 * @return
	 */
	public String claimStatus(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fm.fmc.claimRegDAO.claimStatus", mapParam , null);
	}
	
	/**
	 * 클레임 식권클레임 가능 여부 확인.
	 *
	 * @param mapParam
	 * @return
	 */
	public String ticketFlag(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fm.fmc.claimRegDAO.ticketFlag", mapParam , null);
	}
	
	
	
	/**
	 * 요청 취소 클레임 저장.
	 *
	 * @param mapParam
	 * @return
	 */
	public int claimHistorySave(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimRegDAO.claimHistorySave", mapParam);
	}
	
	/**
	 * 클레임 중복 등록 여부를 확인 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int claiminsertYn(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fm.fmc.claimRegDAO.claiminsertYn", mapParam);
	}
	
}
