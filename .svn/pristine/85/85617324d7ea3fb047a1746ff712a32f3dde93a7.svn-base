package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.sar.dao.SuspenseInquiryDAO;

 /**
 * 가수금잔액을 조회하는 SuspenseInquiry Service Implementation
 * 
 * @ClassName SuspenseInquiryServiceImpl.java
 * @Description SuspenseInquiryServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.13    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.08.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/suspenseInquiryService")
public class SuspenseInquiryServiceImpl extends DefaultServiceImpl implements SuspenseInquiryService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SuspenseInquiryDAO Bean 생성 */
	@Resource(name = "/sm/sar/suspenseInquiryDAO")
	private SuspenseInquiryDAO suspenseInquiryDAO;
	

	/**
	 * 가수금잔액 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return suspenseInquiryDAO.selectList(mapParam);
	}

}
