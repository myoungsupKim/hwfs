package com.hwfs.fs.fsf.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 매출집계관리(일별/월별/년별)하는 FuneralSaleSum Service Interface
 * 
 * @ClassName FuneralSaleSumService.java
 * @Description FuneralSaleSumService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.28    최문규        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FuneralSaleSumService {

	/**
	 * 매출집계관리 목록을 조회한다.
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
	Map<String, RecordSet> selectFuneralSaleSumList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 매출집계관리 목록을 품목별로 조회한다.
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
	Map<String, RecordSet> selectFuneralSaleSumItemList(Map<String, Object> mapParam) throws Exception;
}
