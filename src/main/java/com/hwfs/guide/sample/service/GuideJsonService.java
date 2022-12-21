package com.hwfs.guide.sample.service;

import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

/**
 * GuideJsonService
 * @ClassName GuideJsonService.java
 * @Description GuideJsonService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.19.   lsjmanse      최초생성
 *  2015.03.25.   kksoo         프로젝트에 맞게 조정
 * </pre>
 * @author FC종합전산구축 : HONE lsjmanse
 * @since 2015. 3. 25.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public interface GuideJsonService {
	
	/**
	 * Json 처리 서비스 샘플 IF_SALE_INQ
	 *
	 * @param txHeader
	 * @param txData
	 * @param txResult
	 * @return JSONObject
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.GuideJsonService#IF_SALE_INQ(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	 */
	@CustomAnnotationDefinition(txId="IF_SALE_INQ",Description="pos 티켓발행 리소스.")
	public JSONObject IF_SALE_INQ(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;
	
	/**
	 * Json 처리 서비스 샘플 IF_TEST
	 * 
	 * @param txHeader
	 * @param txData
	 * @param txResult
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.GuideJsonService#IF_TEST(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	 */
	@CustomAnnotationDefinition(txId="IF_SALE_INQ2",Description="테스트 메소드 입니다.")
	public JSONObject IF_TEST(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception	;
	
}
