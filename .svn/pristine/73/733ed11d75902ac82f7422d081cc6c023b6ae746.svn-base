package com.hwfs.ms.msm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 거래처별 채권/실적/입금조회하는 BondResultDepositInquiry DAO
 * 
 * @ClassName BondResultDepositInquiryDAO.java
 * @Description BondResultDepositInquiryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.01   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 현장지원_모바일 강대성
 * @since 2015.06.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/msm/bondResultDepositInquiryDAO")
public class BondResultDepositInquiryDAO extends DefaultDAO {
	
	/**
	 * 거래처별 채권/실적/입금조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.msm.bondResultDepositInquiryDAO.selectList", mapParam);
	}	
	
}
