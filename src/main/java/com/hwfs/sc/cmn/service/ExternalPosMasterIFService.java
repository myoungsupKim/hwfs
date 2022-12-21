package com.hwfs.sc.cmn.service;

import org.json.JSONObject;

import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

 /**
 * FC POS 마스터 외부 인터페이스용  Service
 * @ClassName ExternalVanApprvIFService.java
 * @Description ExternalVanApprvIFService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.01.18.  김명섭        최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2019.01.18.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface ExternalPosMasterIFService {
	@CustomAnnotationDefinition(txId="IF_POS_SALE_DOWNLOAD",Description="FC POS 마스터 외부 인터페이스용 Service")
	JSONObject selectList(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;
}
