package com.hwfs.sm.srm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 카드 중복승인 내역을 관리하는 CardDupApprovalInquiry DAO
 * 
 * @ClassName CardDupApprovalInquiryDAO.java
 * @Description CardDupApprovalInquiryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통항영업 Yu
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/srm/cardDupApprovalInquiryDAO")
public class CardDupApprovalInquiryDAO extends DefaultDAO {
	
	/**
	 * 카드 중복승인 내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.cardDupApprovalInquiryDAO.selectList", mapParam);
	}

}
