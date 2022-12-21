package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 거래처별 담당자를 관리하는 CustIncharge DAO
 *
 * @ClassName CustInchargeDAO.java
 * @Description CustInchargeDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.15
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/custInchargeDAO")
public class CustInchargeDAO extends DefaultDAO {

	/**
	 * 거래처별 담당자 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.custInchargeDAO.selectList", mapParam);
	}

	/**
	 * 거래처별 담당자 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet select(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.custInchargeDAO.select", mapParam);
	}

	/**
	 * 거래처별 담당자(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.custInchargeDAO.insert", mapParam);
	}

	/**
	 * 거래처별 담당자(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.custInchargeDAO.update", mapParam);
	}

	/**
	 * 거래처별 담당자(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.custInchargeDAO.delete", mapParam);
	}

}
