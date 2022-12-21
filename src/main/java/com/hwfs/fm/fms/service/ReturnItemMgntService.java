package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

/**
* 반환가능품목등록하는 Service
* 
* @ClassName ReturnItemMgntService.java
* @Description ReturnItemMgntService Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2021.07.07   DEV02        최초생성
* </pre>
* @author [PJT]주문채널통합 : DEV02
* @since 2021.07.07
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
public interface ReturnItemMgntService {

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
	 * 반환가능품목을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectReturnItem(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 반환가능품목을 저장한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return rtnMap
	 *                processCnt    처리건수
	 *                listDupCheck  중복data
	 * @throws Exception
	*/
	Map<String, Object> saveReturnItem(DataSetMap list) throws Exception;
	
	
}
