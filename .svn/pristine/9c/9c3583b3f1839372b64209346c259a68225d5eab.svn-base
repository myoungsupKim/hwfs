package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.sar.dao.ArListInquiryDAO;

 /**
 * 채권내역 조회하는 ArListInquiry Service Implementation
 * 
 * @ClassName ArListInquiryServiceImpl.java
 * @Description ArListInquiryServiceImpl Class
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
@Service("/sm/sar/arListInquiryService")
public class ArListInquiryServiceImpl extends DefaultServiceImpl implements ArListInquiryService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** ArListInquiryDAO Bean 생성 */
	@Resource(name = "/sm/sar/arListInquiryDAO")
	private ArListInquiryDAO arListInquiryDAO;
	

	/**
	 * 채권내역을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return arListInquiryDAO.selectList(mapParam);
	}
}
