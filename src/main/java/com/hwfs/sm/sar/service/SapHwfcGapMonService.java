package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * SAP HWFC 거래처별 잔액비교 SapHwfcGapMon Service Interface
 * 
 * @ClassName SapHwfcGapMonService.java
 * @Description SapHwfcGapMonService Class
 * @Modification-Information
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.09.20    김호석        최초생성
 * </pre>
 * @author 
 * @since 2018.09.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2018 by HANWHA System/ICT CO.,LTD. All right reserved.
 * </pre>
 */
public interface SapHwfcGapMonService {

	/**
	 * SAP HWFC 거래처별 잔액비교 조회한다.
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

}
