package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * OutletDscnListService에 대한 설명 작성
 * @ClassName OutletDscnListService.java
 * @Description OutletDscnListService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 20.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 5. 20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface OutletDscnListService {
	RecordSet selectList(Map<String, Object> parameter) throws Exception;
	RecordSet selectDayList(Map<String, Object> parameter) throws Exception;
	//2017.03.13 DC상세내역 추가(현대카드 M포인트 추가 후 수정) 김호석 CH201702_00668
	RecordSet dcSalesList(Map<String, Object> parameter) throws Exception;
	RecordSet selectDcSumList(Map<String, Object> parameter) throws Exception;
}
