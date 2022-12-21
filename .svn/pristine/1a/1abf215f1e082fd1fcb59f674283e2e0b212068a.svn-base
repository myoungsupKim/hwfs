package com.hwfs.rc.roa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 개인별 용역 제공내역을 관리하는 PartTimeInquiry DAO
 * 
 * @ClassName PartTimeInquiryDAO.java
 * @Description PartTimeInquiryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18   	유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.03.18
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/roa/partTimeInquiryDAO")
public class PartTimeInquiryDAO extends DefaultDAO {
	
	/**
	 * 개인별 용역 제공내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.partTimeInquiryDAO.selectList", mapParam);
	}

	/**
	 * 개인별 용역 제공내역(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeInquiryDAO.insert", mapParam);
	}
	
	/**
	 * 개인별 용역 제공내역(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeInquiryDAO.update", mapParam);
	}
	
	/**
	 * 개인별 용역 제공내역(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.roa.partTimeInquiryDAO.delete", mapParam);
	}
	
}
