package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 영업현금을 관리하는 SaleCashByValidDate Service Interface
 * 
 * @ClassName SaleCashByValidDateService.java
 * @Description SaleCashByValidDateService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.22    Yu        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.07.22
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SaleCashByValidDateService {

	/**
	 * 영업현금 내역 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 영업현금 내역 목록을 조회한다. (영업잔액조회 -From~To)
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList2(Map<String, Object> mapParam) throws Exception;

}
