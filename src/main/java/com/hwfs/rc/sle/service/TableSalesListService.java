package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * TableSalesListService에 대한 설명 작성
 * @ClassName TableSalesListService.java
 * @Description TableSalesListService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 14.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 5. 14.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TableSalesListService {
	RecordSet selectList(Map<String, Object> parameter) throws Exception;
	RecordSet selectListTableGrp(Map<String, Object> parameter) throws Exception;

}
