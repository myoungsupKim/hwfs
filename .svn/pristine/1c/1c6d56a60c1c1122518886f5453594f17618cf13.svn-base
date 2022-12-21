package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 발주현황하는 ReturnOrderList Service Interface
 * 
 * @ClassName ReturnOrderListService.java
 * @Description ReturnOrderListService Class
 * @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2021.08.30   DEV02        최초생성
* </pre>
* @author [PJT]주문채널통합 : DEV02
* @since 2021.08.30
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
public interface ReturnOrderListService {

	/**
	 * 발주현황 목록을 조회한다.
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
	 * 발주현황 상세 목록을 조회한다.
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
	RecordSet selectSub(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 발주현황 브랜드 확정 저장
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveConfirmList(DataSetMap list, LoginDTO loginDTO) throws Exception;
	
	/**
	 * 발주현황 브랜드 반려 저장
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	int saveReturnList(DataSetMap list, LoginDTO loginDTO) throws Exception;
}
