package com.hwfs.fs.fsf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 거래명세서 관리하는 FuneralDeadDeadSheet DAO
 * 
 * @ClassName FuneralDeadDeadSheetDAO.java
 * @Description FuneralDeadDeadSheetDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.27   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsf/funeralDeadDeadSheetDAO")
public class FuneralDeadDeadSheetDAO extends DefaultDAO {
	
	/**
	 * 고인 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDeadGuestList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadDeadSheetDAO.selectDeadGuestList", mapParam);
	}
	
	//마감조회
	public RecordSet selectClose(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadDeadSheetDAO.selectClose", mapParam);
	}
	
	public RecordSet selectClose2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadDeadSheetDAO.selectClose2", mapParam);
	}
	
	
	/**
	 * 거래명세서 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectFuneralDeadDeadSheetList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadDeadSheetDAO.selectFuneralDeadDeadSheetList", mapParam);
	}
	
	/**
	 * 과세유형 combo 를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectVatClass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadDeadSheetDAO.selectVatClass", mapParam);
	}
	
	public RecordSet selectCcCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadDeadSheetDAO.selectCcCd", mapParam);
	}
	
	/**
	 * 창고 combo 를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPosClass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadDeadSheetDAO.selectPosClass", mapParam);
	}
	
	/**
	 * 결재수단을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPayWayList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadDeadSheetDAO.selectPayWayList", mapParam);
	}
	
	/**
	 * 영수증 번호 채번을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectReceiptNum(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadDeadSheetDAO.selectReceiptNum", mapParam);
	}
	
	/**
	 * 가맹점번호 combo 를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectFrncStorNum(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDeadDeadSheetDAO.selectFrncStorNum", mapParam);
	}
	

	/**
	 * 업장 발생 매출 마스터 정보(을)를 등록한다. 
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSlaIfUpjangSalsMst(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadDeadSheetDAO.insertSlaIfUpjangSalsMst", mapParam);
	}
	
	/**
	 * 업장 발생 매출 마스터 정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSlaIfUpjangSalsMst(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadDeadSheetDAO.updateSlaIfUpjangSalsMst", mapParam);
	}
	
	/**
	 * 업장 발생 매출 마스터 정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteSlaIfUpjangSalsMst(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadDeadSheetDAO.deleteSlaIfUpjangSalsMst", mapParam);
	}
	
	/**
	 * 업장 발생 매출 상세 정보(을)를 등록한다. 
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSlaIfUpjangSalsDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadDeadSheetDAO.insertSlaIfUpjangSalsDetail", mapParam);
	}
	
	/**
	 * 업장 발생 매출 상세 정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSlaIfUpjangSalsDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadDeadSheetDAO.updateSlaIfUpjangSalsDetail", mapParam);
	}
	
	/**
	 * 업장 발생 매출 상세 정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteSlaIfUpjangSalsDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadDeadSheetDAO.deleteSlaIfUpjangSalsDetail", mapParam);
	}
	
	/**
	 * 업장 발생 Payment 정보(을)를 등록한다. 
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSlaIfUpjangPayment(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadDeadSheetDAO.insertSlaIfUpjangPayment", mapParam);
	}
	
	/**
	 * 업장 발생 Payment 정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSlaIfUpjangPayment(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadDeadSheetDAO.updateSlaIfUpjangPayment", mapParam);
	}
	
	/**
	 * 업장 발생 Payment 정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteSlaIfUpjangPayment(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadDeadSheetDAO.deleteSlaIfUpjangPayment", mapParam);
	}
	
	/**
	 * 카드 승인 정보(을)를 등록한다. 
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSlaIfCardApprvInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadDeadSheetDAO.insertSlaIfCardApprvInfo", mapParam);
	}
	
	/**
	 * 카드 승인 정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSlaIfCardApprvInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadDeadSheetDAO.updateSlaIfCardApprvInfo", mapParam);
	}
	
	/**
	 * 카드 승인 정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteSlaIfCardApprvInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDeadDeadSheetDAO.deleteSlaIfCardApprvInfo", mapParam);
	}
}
