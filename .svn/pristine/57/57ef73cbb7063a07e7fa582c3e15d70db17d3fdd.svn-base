package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * EodMgmtService에 대한 설명 작성
 * @ClassName EodMgmtService.java
 * @Description EodMgmtService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 15.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 6. 15.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EodMgmtService {
	
	//자재 Interface
	Map<String, Object> fopostrInfo(Map<String, Object> parameter) throws Exception;
	
	//영업회계 interface
	Map<String, Object> salesInfo(Map<String, Object> parameter) throws Exception;
	Map<String, Object> salesDetailInfo(Map<String, Object> parameter) throws Exception;
	Map<String, Object> salesPaymentInfo(Map<String, Object> parameter) throws Exception;
	Map<String, Object> cardApprovalInfo(Map<String, Object> parameter) throws Exception;
	 

	//매출집계
	Map<String, Object> salesSum(Map<String, Object> parameter) throws Exception;
	Map<String, Object> timeSum(Map<String, Object> parameter) throws Exception;
	Map<String, Object> menuSum(Map<String, Object> parameter) throws Exception;
	Map<String, Object> discnSum(Map<String, Object> parameter) throws Exception;
	
	RecordSet eodList(Map<String, Object> parameter) throws Exception;
	RecordSet endOfDayList(Map<String, Object> parameter) throws Exception;
	RecordSet eodAllList(Map<String, Object> parameter) throws Exception;
	
	//외부업장 처리
	//영업회계 interface
	Map<String, Object> salesInfoIf(Map<String, Object> parameter) throws Exception;
	Map<String, Object> salesDetailInfoIf(Map<String, Object> parameter) throws Exception;
	Map<String, Object> salesPaymentInfoIf(Map<String, Object> parameter) throws Exception;
	Map<String, Object> cardApprovalInfoIf(Map<String, Object> parameter) throws Exception;
	Map<String, Object> salesSumIf(Map<String, Object> parameter) throws Exception;
	Map<String, Object> timeSumIf(Map<String, Object> parameter) throws Exception;
	Map<String, Object> menuSumIf(Map<String, Object> parameter) throws Exception;

	//연세대 인터페이스
	Map<String, Object> boInterface(Map<String, Object> parameter) throws Exception;
}
