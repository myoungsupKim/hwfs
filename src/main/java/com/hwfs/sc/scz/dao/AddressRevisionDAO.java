package com.hwfs.sc.scz.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 주소정제 결과를 보정하는 AddressRevision DAO
 * 
 * @ClassName AddressRevisionDAO.java
 * @Description AddressRevisionDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.26   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.09.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scz/addressRevisionDAO")
public class AddressRevisionDAO extends DefaultDAO {
	
	/**
	 * 주소 보정 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectStUpjang(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.addressRevisionDAO.selectStUpjang", mapParam);
	}

	/**
	 * 주소 보정 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectFmsUpjang1(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.addressRevisionDAO.selectFmsUpjang1", mapParam);
	}

	public RecordSet selectFmsUpjang2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.addressRevisionDAO.selectFmsUpjang2", mapParam);
	}

	public RecordSet selectStCust(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.addressRevisionDAO.selectStCust", mapParam);
	}
	
	public RecordSet selectFmsSecureLand(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.addressRevisionDAO.selectFmsSecureLand", mapParam);
	}
	
	public RecordSet selectFmsSecurePerson(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.addressRevisionDAO.selectFmsSecurePerson", mapParam);
	}
	
	public RecordSet selectScoUpjangMst(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.addressRevisionDAO.selectScoUpjangMst", mapParam);
	}
	
	public RecordSet selectScoUpjangCustHis(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.addressRevisionDAO.selectScoUpjangCustHis", mapParam);
	}
	
	public RecordSet selectScoUpjangCust(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.addressRevisionDAO.selectScoUpjangCust", mapParam);
	}
	
	public RecordSet selectMakCustMstA(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.addressRevisionDAO.selectMakCustMstA", mapParam);
	}
	
	public RecordSet selectMakCustMstB(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.addressRevisionDAO.selectMakCustMstB", mapParam);
	}
	
	
	/**
	 * 주소 보정(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.addressRevisionDAO.insert", mapParam);
	}
	
	/**
	 * 주소 보정(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.addressRevisionDAO.update", mapParam);
	}
	
	/**
	 * 주소 보정(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scz.addressRevisionDAO.delete", mapParam);
	}
	
}
