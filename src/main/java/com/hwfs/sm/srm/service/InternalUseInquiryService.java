package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 내부 이용 발생 내역을 관리하는 InternalUseInquiry Service Interface
 * 
 * @ClassName InternalUseInquiryService.java
 * @Description InternalUseInquiryService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29    Yu        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface InternalUseInquiryService {

	/**
	 * 내부 이용 발생 내역 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

}
