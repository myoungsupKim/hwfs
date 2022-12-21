package com.hwfs.ms.msm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 손익현황 조회하는 ProfitAndLossReport Service Interface
 * 
 * @ClassName ProfitAndLossReportService.java
 * @Description ProfitAndLossReportService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.13    강대성        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 현장지원_모바일 강대성
 * @since 2015.07.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface ProfitAndLossReportService {

	/**
	 * 손익현황 조회 목록을 조회한다.
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
