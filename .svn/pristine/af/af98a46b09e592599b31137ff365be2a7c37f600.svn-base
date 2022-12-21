package com.hwfs.sc.scz.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 계약 정보를 관리하는 contractMgmt DAO
 *
 * @ClassName contractMgmtDAO.java
 * @Description contractMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.17
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scz/contractMgmtDAO")
public class ContractMgmtDAO extends DefaultDAO {

	/**
	 * 계약 정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.contractMgmtDAO.selectList", mapParam);
	}
	
	/**
	 * 이자율 정보 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectRateList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.contractMgmtDAO.selectRateList", mapParam);
	}

	/**
	 * SAP요청할 자료를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public Record selectSapRequestData(Map<String, Object> parameter) throws Exception {
		return super.queryForRecord("sc.scz.contractMgmtDAO.selectSapRequestData", parameter);
	}

	/**
	 * SAP요청 건의 자료의 상태를 변경한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateStCustRequestStatus(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.contractMgmtDAO.updateStCustRequestStatus", mapParam);
	}

	/**
	 * 계약 정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.contractMgmtDAO.insert", mapParam);
	}

	/**
	 * 계약 정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.contractMgmtDAO.update", mapParam);
	}

	/**
	 * 계약 정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.contractMgmtDAO.delete", mapParam);
	}

}
