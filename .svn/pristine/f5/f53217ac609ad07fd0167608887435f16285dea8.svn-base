package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 반환발주 ReturnOrderByCust Service Interface
 * 
 * @ClassName ReturnOrderByCustService.java
 * @Description ReturnOrderByCustService Class
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
public interface ReturnOrderByCustService {

	/**
	 * 반환발주 조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectReturnOrderByCustList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 반환발주 정상주문일자(so_pr)조회
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectSoPrGetNeedDate(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 반환발주 반환가능업장 확인
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectRtnOrderYn(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 반환발주를 Insert/Update 처리
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return rtnMap 
	 *            조회결과
	 * @throws Exception
	 */ 
	int saveReturnOrderByCustInfo(DataSetMap list, LoginDTO loginDTO) throws Exception;
}
