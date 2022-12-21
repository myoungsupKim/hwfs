package com.hwfs.sc.scz.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장의 마스터 정보를 관리하는 UpjangMgmt DAO
 *
 * @ClassName UpjangMgmtDAO.java
 * @Description UpjangMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.07   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.07
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scz/upjangMgmtNewDAO")
public class UpjangMgmtNewDAO extends DefaultDAO {

	/**
	 * 업장 마스터 정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.upjangMgmtNewDAO.selectList", mapParam);
	}
	
	public Record selectExistsVirtureBankAcctNo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("sc.scz.upjangMgmtNewDAO.selectExistsVirtureBankAcctNo", mapParam);
	}

	public RecordSet selectSaveUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.upjangMgmtNewDAO.selectSaveUpjangList", mapParam);
	}
	
	/**
	 * 입력한 업장명과 비슷한 업장을 검색한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectLikeUpjangNm(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.upjangMgmtNewDAO.selectLikeUpjangNm", mapParam);
	}
	
	/**
	 * 업장 마스터 정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtNewDAO.insert", mapParam);
	}

	/**
	 * SCO_UPJANG_MST를 생성한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int insertScoUpjangMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtNewDAO.insertScoUpjangMst", mapParam);
	}


	/**
	 * SCO_UPJANG_MST를 수정한다.
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateScoUpjangMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtNewDAO.updateScoUpjangMst", mapParam);
	}


	/**
	 * FMS_UPJANG을 생성한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int insertFmsUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtNewDAO.insertFmsUpjang", mapParam);
	}
	
	public int insertSccAddrInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtNewDAO.insertSccAddrInfo", mapParam);
	}

	/**
	 * 업장 마스터 정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtNewDAO.update", mapParam);
	}

	/**
	 * 업장 마스터 정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtNewDAO.delete", mapParam);
	}

	/**
	 * 업장의 변경 이력을 기록한다.
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int insertUpjangChngLog(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtNewDAO.insertUpjangChngLog", mapParam);
	}
	
	public RecordSet selectRequestBankAcctNo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.upjangMgmtNewDAO.selectRequestBankAcctNo", mapParam);
	}
	
	public Record selectTitle(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("sc.scz.upjangMgmtNewDAO.selectTitle", mapParam);
	}
	
	public Record selectSendUser(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("sc.scz.upjangMgmtNewDAO.selectSendUser", mapParam);
	}
	
	public int updateGwId(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtNewDAO.updateGwId", mapParam);
	}
	
	public RecordSet selectSapRequestList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.upjangMgmtNewDAO.selectSapRequestList", mapParam);
	}
	
	public int updateSapRequest(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtNewDAO.updateSapRequest", mapParam);
	}
	
	public RecordSet selectIncludeCS(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.upjangMgmtNewDAO.selectIncludeCS", mapParam);
	}
	
	public RecordSet selectMailContent(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.upjangMgmtNewDAO.selectMailContent", mapParam);
	}
	
	public int updataMailStatus(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtNewDAO.updataMailStatus", mapParam);
	}
	
	public int updataUserCancel(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtNewDAO.updataUserCancel", mapParam);
	}	
}
