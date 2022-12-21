package com.hwfs.sc.cmn.service;

import org.json.JSONObject;

import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

 /**
 * 피엔씨월드 순천만 외부POS매출 인터페이스용  Service
 * @ClassName ExternalUpjangIFService.java
 * @Description ExternalUpjangIFService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018. 5. 14.   김명섭        최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2018. 5. 14.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface ExternalUpjangIFService {
	@CustomAnnotationDefinition(txId="IF_PNCWORLD_SALS_INFO",Description="피엔씨월드 순천만 외부POS매출 인터페이스용 Service")
	JSONObject saveData(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;
}
