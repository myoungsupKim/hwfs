package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 채권내역 조회하는 ArListInquiry DAO
 * 
 * @ClassName ArListInquiryDAO.java
 * @Description ArListInquiryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.02.26    백승현        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 백승현
 * @since 2016.02.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/arListInquiryDAO")
public class ArListInquiryDAO extends DefaultDAO {
	
	/**
	 * 채권내역을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.arListInquiryDAO.selectList", mapParam);
	}
}
