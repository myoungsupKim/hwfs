package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 카드 중복승인 내역을 관리하는 CardDupApprovalInquiry Service Interface
 * 
 * @ClassName CardDupApprovalInquiryService.java
 * @Description CardDupApprovalInquiryService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06    Yu        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통항영업 Yu
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface CardDupApprovalInquiryService {

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
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

}
