package com.hwfs.fm.fmo.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 주문신청에 대한 자재변경하는 OrderRequestChange Service Interface
 * 
 * @ClassName OrderRequestChangeService.java
 * @Description OrderRequestChangeService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.29    최성연        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.07.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface OrderRequestChangeService {

	/**
	 * 주문신청관련 대상/변경자재 목록을 조회한다.(팝업용)
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectItemPop(Map<String, Object> mapParam) throws Exception;
	RecordSet selectItemPop2(Map<String, Object> mapParam) throws Exception;

	
	/**
	 * 주문신청관련 자재변경 목록을 조회한다.
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
	 * 변경자재의 판매단가 및 신청정보를 조회한다
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return 처리건수
	 * @throws Exception
	*/
	RecordSet selectId(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 변경자재에 대한 여신정보를 체크한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return String 
	 *            조회결과
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	String[] selectCrdCheck2(DataSetMap list) throws Exception;
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	

	/**
	 * 주문신청관련 자재변경 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	Map<String, Object> saveList(DataSetMap list, String[] rtnValue, LoginDTO loginDTO) throws Exception;
// [속도개선 Project   끝] 2017. 8. 4. 최범주
}
