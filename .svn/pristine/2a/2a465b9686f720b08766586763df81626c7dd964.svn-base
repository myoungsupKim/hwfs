package com.hwfs.fm.fmo.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 주문결의하는 OrderDecision Service Interface
 * 
 * @ClassName OrderDecisionService.java
 * @Description OrderDecisionService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.23    손형민        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface OrderDecisionService {

	/**
	 * 주문결의 목록을 조회한다.
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
	 * 주문결의 목록을 체크조회한다.
	 * <pre>
	 * - 0단가, 불용, 중지자재 여부 체크
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCheckList(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 주문결의 상세 목록을 조회한다.
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
	RecordSet selectSub(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 주문결의 상세 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSubFlag(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 주문결의 결의를 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveResol(DataSetMap list) throws Exception;

	/**
	 * 주문결의 하단 그리드 저장
	 * <pre>
	 * Row 별 신청비고 항목 수정;
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveRemList(DataSetMap list) throws Exception;
	Map<String, Object> saveRemList2(DataSetMap list) throws Exception;
	
	/**
	 * 주문결의 하단 그리드 저장
	 * <pre>
	 * Row 별 아이템 체크후 poStatus 가 HK가 아닐경우 return;
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	Map<String, Object> saveList(DataSetMap list, LoginDTO loginDTO) throws Exception;
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 주문결의 결의전 아이템별 발주제한을 체크한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	RecordSet savechk(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 주문결의 반려 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	Map<String, Object> returnList(DataSetMap list, LoginDTO loginDTO) throws Exception;
	Map<String, Object> returnSub(DataSetMap list, LoginDTO loginDTO) throws Exception;
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	/**
	 * 주문결의 입고일자변경 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int needupdate(DataSetMap list) throws Exception;
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	Map<String, Object> needupdateAll(DataSetMap list, DataSetMap sublist, LoginDTO loginDTO) throws Exception;
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
// [속도개선 Project 시작] 2017. 7. 20. 최범주 주문결의 반려 시 CS담당자 연락처로 송신자번호 셋팅
	/**
	 * CS담당자연락처정보 조회
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
	RecordSet selectCsChgAcaInfo(Map<String, Object> mapParam) throws Exception;
// [속도개선 Project   끝] 2017. 7. 20. 최범주
}
