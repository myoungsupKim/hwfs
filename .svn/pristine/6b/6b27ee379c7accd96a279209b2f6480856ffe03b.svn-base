package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 신용카드 거래내역 정보(SFTP파일 다운로드 내용) 조회하는 CardIsaApDataInquiry DAO
 * 
 * @ClassName CardIsaApDataInquiryDAO.java
 * @Description CardIsaApDataInquiryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.01.20   	DSKANG        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 DSKANG
 * @since 2016.01.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/cardIsaApDataInquiryDAO")
public class CardIsaApDataInquiryDAO extends DefaultDAO {
	
	/**
	 * 신용카드 거래내역 정보(SFTP파일 다운로드 내용) 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.cardIsaApDataInquiryDAO.selectList", mapParam);
	}	
	
}
