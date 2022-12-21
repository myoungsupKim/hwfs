package com.hwfs.ma.mag.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 현지구매내역 LocalPurchase Service Interface
 * 
 * @ClassName LocalPurchaseService.java
 * @Description LocalPurchaseService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.02.24	kihoon			[CH201703_00046] 최초작성
 *  
 * </pre>
 * @author kihoon
 * @since 2017.02.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface LocalPurchaseService {

	/**
	 * 정산유형코드 목록을 조회한다.
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectDltCdList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 현지구매내역조회
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

}
