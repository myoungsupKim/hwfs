package com.hwfs.fs.fso.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 업장 정보 활용장표하는 UpjangInfoCycleRept Service Interface
 * 
 * @ClassName UpjangInfoCycleReptService.java
 * @Description UpjangInfoCycleReptService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.07    박준석        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 박준석
 * @since 2015.07.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface UpjangInfoCycleReptService {

	/**
	 * 업장 정보 활용장표 목록을 조회한다.
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

	/**
	 * 업장 정보 활용장표 목록을 상세조회한다.
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
	Map<String, RecordSet> selectListDetail(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * P/L 정보 현황을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectPlDetail(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * P/L 정보 열람관리 목록을 조회한다.
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
	RecordSet selectPlviewSignList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * P/L 정보 열람관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int savePlviewSignList(DataSetMap list) throws Exception;
}
