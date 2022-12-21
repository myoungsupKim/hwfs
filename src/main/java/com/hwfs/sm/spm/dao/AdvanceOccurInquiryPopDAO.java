package com.hwfs.sm.spm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 선수금발생조회팝업하는 AdvanceOccurInquiryPop DAO
 * 
 * @ClassName AdvanceOccurInquiryPopDAO.java
 * @Description AdvanceOccurInquiryPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.04   	유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.08.04
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/spm/advanceOccurInquiryPopDAO")
public class AdvanceOccurInquiryPopDAO extends DefaultDAO {
	
	/**
	 * 선수금발생조회팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.spm.advanceOccurInquiryPopDAO.selectList", mapParam);
	}

	/**
	 * 선수금발생조회팝업(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.spm.advanceOccurInquiryPopDAO.insert", mapParam);
	}
	
	/**
	 * 선수금발생조회팝업(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.spm.advanceOccurInquiryPopDAO.update", mapParam);
	}
	
	/**
	 * 선수금발생조회팝업(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.spm.advanceOccurInquiryPopDAO.delete", mapParam);
	}
	
}
