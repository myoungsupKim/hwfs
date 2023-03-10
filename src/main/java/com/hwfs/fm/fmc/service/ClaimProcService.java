package com.hwfs.fm.fmc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 클레임처리하는 ClaimProc Service Interface
 * 
 * @ClassName ClaimProcService.java
 * @Description ClaimProcService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.21    최영준        최초생성
 *  2021.08.17    DEV02         [PJT]주문채널통합
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.05.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface ClaimProcService {

	/**
	 * 클레임처리 목록을 조회한다.
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
	 * 클레임처리 목록을 조회한다.
	 * [PJT]주문채널통합
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
	RecordSet selectBrandList(Map<String, Object> mapParam) throws Exception;

	
	/**
	 * 자재 목록을 조회한다.
	 *
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet returnItemSearch(Map <String, Object> parm,Map <String, Object> inVar) throws Exception;
	
	
	/**
	 * 클레임처리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
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
	 * 클레임처리 [처리취소] 처리된 클레임을 다시 요청상태로 변경한다.  - 교환 처리된 클레임만 가능.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int cancelList(DataSetMap list) throws Exception;
	
	/**
	 * 클레임처리 [요청] 처리된 클레임을 삭제 HIST 테이블에 저장한다. [요청취소] 상태가 된다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int reqCancelList(DataSetMap list) throws Exception;
	
	int saveHnrIfHist(DataSetMap list, LoginDTO loginDTO) throws Exception;
	
}
