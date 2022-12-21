package com.hwfs.sc.scz.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 거래처를 신청하는 CustRequest DAO
 *
 * @ClassName CustRequestDAO.java
 * @Description CustRequestDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.29
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scz/custRequestDAO")
public class CustRequestDAO extends DefaultDAO {

	/**
	 * 거래처 신청정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.custRequestDAO.selectList", mapParam);
	}

	/**
	 * 신규 거래처중에서 sap에 요청할 정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public Record selectSapRequest(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("sc.scz.custRequestDAO.selectSapRequest", mapParam);
	}

	/**
	 * ST_CUST에 등록되어 있는 거래처인지를 판단한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectExistsStCust(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.scz.custRequestDAO.selectExistsStCust", parameter);
	}

	/**
	 * SCC_SAP_CUST에 등록되어 있는 거래처인지를 판단한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectExistsSccSapCust(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.scz.custRequestDAO.selectExistsSccSapCust", parameter);
	}

	/**
	 * SCC_CUST_REQUEST에 등록되어 있는 거래처인지를 판단한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectExistsSccCustRequest(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.scz.custRequestDAO.selectExistsSccCustRequest", parameter);
	}

	/**
	 * 거래처 신청정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSccCustRequest(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.custRequestDAO.insertSccCustRequest", mapParam);
	}

	/**
	 * 거래처를 생성한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int insertStCust(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.custRequestDAO.insertStCust", mapParam);
	}


	/**
	 * 거래처 신청정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSapRequestStatus(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.custRequestDAO.updateSapRequestStatus", mapParam);
	}

	/**
	 * 거래처 신청정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.custRequestDAO.update", mapParam);
	}

	/**
	 * 거래처 신청정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.custRequestDAO.delete", mapParam);
	}

}
