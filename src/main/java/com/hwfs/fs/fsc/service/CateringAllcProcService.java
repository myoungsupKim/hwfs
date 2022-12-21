package com.hwfs.fs.fsc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 케터링 지원배정 등록하는 CateringAllcProc Service Interface
 * 
 * @ClassName CateringAllcProcService.java
 * @Description CateringAllcProcService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.11    양효준        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 양효준
 * @since 2015.03.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface CateringAllcProcService {

	/**
	 * 케터링 지원배정(행사) 등록 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCeleList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 케터링 지원배정(조리인력) 등록 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectCookHumanList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 케터링 지원배정(기기/기물) 등록 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectUtensilList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 케터링 지원배정(교육대상) 등록 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectCookGuidList(Map<String, Object> mapParam) throws Exception;
	

	/**
	 * 케터링 지원배정 등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap parameterCele, DataSetMap parameterCookHuman, DataSetMap parameterUtensilList, DataSetMap parameterCookGuidList, LoginDTO loginDTO ) throws Exception;
}
