package com.hwfs.sc.cmn.service;

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
import com.hwfs.sc.cmn.dao.PatrolMonDAO;

 /**
 * PatrolMonServiceImpl에 대한 설명 작성
 * @ClassName PatrolMonServiceImpl.java
 * @Description PatrolMonServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.12.27.   김명섭        최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2018.12.27.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class PatrolMonServiceImpl extends DefaultServiceImpl implements PatrolMonService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name="/sc/cmn/PatrolMonDAO")
	private PatrolMonDAO PatrolMonDAO;
	
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
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="IF_FC_PATROL_MON_RESULT",Description="Patrol 모니터링 결과 조회용 Service")
	public JSONObject selectData(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {
		
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
    			
    			rs = PatrolMonDAO.selectList(parameter);
    			
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
