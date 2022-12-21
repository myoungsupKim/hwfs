package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * FC본사 통장 입금 내역을 조회하는 SuspenseDescInquiry Service Interface
 * 
 * @ClassName SuspenseDescInquiryService.java
 * @Description SuspenseDescInquiryService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15    JUN        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SuspenseDescInquiryService {

	/**
	 * FC본사 통장 입금 내역을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

}
