package com.hwfs.ft.fsi.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

/**
* 미트워치 Service Interface
* 
* @ClassName MeatWatchService.java
* @Description MeatWatchService Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.03.18    김종준        최초생성
*  
* </pre>
* @author FC종합전산구축 : 식재도매 김종준
* @since 2015.03.18
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
public interface MeatWatchService {

	/**
	 * 미트워치 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
}
