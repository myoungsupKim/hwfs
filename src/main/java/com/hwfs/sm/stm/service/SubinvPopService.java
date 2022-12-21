package com.hwfs.sm.stm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 창고를 관리하는 SubinvPop Service Interface
 * 
 * @ClassName SubinvPopService.java
 * @Description SubinvPopService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.27    Yu        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.07.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SubinvPopService {

	/**
	 * 창고 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

}
