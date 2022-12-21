package com.hwfs.guide.sample.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 주소정보 처리를 가이드하는 AddressSample DAO
 * 
 * @ClassName AddressSampleDAO.java
 * @Description AddressSampleDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.10   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.06.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/guide/sample/addressSampleDAO")
public class AddressSampleDAO extends DefaultDAO {
	
	/**
	 * 주소정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("guide.sample.addressSampleDAO.selectList", mapParam);
	}

	/**
	 * 주소정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("guide.sample.addressSampleDAO.insert", mapParam);
	}
	
	/**
	 * 주소정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("guide.sample.addressSampleDAO.update", mapParam);
	}
	
	/**
	 * 주소정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("guide.sample.addressSampleDAO.delete", mapParam);
	}
	
}
