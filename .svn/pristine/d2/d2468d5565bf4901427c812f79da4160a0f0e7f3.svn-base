package com.hwfs.sc.scz.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장을 일괄등록하는 UpjangBatchReg DAO
 *
 * @ClassName UpjangBatchRegDAO.java
 * @Description UpjangBatchRegDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.15   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.07.15
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scz/upjangBatchRegDAO")
public class UpjangBatchRegDAO extends DefaultDAO {

	/**
	 * 업장 일괄등록 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCustDataValidation(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.upjangBatchRegDAO.selectCustDataValidation", mapParam);
	}

	public RecordSet selectUpjangDataValidation(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.upjangBatchRegDAO.selectUpjangDataValidation", mapParam);
	}

	/**
	 * 업장 일괄등록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangBatchRegDAO.insert", mapParam);
	}

	public int insertStUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangBatchRegDAO.insertStUpjang", mapParam);
	}

	public int insertSccAddrInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangBatchRegDAO.insertSccAddrInfo", mapParam);
	}

	public int insertScoUpjangMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangBatchRegDAO.insertScoUpjangMst", mapParam);
	}

	public int insertFmsUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangBatchRegDAO.insertFmsUpjang", mapParam);
	}

	/**
	 * 업장 일괄등록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangBatchRegDAO.update", mapParam);
	}

	/**
	 * 업장 일괄등록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.upjangBatchRegDAO.delete", mapParam);
	}

}
