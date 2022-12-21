// [속도개선 Project 시작] 2017. 7. 3. 최범주 입금처리이력 및 매출보정이력을 조회한다.
package com.hwfs.fm.fmf.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

/**
 * 입금처리이력 및 매출보정이력을 조회하는 SaleModifyHistory Service Interface
 * 
 * @ClassName SaleModifyHistoryService.java
 * @Description SaleModifyHistoryService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.07.03    최범주        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최범주
 * @since 2017.07.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SaleModifyHistoryService {

	/**
	 * 입금처리이력 및 매출보정이력 목록을 조회한다.
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
}
// [속도개선 Project   끝] 2017. 7. 3. 최범주