package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

/**
* 수발주제어 예외품목 등록하는 Service
* 
* @ClassName ExceptionItemMgntService.java
* @Description ExceptionItemMgntService Class
* @Modification-Information
* <pre>
*    수정일             수정자                 수정내용
*  ----------   ----------   -------------------------------
*  2022.04.22   hye.jin94    최초생성
* </pre>
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
public interface ExceptionItemMgntService {

	/**
	 * 자재를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectItem(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 수발주제어 예외 품목을 조회한다. 
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectExceptionItem(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 수발주제어 예외품목을 저장한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return rtnMap
	 *                processCnt    처리건수
	 *                listDupCheck  중복data
	 * @throws Exception
	*/
	Map<String, Object> saveExceptionItem(DataSetMap list) throws Exception;
	
	
}
