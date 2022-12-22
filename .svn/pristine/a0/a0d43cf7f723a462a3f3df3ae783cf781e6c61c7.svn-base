package com.hwfs.fs.fsb.service;

import hone.core.util.record.RecordSet;

import org.json.JSONObject;

import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

import java.util.Map;

 /**
 * 업장이력조회하는 PreMealsApp Service Interface
 * 
 * @ClassName PreMealsAppService.java
 * @Description PreMealsAppService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    최문규        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

	

public interface PreMealsAppService {

	/**
	 * 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	/*
	//업장
	@CustomAnnotationDefinition(txId="IF_FC_UPJANG_RESULT",Description="기준정보 업장 조회용 Service")	
	public JSONObject selectData1(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;

	//식당
	@CustomAnnotationDefinition(txId="IF_FC_HALL_RESULT",Description="기준정보 식당 조회용 Service")
	public JSONObject selectData2(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;

	//끼니
	@CustomAnnotationDefinition(txId="IF_FC_MEAL_RESULT",Description="기준정보 끼니 조회용 Service")
	public JSONObject selectData3(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;

	//코너
	@CustomAnnotationDefinition(txId="IF_FC_CORNER_RESULT",Description="기준정보 코너 조회용 Service")
	public JSONObject selectData4(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;
	*/
	
	//기준정보
	@CustomAnnotationDefinition(txId="IF_FC_INFO_RESULT",Description="레시피 조회용 Service")
	public JSONObject selectInfo(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;
	
	//거래처
	@CustomAnnotationDefinition(txId="IF_FC_CUST_RESULT",Description="기준정보 거래처 조회용 Service")
	public JSONObject selectCust(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;

	//날씨
	@CustomAnnotationDefinition(txId="IF_FC_WEATHER_RESULT",Description="기준정보 날씨 조회용 Service")
	public JSONObject selectWeather(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;

	//식수
	//@CustomAnnotationDefinition(txId="IF_FC_MEALQTY_RESULT",Description="식수 조회용 Service")
	//public JSONObject selectData7(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;

	//레시피
	@CustomAnnotationDefinition(txId="IF_FC_RECIPE_RESULT",Description="레시피 조회용 Service")
	public JSONObject selectRecipe(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;

	
	//식단
	@CustomAnnotationDefinition(txId="IF_FC_MENU_RESULT",Description="식단 조회용 Service")
	public JSONObject selectMenu(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;

	//2022.08.23 김명섭 한화솔루션 챗봇용 식단정보(한화빌딩-100751)
	@CustomAnnotationDefinition(txId="IF_HANWHA_MENU_RESULT",Description="한화빌딩 식단 조회용 Service")
	public JSONObject hanwhaGourmetIF(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception;
		
}
