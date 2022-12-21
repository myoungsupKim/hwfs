package com.hwfs.fs.fsl.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 선수금 식권 관리조회하는 UpjangMealTicketMgntPopup Service Interface
 * 
 * @ClassName UpjangMealTicketMgntPopupService.java
 * @Description UpjangMealTicketMgntPopupService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.21    이지운        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 이지운
 * @since 2015.07.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface UpjangMealTicketMgntPopupService {

	/**
	 * 선수금 식권 관리조회 목록을 조회한다.
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
	RecordSet selectUpjangMealTicketMgntPopupList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 선수금 식권 관리조회 목록을 조회한다.
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
	RecordSet selectUpjangMealTicketDetail(Map<String, Object> mapParam) throws Exception;

	/**
	 * 선수금등록 매출 회수 내역
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectUpjangMealSaleRcvyMgntPopupList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 선수금등록 입금 처리 내역
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectUpjangMealRecvDlngMgntPopupList(Map<String, Object> mapParam) throws Exception;
	
}
