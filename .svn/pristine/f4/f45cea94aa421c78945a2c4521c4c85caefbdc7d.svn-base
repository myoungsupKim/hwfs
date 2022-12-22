package com.hwfs.sm.spm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.spm.dao.AdvanceOccurInquiryDAO;

 /**
 * 선수금정보를 조회하는 AdvanceOccurInquiry Service Implementation
 * 
 * @ClassName AdvanceOccurInquiryServiceImpl.java
 * @Description AdvanceOccurInquiryServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.02    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.06.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/spm/advanceOccurInquiryService")
public class AdvanceOccurInquiryServiceImpl extends DefaultServiceImpl implements AdvanceOccurInquiryService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AdvanceOccurInquiryDAO Bean 생성 */
	@Resource(name = "/sm/spm/advanceOccurInquiryDAO")
	private AdvanceOccurInquiryDAO advanceOccurInquiryDAO;
	

	/**
	 * 선수금정보 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return advanceOccurInquiryDAO.selectList(mapParam);
	}

}
