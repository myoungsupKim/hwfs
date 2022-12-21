package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 입금상세조회하는 ReceiveDetailInquiry DAO
 * 
 * @ClassName ReceiveDetailInquiryDAO.java
 * @Description ReceiveDetailInquiryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20   	유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/receiveDetailInquiryDAO")
public class ReceiveDetailInquiryDAO extends DefaultDAO {
	
	/**
	 * 입금상세조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveDetailInquiryDAO.selectList", mapParam);
	}
	
	/**
	 * 입금내역상세 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDetail(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveDetailInquiryDAO.selectDetail", mapParam);
	}

	/**
	 * 입금상세조회(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveDetailInquiryDAO.insert", mapParam);
	}
	
	/**
	 * 입금상세조회(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveDetailInquiryDAO.update", mapParam);
	}
	
	/**
	 * 입금상세조회(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveDetailInquiryDAO.delete", mapParam);
	}
	
}
