package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 주소검색을하는 AddrSearch Service Interface
 *
 * @ClassName AddrSearchService.java
 * @Description AddrSearchService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.09    김재섭        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.06.09
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface AddrSearchService {

	RecordSet selectSidoList() throws Exception;
	RecordSet selectGugunList(Map<String, Object> parameter) throws Exception;
	RecordSet selectRoadList(Map<String, Object> parameter) throws Exception;
	RecordSet selectJibunList(Map<String, Object> parameter) throws Exception;
	Map<String, Object> setAddress(Map<String, Object> parameter, String bindAddressKey, String sabun) throws Exception;
}
