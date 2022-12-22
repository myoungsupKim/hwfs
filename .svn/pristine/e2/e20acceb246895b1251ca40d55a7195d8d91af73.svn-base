package com.hwfs.fs.fsb.service;

import hone.core.util.record.MetadataRecord;
import hone.core.util.record.MetadataRecordSet;
import hone.core.util.record.RecordSet;
import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;





import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;





import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fs.fsb.dao.PreMealsAppDAO;

 /**
 * 업장이력조회하는 PreMealsApp Service Implementation
 * 
 * @ClassName PreMealsAppServiceImpl.java
 * @Description PreMealsAppServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
//@Service("/fs/fsb/preMealsAppService")
@Service
public class PreMealsAppServiceImpl extends DefaultServiceImpl implements PreMealsAppService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UpjangPackHistoryDAO Bean 생성 */
	@Resource(name = "/fs/fsb/preMealsAppDAO")
	private PreMealsAppDAO preMealsAppDAO;
	

	/**
	 * 업장이력조회 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	/*
	//1.업장조회
	public RecordSet selectUpjang(Map<String, Object> mapParam) throws Exception {
		return preMealsAppDAO.selectUpjang(mapParam);		
	}

	//2.식당조회
	public RecordSet selectHall(Map<String, Object> mapParam) throws Exception {
		return preMealsAppDAO.selectHall(mapParam);		
	}

	//3.끼니조회
	public RecordSet selectMeal(Map<String, Object> mapParam) throws Exception {
		return preMealsAppDAO.selectMeal(mapParam);		
	}

	//4.코너조회
	public RecordSet selectCorner(Map<String, Object> mapParam) throws Exception {
		return preMealsAppDAO.selectCorner(mapParam);		
	}

	//5.거래처조회
	public RecordSet selectCust(Map<String, Object> mapParam) throws Exception {
		return preMealsAppDAO.selectCust(mapParam);		
	}

	//6.날씨조회
	public RecordSet selectWeather(Map<String, Object> mapParam) throws Exception {
		return preMealsAppDAO.selectWeather(mapParam);		
	}

	//7.식수조회
	public RecordSet selectMealQty(Map<String, Object> mapParam) throws Exception {
		return preMealsAppDAO.selectMealQty(mapParam);		
	}

	//8.식단조회
	public RecordSet selectMenu(Map<String, Object> mapParam) throws Exception {
		return preMealsAppDAO.selectMenu(mapParam);		
	}
	*/
	/**
	 * selectData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param txHeader
	 * @param txData
	 * @param txResult
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.FslIfVendingService#saveData(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	//1.기준정보 조회
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="IF_FC_INFO_RESULT",Description="기준정보 조회용 Service")
	public JSONObject selectInfo(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {
		
    	try
    	{

			RecordSet rs = null;

			//반환할 결과 데이터를 설정 : key 값은 업무에 맞게 설정
			JSONObject result = new JSONObject();
			JSONObject searchResult = new JSONObject();
			
    		String txDiv = "";
    		if(txHeader.has("txDiv")){
    			txDiv = txHeader.getString("txDiv");
    		} else {
    			logger.error("txDiv is empty!");
    			throw new BizException ("txDiv is empty!");
    		}    		

    		String sParamString = txData.getString("data");
    		
    		JSONObject txParam = new JSONObject(sParamString);
    		
    		Map<String, Object> parameter = new HashMap<String, Object>();
    		parameter = toMap(txParam);
    		
    		//조회
    		if("SELECTDATA".equals(txDiv)){
    			
    			rs = preMealsAppDAO.selectInfo(parameter);
    			
    		} //if("SELECTDATA".equals(txDiv))

    		if(rs == null) {
    			searchResult.put("resultData", "");
    			searchResult.put("resultCount", 0);
    			searchResult.put("txDiv", txDiv);
    		} else {
    			
    			rs = removeNull(rs);
    			
    			JSONArray rsArray = new JSONArray(rs);
    			
    			String rData = rsArray.toString();    		
    			
    			searchResult.put("resultData", rData);
    			searchResult.put("resultCount", rs.size());
    			searchResult.put("txDiv", "INFO");
    		}	
    		
    		result.put("data", searchResult);
    		
    		return result;
    		
    	}
    	catch (Exception e)
    	{
    	}
		
		throw new BizException ("selectData error!");
	}
	/*
	//1.업장조회
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="IF_FC_UPJANG_RESULT",Description="기준정보 업장 조회용 Service")
	public JSONObject selectData1(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {
		
    	try
    	{

			RecordSet rs = null;
			RecordSet rs1 = null;
			RecordSet rs2 = null;

			//반환할 결과 데이터를 설정 : key 값은 업무에 맞게 설정
			JSONObject result = new JSONObject();
			JSONObject searchResult = new JSONObject();
			
    		String txDiv = "";
    		if(txHeader.has("txDiv")){
    			txDiv = txHeader.getString("txDiv");
    		} else {
    			logger.error("txDiv is empty!");
    			throw new BizException ("txDiv is empty!");
    		}    		

    		String sParamString = txData.getString("data");
    		
    		JSONObject txParam = new JSONObject(sParamString);
    		
    		Map<String, Object> parameter = new HashMap<String, Object>();
    		parameter = toMap(txParam);
    		
    		//조회
    		if("SELECTDATA".equals(txDiv)){
    			
    			rs = preMealsAppDAO.selectUpjang(parameter);
    			rs1 = preMealsAppDAO.selectHall(parameter);
    			rs2 = preMealsAppDAO.selectCorner(parameter);
    			
    		} //if("SELECTDATA".equals(txDiv))

    		if(rs == null) {
    			searchResult.put("resultData", "");
    			searchResult.put("resultCount", 0);
    			searchResult.put("txDiv", txDiv);
    		} else {
    			
    			rs = removeNull(rs);
    			
    			JSONArray rsArray = new JSONArray(rs);
    			//JSONArray rsArray1 = new JSONArray(rs1);
    			//JSONArray rsArray2 = new JSONArray(rs2);
    			
    			searchResult.put("resultData", rsArray.toString());
    			searchResult.put("resultCount", rs.size());
    			searchResult.put("txDiv", "UPJANG");
    			
    		
    		result.put("data", searchResult);
    		
    		return result;
    		
    	}
    	catch (Exception e)
    	{
    	}
		
		throw new BizException ("selectData error!");
	}
	
	//2.식당조회
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="IF_FC_HALL_RESULT",Description="기준정보 식당 조회용 Service")
	public JSONObject selectData2(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {
		
    	try
    	{

			RecordSet rs = null;

			//반환할 결과 데이터를 설정 : key 값은 업무에 맞게 설정
			JSONObject result = new JSONObject();
			JSONObject searchResult = new JSONObject();
    		
    		String txDiv = "";
    		if(txHeader.has("txDiv")){
    			txDiv = txHeader.getString("txDiv");
    		} else {
    			logger.error("txDiv is empty!");
    			throw new BizException ("txDiv is empty!");
    		}    		

    		String sParamString = txData.getString("data");
    		
    		JSONObject txParam = new JSONObject(sParamString);
    		
    		Map<String, Object> parameter = new HashMap<String, Object>();
    		parameter = toMap(txParam);
    		
    		//조회
    		if("SELECTDATA".equals(txDiv)){
    			
    			rs = preMealsAppDAO.selectHall(parameter);
    			
    		} //if("SELECTDATA".equals(txDiv))

    		if(rs == null) {
    			searchResult.put("resultData", "");
    			searchResult.put("resultCount", 0);
    			searchResult.put("txDiv", txDiv);
    		} else {
    			
    			rs = removeNull(rs);
    			
    			JSONArray rsArray = new JSONArray(rs);
    			
    			searchResult.put("resultData", rsArray.toString());
    			searchResult.put("resultCount", rs.size());
    			searchResult.put("txDiv", txDiv);
    		}
    		
    		result.put("data", searchResult);
    		
    		return result;
    		
    	}
    	catch (Exception e)
    	{
    	}
		
		throw new BizException ("selectData error!");
	}

	//3.끼니조회
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="IF_FC_MEAL_RESULT",Description="기준정보 끼니 조회용 Service")
	public JSONObject selectData3(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {
		
    	try
    	{

			RecordSet rs = null;

			//반환할 결과 데이터를 설정 : key 값은 업무에 맞게 설정
			JSONObject result = new JSONObject();
			JSONObject searchResult = new JSONObject();
    		
    		String txDiv = "";
    		if(txHeader.has("txDiv")){
    			txDiv = txHeader.getString("txDiv");
    		} else {
    			logger.error("txDiv is empty!");
    			throw new BizException ("txDiv is empty!");
    		}    		

    		String sParamString = txData.getString("data");
    		
    		JSONObject txParam = new JSONObject(sParamString);
    		
    		Map<String, Object> parameter = new HashMap<String, Object>();
    		parameter = toMap(txParam);
    		
    		//조회
    		if("SELECTDATA".equals(txDiv)){
    			
    			rs = preMealsAppDAO.selectMeal(parameter);
    			
    		} //if("SELECTDATA".equals(txDiv))

    		if(rs == null) {
    			searchResult.put("resultData", "");
    			searchResult.put("resultCount", 0);
    			searchResult.put("txDiv", txDiv);
    		} else {
    			
    			rs = removeNull(rs);
    			
    			JSONArray rsArray = new JSONArray(rs);
    			
    			searchResult.put("resultData", rsArray.toString());
    			searchResult.put("resultCount", rs.size());
    			searchResult.put("txDiv", txDiv);
    		}
    		
    		result.put("data", searchResult);
    		
    		return result;
    		
    	}
    	catch (Exception e)
    	{
    	}
		
		throw new BizException ("selectData error!");
	}

	//4.코너조회
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="IF_FC_CORNER_RESULT",Description="기준정보 코너 조회용 Service")
	public JSONObject selectData4(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {
		
    	try
    	{

			RecordSet rs = null;

			//반환할 결과 데이터를 설정 : key 값은 업무에 맞게 설정
			JSONObject result = new JSONObject();
			JSONObject searchResult = new JSONObject();
    		
    		String txDiv = "";
    		if(txHeader.has("txDiv")){
    			txDiv = txHeader.getString("txDiv");
    		} else {
    			logger.error("txDiv is empty!");
    			throw new BizException ("txDiv is empty!");
    		}    		

    		String sParamString = txData.getString("data");
    		
    		JSONObject txParam = new JSONObject(sParamString);
    		
    		Map<String, Object> parameter = new HashMap<String, Object>();
    		parameter = toMap(txParam);
    		
    		//조회
    		if("SELECTDATA".equals(txDiv)){
    			
    			rs = preMealsAppDAO.selectCorner(parameter);
    			
    		} //if("SELECTDATA".equals(txDiv))

    		if(rs == null) {
    			searchResult.put("resultData", "");
    			searchResult.put("resultCount", 0);
    			searchResult.put("txDiv", txDiv);
    		} else {
    			
    			rs = removeNull(rs);
    			
    			JSONArray rsArray = new JSONArray(rs);
    			
    			searchResult.put("resultData", rsArray.toString());
    			searchResult.put("resultCount", rs.size());
    			searchResult.put("txDiv", txDiv);
    		}
    		
    		result.put("data", searchResult);
    		
    		return result;
    		
    	}
    	catch (Exception e)
    	{
    	}
		
		throw new BizException ("selectData error!");
	}
	*/

	//5.거래처조회
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="IF_FC_CUST_RESULT",Description="기준정보 거래처 조회용 Service")
	public JSONObject selectCust(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {
		
    	try
    	{

			RecordSet rs = null;

			//반환할 결과 데이터를 설정 : key 값은 업무에 맞게 설정
			JSONObject result = new JSONObject();
			JSONObject searchResult = new JSONObject();
    		
    		String txDiv = "";
    		String fixedDt = "";
    		if(txHeader.has("txDiv")){
    			txDiv = txHeader.getString("txDiv");
    		} else {
    			logger.error("txDiv is empty!");
    			throw new BizException ("txDiv is empty!");
    		}    	

    		if(txHeader.has("fixedDt")){
    			fixedDt = txHeader.getString("fixedDt");
    		}	

    		String sParamString = txData.getString("data");
    		
    		JSONObject txParam = new JSONObject(sParamString);
    		
    		Map<String, Object> parameter = new HashMap<String, Object>();
    		parameter.put("fixedDt", fixedDt);
    		
    		//조회
    		if("SELECTDATA".equals(txDiv)){
    			
    			rs = preMealsAppDAO.selectCust(parameter);
    			
    		} //if("SELECTDATA".equals(txDiv))

    		if(rs == null) {
    			searchResult.put("resultData", "");
    			searchResult.put("resultCount", 0);
    			searchResult.put("txDiv", "CUST");
    		} else {
    			
    			rs = removeNull(rs);
    			
    			JSONArray rsArray = new JSONArray(rs);
    			
    			String rData = rsArray.toString();   
    			
    			searchResult.put("resultData", rData);
    			searchResult.put("resultCount", rs.size());
    			searchResult.put("txDiv", txDiv);
    		}
    		
    		result.put("data", searchResult);
    		
    		return result;
    		
    	}
    	catch (Exception e)
    	{
    	}
		
		throw new BizException ("selectData error!");
	}

	//6.날씨조회
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="IF_FC_WEATHER_RESULT",Description="기준정보 날씨 조회용 Service")
	public JSONObject selectWeather(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {
		
    	try
    	{

			RecordSet rs = null;

			//반환할 결과 데이터를 설정 : key 값은 업무에 맞게 설정
			JSONObject result = new JSONObject();
			JSONObject searchResult = new JSONObject();
    		
    		String txDiv = "";
    		String fromDt = "";
    		String toDt = "";
    		
    		if(txHeader.has("txDiv")){
    			txDiv = txHeader.getString("txDiv");
    		} else {
    			logger.error("txDiv is empty!");
    			throw new BizException ("txDiv is empty!");
    		}    		

    		if(txHeader.has("fromDt")){
    			fromDt = txHeader.getString("fromDt");
    		}

    		if(txHeader.has("toDt")){
    			toDt = txHeader.getString("toDt");
    		}

    		String sParamString = txData.getString("data");
    		
    		JSONObject txParam = new JSONObject(sParamString);
    		
    		Map<String, Object> parameter = new HashMap<String, Object>();
    		parameter.put("fromDt", fromDt);
    		parameter.put("toDt", toDt);
    		
    		//parameter = toMap(txParam);
    		
    		//조회
    		if("SELECTDATA".equals(txDiv)){
    			
    			rs = preMealsAppDAO.selectWeather(parameter);
    			
    		} //if("SELECTDATA".equals(txDiv))

    		if(rs == null) {
    			searchResult.put("resultData", "");
    			searchResult.put("resultCount", 0);
    			searchResult.put("txDiv", "WEATHER");
    		} else {
    			
    			rs = removeNull(rs);
    			
    			JSONArray rsArray = new JSONArray(rs);
    			
    			String rData = rsArray.toString();    	
    			
    			searchResult.put("resultData", rData);
    			searchResult.put("resultCount", rs.size());
    			searchResult.put("txDiv", txDiv);
    		}
    		
    		result.put("data", searchResult);
    		
    		return result;
    		
    	}
    	catch (Exception e)
    	{
    	}
		
		throw new BizException ("selectData error!");
	}

	//7.레시피조회
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="IF_FC_RECIPE_RESULT",Description="레시피 조회용 Service")
	public JSONObject selectRecipe(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {
		
    	try
    	{

			RecordSet rs = null;

			//반환할 결과 데이터를 설정 : key 값은 업무에 맞게 설정
			JSONObject result = new JSONObject();
			JSONObject searchResult = new JSONObject();
    		
    		String txDiv = "";
    		String fixedDt = "";
    		if(txHeader.has("txDiv")){
    			txDiv = txHeader.getString("txDiv");
    		} else {
    			logger.error("txDiv is empty!");
    			throw new BizException ("txDiv is empty!");
    		}    	

    		if(txHeader.has("fixedDt")){
    			fixedDt = txHeader.getString("fixedDt");
    		}	

    		String sParamString = txData.getString("data");
    		
    		JSONObject txParam = new JSONObject(sParamString);
    		
    		Map<String, Object> parameter = new HashMap<String, Object>();
    		parameter.put("fixedDt", fixedDt);
    		//parameter = toMap(txParam);
    		
    		//조회
    		if("SELECTDATA".equals(txDiv)){
    			
    			rs = preMealsAppDAO.selectRecipe(parameter);
    			
    		} //if("SELECTDATA".equals(txDiv))

    		if(rs == null) {
    			searchResult.put("resultData", "");
    			searchResult.put("resultCount", 0);
    			searchResult.put("txDiv", "RECIPE");
    		} else {
    			
    			rs = removeNull(rs);
    			
    			JSONArray rsArray = new JSONArray(rs);
    			
    			String rData = rsArray.toString();    
    			
    			searchResult.put("resultData", rData);
    			searchResult.put("resultCount", rs.size());
    			searchResult.put("txDiv", txDiv);
    		}
    		
    		result.put("data", searchResult);
    		
    		return result;
    		
    	}
    	catch (Exception e)
    	{
    	}
		
		throw new BizException ("selectData error!");
	}

	//8.식단조회
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="IF_FC_MENU_RESULT",Description="식단 조회용 Service")
	public JSONObject selectMenu(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {
		
    	try
    	{

			RecordSet rs = null;

			//반환할 결과 데이터를 설정 : key 값은 업무에 맞게 설정
			JSONObject result = new JSONObject();
			JSONObject searchResult = new JSONObject();
    		
    		String txDiv = "";
    		String fromDt = "";
    		String toDt = "";
    		String fixedDt = "";
    		
    		if(txHeader.has("txDiv")){
    			txDiv = txHeader.getString("txDiv");
    		} else {
    			logger.error("txDiv is empty!");
    			throw new BizException ("txDiv is empty!");
    		}    		

    		if(txHeader.has("fromDt")){
    			fromDt = txHeader.getString("fromDt");
    		}

    		if(txHeader.has("toDt")){
    			toDt = txHeader.getString("toDt");
    		}

    		if(txHeader.has("fixedDt")){
    			fixedDt = txHeader.getString("fixedDt");
    		}
    		//logger.debug("fromDt : " + fromDt);
    		//logger.debug("toDt : " + toDt);
    		//logger.debug("fixedDt : " + fixedDt);    		
    		
    		String sParamString = txData.getString("data");
    		
    		JSONObject txParam = new JSONObject(sParamString);
    		
    		Map<String, Object> parameter = new HashMap<String, Object>();
    		parameter.put("fromDt", fromDt);
    		parameter.put("toDt", toDt);
    		parameter.put("fixedDt", fixedDt);
    		
    		//parameter = toMap(txParam);  
    		//logger.debug("parameter : " + parameter);     		
    		
    		//조회
    		if("SELECTDATA".equals(txDiv)){
    			
    			rs = preMealsAppDAO.selectMenu(parameter);
    			
    		} //if("SELECTDATA".equals(txDiv))

    		if(rs == null) {
    			searchResult.put("resultData", "");
    			searchResult.put("resultCount", 0);
    			searchResult.put("txDiv", "MENU");
    		} else {
    			
    			rs = removeNull(rs);
    			
    			JSONArray rsArray = new JSONArray(rs);
    			
    			String rData = rsArray.toString();    	
    			
    			searchResult.put("resultData", rData);
    			searchResult.put("resultCount", rs.size());
    			searchResult.put("txDiv", txDiv);
    		}
    		
    		result.put("data", searchResult);
    		
    		return result;
    		
    	}
    	catch (Exception e)
    	{
    	}
		
		throw new BizException ("selectData error!");
	}
	
	
	//2022.08.23 김명섭 한화솔루션 챗봇용 식단정보(한화빌딩-100751)
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="IF_HANWHA_MENU_RESULT",Description="한화빌딩 식단 조회용 Service")
	public JSONObject hanwhaGourmetIF(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {
		
    	try
    	{

    		String txDiv = "";
    		
    		if(txHeader.has("txDiv")){
    			txDiv = txHeader.getString("txDiv");
    		} else {
    			logger.error("txDiv is empty!");
    			throw new BizException ("txDiv is empty!");
    		}
    		
    		String sParamString;
    		
    		Map<String, Object> parameter = new HashMap<String, Object>();

    		RecordSet rs = null;
    		
    		//반환할 결과 데이터를 설정 : key 값은 업무에 맞게 설정
    		JSONObject result = new JSONObject();
    		JSONObject procResult = new JSONObject();

    		if(txDiv.equals("hanwhaGourmetIF")){
    			
    			sParamString = txData.getString("data");
    			JSONObject txParam = new JSONObject(sParamString);
    			parameter = toMap(txParam);
    			
    			rs = preMealsAppDAO.hanwhaGourmetIF(parameter);

    			if(rs == null) {
    				procResult.put("resultData", "");
    				procResult.put("resultCount", 0);
    			} else {
    				
    				rs = removeNull(rs);
    				
    				JSONArray rsArray = new JSONArray(rs);
    				
    				procResult.put("resultData", rsArray.toString());
    				procResult.put("resultCount", rs.size());
    			}
    			
    		}

    		else
    		{
    			procResult.put("resultData", "");
    			procResult.put("resultCount", 0);
    			procResult.put("ErrorCode", -99); //오류
    			procResult.put("ErrorMsg", "서비스ID가 올바르지 않습니다.");    									
    		}
    		
    		procResult.put("txDiv", txDiv);

    		result.put("data", procResult);

    		return result;
    		
    	}
    	catch (Exception e)
    	{
    	}
		
		throw new BizException ("selectData error!");
	}
	
	
	/**
	 * 데이터 널 여부 체크
	 * isNull 기능 설명
	 *
	 * @param data
	 * @return
	 */
	public boolean isNull(String data){
		if(data == null || data.equals("")){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 데이터의 길이 체크
	 * isLength 기능 설명
	 *
	 * @param data
	 * @param lengthSize
	 * @return
	 */
	public boolean isLength(String data, int lengthSize){
		if(data.length() > lengthSize)return true;
		return false;
	}
	
    @SuppressWarnings("unchecked")
	public static Map<String, Object> toMap(JSONObject object) throws JSONException {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Iterator <String> keys = object.keys();
		while(keys.hasNext()){
			String key = keys.next();
			Object value = object.get(key);
			
			if(value instanceof JSONArray){
				value = toList((JSONArray)value);
			}else if (value instanceof JSONObject){
				value = toMap((JSONObject)value);
			}
			map.put(key, value);
			
		}
		
		return map;
	}

	public static List<Object> toList(JSONArray array) throws JSONException {
		List<Object> list = new ArrayList<Object>();
		
		for(int i=0; i< array.length();i++){
			Object value = array.get(i);
			if(value instanceof JSONArray){
				value = toList((JSONArray)value);
			}else if(value instanceof JSONObject){
				value = toMap((JSONObject)value);
			}
			list.add(value);
		}
		return list;
	}

    public static RecordSet removeNull(RecordSet rs) {
    	
    	MetadataRecordSet result = new MetadataRecordSet(rs.getMetadata());
    	
		for(int i = 0; i < rs.size(); i++){
    		
			MetadataRecord metadataRecord = new MetadataRecord(rs.getMetadata());
			Iterator<String> meta = rs.getMetadata().getKeys();
			
			while(meta.hasNext()){
    			
				String key = meta.next();
    		
    			String value = rs.get(i).getString(key);
    			
    			if(value == null || "null".equals(value)){
    				value = "";
    			}
    			
    			metadataRecord.put(key, value);
			}
			
			result.add(metadataRecord);
    	}
    	return result;
    	
    }
	
}
