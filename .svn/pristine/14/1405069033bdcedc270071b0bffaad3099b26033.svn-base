package com.hwfs.sc.cmn.service;

import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;
import hone.core.util.record.MetadataRecord;
import hone.core.util.record.MetadataRecordSet;
import hone.core.util.record.RecordSet;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.cmn.dao.ExternalPosMasterIFDAO;

 /**
 * ExternalPosMasterIFServiceImpl에 대한 설명 작성
 * @ClassName ExternalPosMasterIFServiceImpl.java
 * @Description ExternalPosMasterIFServiceImpl Class 
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
@Service
public class ExternalPosMasterIFServiceImpl extends DefaultServiceImpl implements ExternalPosMasterIFService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name="/sc/cmn/externalPosMasterIFDAO")
	private ExternalPosMasterIFDAO externalPosMasterIFDAO;

	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param txHeader
	 * @param txData
	 * @param txResult
	 * @return
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="IF_POS_SALE_DOWNLOAD",Description="FC POS 마스터 외부 인터페이스용 Service")
	public JSONObject selectList(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {

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

		RecordSet rs = null;
		
		//반환할 결과 데이터를 설정 : key 값은 업무에 맞게 설정
		JSONObject result = new JSONObject();
		JSONObject searchResult = new JSONObject();

		if(txDiv.equals("OUTLET_MST")){
			
			rs = externalPosMasterIFDAO.selectOutletMst(parameter);
			
		} else if(txDiv.equals("FNB_TABLE_CD")){
			
			rs = externalPosMasterIFDAO.selectFnbTableCd(parameter);
			
		} else if(txDiv.equals("OUTLET_MENU")){

			rs = externalPosMasterIFDAO.selectOutletMenu(parameter);
		
		}
		
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

		//로그저장start
		int insLogCnt = 0;
		String txId = "";
		String localIp = "";
		String encoding = "";
		String encYn = "";
		txId = txHeader.getString("txId");
		localIp = txHeader.getString("localIp");
		encoding = txHeader.getString("encoding");
		encYn = txHeader.getString("encYn");
		parameter.put("txDiv", txDiv);
		parameter.put("txId", txId);
		parameter.put("localIp", localIp);
		parameter.put("encoding", encoding);
		parameter.put("encYn", encYn);
		insLogCnt += externalPosMasterIFDAO.logInsert(parameter);
		//로그저장end
		
		return result;
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
	
	/**
	 * 데이터의 날짜 길이 체크
	 *
	 * @param data
	 * @return
	 */
	public boolean isDate(String data){
		if(data.length() == 8)return true;
		return false;
	}
	
	public String chkIsNull(JSONArray datas,int row,String col) throws Exception{
		String data = "";
		try{
			data = datas.getJSONObject(row).getString(col);
		}catch(Exception e){
			return "";
		}
		return data;
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
