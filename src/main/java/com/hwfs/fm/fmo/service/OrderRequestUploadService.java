package com.hwfs.fm.fmo.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 주문 엑셀업로드하는 OrderRequestUpload Service Interface
 * 
 * @ClassName OrderRequestUploadService.java
 * @Description OrderRequestUploadService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.13    손형민        최초생성
 *  2021.07.27      DEV02     [PJT]주문채널통합
 *  2021.10.14		hye.jin94  휴먼푸드 발주생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.10.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface OrderRequestUploadService {

	/**
	 * 주문 엑셀업로드 목록을 조회한다.
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
	int selectList(DataSetMap list) throws Exception;

	/**
	 * 주문 엑셀업로드 DataSetMap의 데이터를 temp 등록 처리한다.
	 * <pre>
	 * - saveList(07), saveList2(29)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	Map<String, List> saveList(DataSetMap list,LoginDTO loginDTO) throws Exception;
	Map<String, List> saveListTest(DataSetMap list,LoginDTO loginDTO) throws Exception;
	Map<String, List> saveListBrand(DataSetMap list,LoginDTO loginDTO) throws Exception;
	Map<String, List> saveListMoadam(DataSetMap list,LoginDTO loginDTO) throws Exception;
	Map<String, List> saveListMoadam29(DataSetMap list,LoginDTO loginDTO) throws Exception;
	Map<String, List> saveList2(DataSetMap list,LoginDTO loginDTO) throws Exception;
	Map<String, List> saveList2Test(DataSetMap list,LoginDTO loginDTO) throws Exception;
	
	
	/**
	 * 주문 엑셀업로드 DataSetMap의 데이터를 SO_PR 등록 후 I/F 처리한다.
	 * <pre>
	 * - FMS_SO_PR 조회 -> SO_PR 등록 -> I/F 호출 ->  결과 조회
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	RecordSet saveIfList(DataSetMap list, LoginDTO loginDTO) throws Exception;
	RecordSet saveBrandIfList(DataSetMap list, LoginDTO loginDTO) throws Exception;
	RecordSet saveMoadamIfList(DataSetMap list, LoginDTO loginDTO) throws Exception;
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	RecordSet selectSISSubinvCode(Map<String, Object> mapParam) throws Exception;
	
	RecordSet selectSISItemCode(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 휴먼푸드 발주정보 업로드 권한을 조회한다.
	 * 추가일자:20211008  처리자:김혜진 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectHumanAuth(Map<String, Object> mapParam) throws Exception;	
	
	/**
	 * 모아담 업장리스트를 조회한다.
	 * 추가일자:20220630  처리자:김혜진 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet searchMoadamUpjang(Map<String, Object> mapParam) throws Exception;	
	
	/**
	 * 허브메카 id를 조회한다.
	 * 추가일자:20220701  처리자:김혜진 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet searchHubId(Map<String, Object> mapParam) throws Exception;	
	
	/**
	 * 허브메카 id를 전체 조회한다.
	 * 추가일자:20220712  처리자:김혜진 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet searchHubIdAll(Map<String, Object> mapParam) throws Exception;	
	
	
	/**
	 * 휴먼푸드 발주 내역을 조회한다.
	 * 추가일자:20211025  처리자:김혜진 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectMoadamList(Map<String, Object> mapParam) throws Exception;	
	
	/**
	 * 허브메카 발주 내역을 조회한다.
	 * 추가일자:20220607  처리자:김혜진 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectHubmekaList(Map<String, Object> mapParam) throws Exception;	
	
	/**
	 * 허브메카 발주 내역 (긴급)을 조회한다.
	 * 추가일자:20220906  처리자:김혜진 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectHubmekaList29(Map<String, Object> mapParam) throws Exception;	
	
	/**
	 * 허브메카 발주 내역 데이터를 temp 등록 처리한다.
	 * 추가일자:20220607  처리자:김혜진 
	 * - saveList(07), saveList2(29)
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	Map<String, List> saveListHubmeka(DataSetMap list,LoginDTO loginDTO) throws Exception;
	
	/**
	 * 허브메카 발주 내역 데이터를 temp 등록 처리한다.
	 * 추가일자:20220701  처리자:김혜진 
	 * - 엑셀업로드 긴급
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	Map<String, List> saveListHubmeka29(DataSetMap list,LoginDTO loginDTO) throws Exception;
	
	/**
	 * 허브메카 주문 엑셀업로드 DataSetMap의 데이터를 SO_PR 등록 후 I/F 처리한다.
	 * <pre>
	 * - FMS_SO_PR 조회 -> SO_PR 등록 -> I/F 호출 ->  결과 조회
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	RecordSet saveHubmekaIfList(DataSetMap list, LoginDTO loginDTO) throws Exception;
	
	/**
	 * 허브메카 발주정보 업로드 권한을 조회한다.
	 * 추가일자:20220615  처리자:김혜진 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectHubAuth(Map<String, Object> mapParam) throws Exception;	
	
	
}
