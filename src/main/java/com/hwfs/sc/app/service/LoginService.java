package com.hwfs.sc.app.service;

import org.json.JSONObject;

import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

 /**
 * 식재앱 로그인 인터페이스용  Service
 * @ClassName LoginService.java
 * @Description LoginService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.06.20.  김명섭        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.06.20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
public interface LoginService {
	@CustomAnnotationDefinition(txId="IF_LOGIN_SERVICE",Description="식재앱 로그인 인터페이스용 Service")
	JSONObject callService(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;
}
