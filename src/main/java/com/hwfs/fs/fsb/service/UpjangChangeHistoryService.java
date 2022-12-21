package com.hwfs.fs.fsb.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 업장이력조회하는 UpjangChangeHistory Service Interface
 * 
 * @ClassName UpjangChangeHistoryService.java
 * @Description UpjangChangeHistoryService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    최문규        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface UpjangChangeHistoryService {

	/**
	 * 업장이력조회 목록을 조회한다.
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
	Map<String, RecordSet> selectUpjangChangeHistory(Map<String, Object> mapParam) throws Exception;
	
}
