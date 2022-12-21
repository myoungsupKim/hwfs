package com.hwfs.sm.spm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 선수금을 대체처리하는 AdvanceAlterPop Service Interface
 * 
 * @ClassName AdvanceAlterPopService.java
 * @Description AdvanceAlterPopService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.02    JUN        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.04.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface AdvanceAlterPopService {

	/**
	 * 선수금 대체번호에 따른 선수금대체정보(조회조건)를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet getAdvanceAltMst(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 선수금대체처리 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

}
