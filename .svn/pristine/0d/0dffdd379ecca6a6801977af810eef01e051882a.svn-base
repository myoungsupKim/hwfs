package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 행사그룹관리 등록하는 EventMgnt Service Interface
 * 
 * @ClassName EventMgntService.java
 * @Description EventMgntService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.07.21    Jaey        최초생성
 * </pre>
 * @author Jaey
 * @since 2021.07.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EventMgntService {

	/**
	 * 행사그룹관리 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectEventList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 행사그룹관리를 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리
	 * 	
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/	
	int saveEventInfo(DataSetMap list) throws Exception;
	
	/**
	 * 행사거래처관리 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectUpjangList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 행사거래처관리를 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */	
	int saveUpjangInfo(DataSetMap list) throws Exception;
	
	/**
	 * 행사거래처관리엑셀 조회
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return rtnMap 
	 *            조회결과
	 * @throws Exception
	 */
	Map<String, Object> selectUpjangListExcel(DataSetMap list) throws Exception;	
	
	/**
	 * 행사상품관리 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectItemList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 행사상품관리를 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */	
	int saveItemInfo(DataSetMap list) throws Exception;

	/**
	 * 행사삼품관리엑셀 조회
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return rtnMap 
	 *            조회결과
	 * @throws Exception
	 */
	Map<String, Object> selectItemListExcel(DataSetMap list) throws Exception;		

	/**
	 * 행사그룹이력 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectEventHistList(Map<String, Object> mapParam) throws Exception; 
	
	/**
	 * 행사거래처이력 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectEventUpjangHistList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 행사상품이력 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectEventItemHistList(Map<String, Object> mapParam) throws Exception;	
	
	/**
	 * 행사그룹관리 삭제
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int deleteEventGroup(DataSetMap list, LoginDTO loginDTO) throws Exception;
	
	/**
	 * 행사거래처관리 삭제
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int deleteEventUpjang(DataSetMap list, LoginDTO loginDTO) throws Exception;
	
	/**
	 * 행사자재관리 삭제
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int deleteEventItem(DataSetMap list, LoginDTO loginDTO) throws Exception;
	
}
