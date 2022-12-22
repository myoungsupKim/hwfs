package com.hwfs.fm.fmf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 일마감관리하는 DayCloseMngt Service Interface
 * 
 * @ClassName DayCloseMngtService.java
 * @Description DayCloseMngtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.08    손형민        최초생성
 *  2017.03.29	  kihoon		[CH201703_00751] 미마감내역 조회 팝업 프로그램 개발
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface DayCloseMngtService {

	/**
	 * 일마감관리 목록을 조회한다.
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
	 * 일마감관리 상세 목록을 조회한다.
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
	RecordSet selectSubList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectSubList2(Map<String, Object> mapParam) throws Exception;

	
	/**
	 * 일마감관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	Map<String, Object> closing(DataSetMap list,Map<String, Object> search) throws Exception;
	Map<String, Object> cncl(DataSetMap list,Map<String, Object> search) throws Exception;
	Map<String, Object> remagam(DataSetMap list,Map<String, Object> search) throws Exception;
	Map<String, Object> slaCncl(DataSetMap list, Map<String, Object> search) throws Exception;
	
	/**
	 * 전체 일마감 권한을 조회한다.
	 * 추가일자:20170323  처리자:맹수영  요청자:이혜은
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectAllClose(Map<String, Object> mapParam) throws Exception;	
	
	/**
	 * 일미마감관리 목록을 조회한다.
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
	RecordSet selectCheckCloseDayInfo(Map<String, Object> mapParam) throws Exception;
	RecordSet selectCheckClose(Map<String, Object> mapParam) throws Exception;
	
	
		/**
	 * 여신 집계 프로시처 호출 용 temp 테이블 조회
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectTemp(Map<String, Object> mapParam) throws Exception;
	
}
