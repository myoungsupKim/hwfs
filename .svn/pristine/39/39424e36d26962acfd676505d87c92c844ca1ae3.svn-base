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
@Repository("/sc/scz/upjangMgmtDAO")
public class UpjangMgmtDAO extends DefaultDAO {

	/**
	 * 업장 마스터 정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.upjangMgmtDAO.selectList", mapParam);
	}
	
	public Record selectExistsVirtureBankAcctNo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("sc.scz.upjangMgmtDAO.selectExistsVirtureBankAcctNo", mapParam);
	}

	public RecordSet selectSaveUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.upjangMgmtDAO.selectSaveUpjangList", mapParam);
	}
	
	
	/**
	 * 업장 마스터 정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtDAO.insert", mapParam);
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
		return super.update("sc.scz.upjangMgmtDAO.insertScoUpjangMst", mapParam);
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
		return super.update("sc.scz.upjangMgmtDAO.updateScoUpjangMst", mapParam);
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
		return super.update("sc.scz.upjangMgmtDAO.insertFmsUpjang", mapParam);
	}
	
	public int insertSccAddrInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtDAO.insertSccAddrInfo", mapParam);
	}

	/**
	 * 업장 마스터 정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtDAO.update", mapParam);
	}

	/**
	 * 업장 마스터 정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangMgmtDAO.delete", mapParam);
	}
	
	public RecordSet selectIncludeCS(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.upjangMgmtDAO.selectIncludeCS", mapParam);
	}

}
