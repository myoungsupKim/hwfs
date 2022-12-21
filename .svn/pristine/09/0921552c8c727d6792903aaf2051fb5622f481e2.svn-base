package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 반환/교환/증정발주 ReturnOrderBySales Service Interface
 * 
 * @ClassName ReturnOrderBySalesService.java
 * @Description ReturnOrderBySalesService Class
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
public interface ReturnOrderBySalesService {

	/**
	 * 반환/교환/증정발주 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectReturnOrderBySalesList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 반환 주문유형의 주문일자 선택시 정상주문 유형여부 확인 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectRtnOrderYn(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 반환/교환/증정발주를 Insert/Update 처리
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return rtnMap 
	 *            조회결과
	 * @throws Exception
	 */ 
	int saveReturnOrderBySalesInfo(DataSetMap list, LoginDTO loginDTO) throws Exception;
}
