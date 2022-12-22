package com.hwfs.ms.msm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 거래처정보조회하는 CustomerInformationInquiry DAO
 * 
 * @ClassName CustomerInformationInquiryDAO.java
 * @Description CustomerInformationInquiryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.25   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일 강대성
 * @since 2015.03.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/msm/customerInformationInquiryDAO")
public class CustomerInformationInquiryDAO extends DefaultDAO {
	
	/**
	 * 거래처정보조회(가망고객) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCustList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.msm.customerInformationInquiryDAO.selectCustList", mapParam);
	}	
	
	/**
	 * 거래처정보조회(거래고객) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.msm.customerInformationInquiryDAO.selectUpjangList", mapParam);
	}	
	
}
