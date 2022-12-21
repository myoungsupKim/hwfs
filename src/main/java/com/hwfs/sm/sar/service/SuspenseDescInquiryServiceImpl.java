package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.sar.dao.SuspenseDescInquiryDAO;

 /**
 * FC본사 통장 입금 내역을 조회하는 SuspenseDescInquiry Service Implementation
 * 
 * @ClassName SuspenseDescInquiryServiceImpl.java
 * @Description SuspenseDescInquiryServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/suspenseDescInquiryService")
public class SuspenseDescInquiryServiceImpl extends DefaultServiceImpl implements SuspenseDescInquiryService {
	
	/** SuspenseDescInquiryDAO Bean 생성 */
	@Resource(name = "/sm/sar/suspenseDescInquiryDAO")
	private SuspenseDescInquiryDAO suspenseDescInquiryDAO;
	
	/**
	 * FC본사 통장 입금 내역을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return suspenseDescInquiryDAO.selectList(mapParam);
	}

}
