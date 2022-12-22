package com.hwfs.sm.spm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.spm.dao.AdvanceBalanceInquiryDAO;

 /**
 * 선수금잔액조회(유효일자별)하는 AdvanceBalanceInquiry Service Implementation
 * 
 * @ClassName AdvanceBalanceInquiryServiceImpl.java
 * @Description AdvanceBalanceInquiryServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.13    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/spm/advanceBalanceInquiryService")
public class AdvanceBalanceInquiryServiceImpl extends DefaultServiceImpl implements AdvanceBalanceInquiryService {
	
	/** AdvanceBalanceInquiryDAO Bean 생성 */
	@Resource(name = "/sm/spm/advanceBalanceInquiryDAO")
	private AdvanceBalanceInquiryDAO advanceBalanceInquiryDAO;
	
	/**
	 * 선수금잔액을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return advanceBalanceInquiryDAO.selectList(mapParam);
	}

}
