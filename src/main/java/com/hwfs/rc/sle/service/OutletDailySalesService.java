package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * OutletDailySalesService에 대한 설명 작성
 * @ClassName OutletDailySalesService.java
 * @Description OutletDailySalesService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 25.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 8. 25.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface OutletDailySalesService {
	RecordSet selectList(Map<String, Object> parameter) throws Exception;

}
