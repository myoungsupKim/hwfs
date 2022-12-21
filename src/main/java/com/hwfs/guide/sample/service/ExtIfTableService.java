package com.hwfs.guide.sample.service;

import org.json.JSONObject;

import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

 /**
 * 식권자판기 인터페이스용 샘플 Service
 * @ClassName ExtIfTableService.java
 * @Description ExtIfTableService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 30.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 7. 30.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface ExtIfTableService {
	@CustomAnnotationDefinition(txId="ExtIfTable",Description="식권자판기 인터페이스용 샘플 Service")
	JSONObject saveData(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;
}
