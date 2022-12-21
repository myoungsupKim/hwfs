package com.hwfs.sm.spm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 선수금정보를 조회하는 AdvanceOccurInquiry DAO
 * 
 * @ClassName AdvanceOccurInquiryDAO.java
 * @Description AdvanceOccurInquiryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.02   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.06.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/spm/advanceOccurInquiryDAO")
public class AdvanceOccurInquiryDAO extends DefaultDAO {
	
	/**
	 * 선수금정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.spm.advanceOccurInquiryDAO.selectList", mapParam);
	}

}
