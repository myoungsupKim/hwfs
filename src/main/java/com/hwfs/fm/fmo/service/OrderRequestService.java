package com.hwfs.fm.fmo.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 주문신청하는 OrderRequest Service Interface
 * 
 * @ClassName OrderRequestService.java
 * @Description OrderRequestService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.07    최성연        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.05.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface OrderRequestService {

	/**
	 * 구매유형을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectType(Map<String, Object> mapParam) throws Exception;

	/**
	 * 주문신청 목록을 조회한다.
	 * <pre>
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
	 * fics 주문신청 목록과 hub i/f내역을 대조한다.(fims기준)
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectHubCompareList(Map<String, Object> mapParam) throws Exception;

	/**
	 * fics 주문신청 목록과 hub i/f내역을 대조한다.(허브메카 기준)
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectHubCompareList2(Map<String, Object> mapParam) throws Exception;

	/**
	 * 주문신청 상세정보 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectDetail(Map<String, Object> mapParam) throws Exception;

	/**
	 * 주문신청 상세정보의 MAX 진행상태를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectMaxStatus(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 주문신청 창고 목록을 조회한다. : COMBO STYLE
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSubinv(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 주문신청 창고 목록을 조회한다. : POPUP STYLE
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSubinvPop(Map<String, Object> mapParam) throws Exception;

	/**
	 * 주문신청 창고 목록을 조회한다. : 1건
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSubinv2(Map<String, Object> mapParam) throws Exception;

	/**
	 * 주문신청관련 D-DAY 관련정보를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectDays(Map<String, Object> mapParam) throws Exception;
	

	/**
	 * 주문신청관련 여신관리여부를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCreYn(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 본사통합 여신관리여부를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectHeadCre(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 최종 발주일자를 조회한다.[여신체크]
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectNeedDate(Map<String, Object> mapParam) throws Exception;


	/**
	 * 여신관리여부에 따라 여신정보를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCreInfo(Map<String, Object> mapParam) throws Exception;


	/**
	 * 여신관리여부에 따라 여신정보를 조회한다[도매유통_출고관리]
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCreInfoFTS(Map<String, Object> mapParam) throws Exception;

	/**
	 * 여신관리여부에 따라 여신정보를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCreInfoTest(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 선택한 창고에 대한 기본정보를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSubinvInfo(Map<String, Object> mapParam) throws Exception;

	/**
	 * 구매신청자재검색 화면 조건상단 기본정보를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectPopView(Map<String, Object> mapParam) throws Exception;
	

	/**
	 * 구매신청자재검색 정보를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectPopItem(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 주문통제 일자 여부를 조회한다
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectOrdCtrlDays(Map<String, Object> mapParam) throws Exception;	
	
	
	/**
	 * 주문신청번호 MASTER 정보를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectPrMaster(Map<String, Object> mapParam) throws Exception;	

	/**
	 * 주문신청번호 DETAIL 정보를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectPrDetail(Map<String, Object> mapParam) throws Exception;	
	
	
	/**
	 * 업장별 주문통제 정보를 조회한다
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectOrdCtrl(Map<String, Object> mapParam) throws Exception;	


	/**
	 * 엑셀업로드에 대한  기본정보를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectUpload(Map<String, Object> mapParam) throws Exception;	
	

	/**
	 * 주문신청번호 정보를 조회한다
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	String selectPrNum(Map<String, Object> mapParam) throws Exception;	

	
	/**
	 * 신청승인번호 정보를 조회한다
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	String selectApNum(Map<String, Object> mapParam) throws Exception;	
	
	
	/**
	 * 엑셀업로드에 대한  여신정보를 체크한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return String 
	 *            조회결과
	 * @throws Exception
	*/
	String selectCrdCheck(DataSetMap list) throws Exception;	
	
	
	/**
	 * 구매신청관련 수발주제한을 체크한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return String 
	 *            조회결과
	 * @throws Exception
	*/
	String selectPoQtyCheck(DataSetMap list) throws Exception;	
	
	
	
	/**
	 * 주문신청 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	 * 주문신청서(을)를 취소(Delete) 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	Map<String, Object> deletePr(DataSetMap list, LoginDTO loginDTO) throws Exception;
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	

	/**
	 * 주문신청서(을)를 취소(Delete) 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	Map<String, Object> saveCancelPrList(Map<String, Object> mapParam, DataSetMap list, LoginDTO loginDTO) throws Exception;	


	/**
	 * 주문신청내역을 삭제(Delete) 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	Map<String, Object> deleteItem(DataSetMap list, LoginDTO loginDTO) throws Exception;
	
	
	/**
	 * 엑셀업로드용 주문신청 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveUpload(DataSetMap list) throws Exception;
	Map<String, Object> saveGroup(DataSetMap list) throws Exception;

	/**
	 * 구매 전송하지 못한 SO_PR을 삭제한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int deleteSoPr(DataSetMap list) throws Exception;
	
	
}
