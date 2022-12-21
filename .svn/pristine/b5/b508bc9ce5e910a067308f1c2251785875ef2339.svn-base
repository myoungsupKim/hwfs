package com.hwfs.sc.scz.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 거래처 정보를 관리하는 CustMgmt DAO
 *
 * @ClassName CustMgmtDAO.java
 * @Description CustMgmtDAO Class
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
@Repository("/sc/scz/custMgmtDAO")
public class CustMgmtDAO extends DefaultDAO {

	/**
	 * 거래처 정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.custMgmtDAO.selectList", mapParam);
	}

	/**
	 * 거래처 담당자 정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCustInchargeList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.custMgmtDAO.selectCustInchargeList", mapParam);
	}

	/**
	 * Full 사업자 번호로 거래처 정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectStCust(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.custMgmtDAO.selectStCust", mapParam);
	}

	/**
	 * Full 사업자 번호로 SAP 거래처 정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectSapCust(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.custMgmtDAO.selectSapCust", mapParam);
	}

	/**
	 * Full 사업자 번호로 SAP 거래처 정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectHlevelCust(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.custMgmtDAO.selectHlevelCust", mapParam);
	}
	
	/**
	 * 거래처 주소Key 중복 여부를 체크한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet searchAddrCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.custMgmtDAO.searchAddrCnt", mapParam);
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
		return super.queryForRecord("sc.scz.custMgmtDAO.selectSapRequestData", parameter);
	}

	/**
	 * SAP요청 건의 자료의 상태를 변경한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateStCustRequestStatus(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.custMgmtDAO.updateStCustRequestStatus", mapParam);
	}

	/**
	 * 거래처 정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.custMgmtDAO.insert", mapParam);
	}

	/**
	 * 거래처 정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.custMgmtDAO.update", mapParam);
	}

	/**
	 * 거래처 정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.custMgmtDAO.delete", mapParam);
	}

	/**
	 * 거래처 담당자 정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSccCustIncharge(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.custMgmtDAO.insertSccCustIncharge", mapParam);
	}

	/**
	 * 거래처 담당자 정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSccCustIncharge(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.custMgmtDAO.updateSccCustIncharge", mapParam);
	}

	/**
	 * 거래처 담당자 정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteSccCustIncharge(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.custMgmtDAO.deleteSccCustIncharge", mapParam);
	}
}
