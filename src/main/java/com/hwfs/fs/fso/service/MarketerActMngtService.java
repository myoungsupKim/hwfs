package com.hwfs.fs.fso.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 마케터별 실적관리하는 MarketerActMngt Service Interface
 * 
 * @ClassName MarketerActMngtService.java
 * @Description MarketerActMngtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.14    최문규        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.07.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface MarketerActMngtService {
	
	/**
	 * 담당 마케터(급식,식재, 외식)를 조회한다.
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
	RecordSet selectPrcgEmpCd(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 신규수주계획 목록을 조회한다.
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
	RecordSet selectProposalPlanList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 마케터별 실적관리 목록(기본운영계획, 수정운영계획)을 조회한다.
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
	Map<String, RecordSet> selectMarketerActMngtList(Map<String, Object> mapParam) throws Exception;

}
