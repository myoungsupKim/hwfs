package com.hwfs.sm.spm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 선수금잔액조회(유효일자별)하는 AdvanceBalanceInquiry DAO
 * 
 * @ClassName AdvanceBalanceInquiryDAO.java
 * @Description AdvanceBalanceInquiryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.13   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/spm/advanceBalanceInquiryDAO")
public class AdvanceBalanceInquiryDAO extends DefaultDAO {
	
	/**
	 * 선수금잔액을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.spm.advanceBalanceInquiryDAO.selectList", mapParam);
	}
	
}
