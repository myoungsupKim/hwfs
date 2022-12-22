package com.hwfs.ei.cmn;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

 /**
 * ResponseData에 대한 설명 작성
 * @ClassName ResponseData.java
 * @Description ResponseData Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 11. 20.   김재섭        최초생성
 * </pre>
 * @author 김재섭
 * @since 2015. 11. 20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class ResponseData {
	JSONObject DATA_MAP = new JSONObject();
	
	/**
	 * 보낼 자료를 설정한다.
	 *
	 * @param key
	 * @param value
	 * @throws JSONException
	 */
	public void addData(String key, RecordSet value) throws JSONException {
		DATA_MAP.put(key, value);
	}
	
	/**
	 * 보낼 자료를 설정한다.
	 *
	 * @param key
	 * @param value
	 * @throws JSONException
	 */
	public void addData(String key, Map<String, Object> value) throws JSONException {
		DATA_MAP.put(key, value);
	}
	
	/**
	 * 보낼 자료를 설정한다.
	 *
	 * @param key
	 * @param value
	 * @throws JSONException
	 */
	public void addData(String key, List<Map<String, Object>> value) throws JSONException {
		JSONArray list = new JSONArray();
		
		for (int i = 0 ; i < value.size() ; i++) {
			list.put(value.get(i));
		}
		
		DATA_MAP.put(key, list);
	}
	
	/**
	 * 설정된 자료를 요청한 Client로 전송한다.
	 *
	 * @return
	 * @throws JSONException
	 */
	public JSONObject send() throws JSONException {
		JSONObject sendData = new JSONObject();
		//DATA_MAP.put("ErrorMsg", "");
		sendData.put("data", DATA_MAP);
		
		return sendData;
	}
}
