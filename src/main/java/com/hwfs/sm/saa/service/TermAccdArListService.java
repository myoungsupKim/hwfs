package com.hwfs.sm.saa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 기간별 사고채권 현황하는 TermAccdArList Service Interface
 * 
 * @ClassName TermAccdArListService.java
 * @Description TermAccdArListService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.29    김미경        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 김미경
 * @since 2015.05.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TermAccdArListService {

	/**
	 * 기간별 사고채권 현황 자료를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

}
