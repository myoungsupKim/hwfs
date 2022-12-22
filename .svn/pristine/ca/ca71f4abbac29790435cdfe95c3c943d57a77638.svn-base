package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.srm.dao.CardDupApprovalInquiryDAO;

 /**
 * 카드 중복승인 내역을 관리하는 CardDupApprovalInquiry Service Implementation
 * 
 * @ClassName CardDupApprovalInquiryServiceImpl.java
 * @Description CardDupApprovalInquiryServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통항영업 Yu
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/srm/cardDupApprovalInquiryService")
public class CardDupApprovalInquiryServiceImpl extends DefaultServiceImpl implements CardDupApprovalInquiryService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CardDupApprovalInquiryDAO Bean 생성 */
	@Resource(name = "/sm/srm/cardDupApprovalInquiryDAO")
	private CardDupApprovalInquiryDAO cardDupApprovalInquiryDAO;
	

	/**
	 * 카드 중복승인 내역 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return cardDupApprovalInquiryDAO.selectList(mapParam);
	}

}
