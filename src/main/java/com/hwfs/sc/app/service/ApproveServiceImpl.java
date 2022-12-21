package com.hwfs.sc.app.service;

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
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.app.dao.ApproveDAO;
import com.hwfs.sc.cmn.util.StringUtil;

 /**
 * 식재앱 승인신청 인터페이스용  ServiceImpl에 대한 설명 작성
 * @ClassName ApproveServiceImpl.java
 * @Description ApproveServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.09.08.  구승모        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.09.08.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class ApproveServiceImpl extends DefaultServiceImpl implements ApproveService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name="/sc/app/approveDAO")
	private ApproveDAO approveDAO;

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
	@CustomAnnotationDefinition(txId="IF_APPROVE_SERVICE",Description="식재앱 승인신청 인터페이스용 Service")
	public JSONObject callService(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {

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

		//승인신청 코드조회
		if(txDiv.equals("SelectApproveCode")){
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = approveDAO.selectApproveType(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "승인신청 코드 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0)
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "승인신청 코드 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
					//추가발주 사유1
					rs = null;
					rsArray = null;
					rs = approveDAO.selectApproveReason1(parameter);
					rsArray = new JSONArray(rs);					
					procResult.put("resultData2", rsArray.toString());
					
					//추가발주 사유2
					rs = null;
					rsArray = null;
					rs = approveDAO.selectApproveReason2(parameter);
					rsArray = new JSONArray(rs);					
					procResult.put("resultData3", rsArray.toString());
				}
			}
		}

		else if(txDiv.equals("SaveApproveInfo")){
			try {
				int procCnt = 0; //처리건수
				RecordSet rs1 = null; //유효성 체크
				
				sParamString = txData.getString("data");
				JSONObject txParam = new JSONObject(sParamString);
				parameter = toMap(txParam);
				
		        if ("000".equals(parameter.get("gubun").toString())) { // 추가발주 기존 신청건 존재여부 체크
		        	rs1 = approveDAO.saveChk001(parameter);
					
		        	if(rs1.size() > 0){
		        		throw new Exception("기존 신청건이 존재합니다. " + rs1.get(0).getString("startDate") + " - " + rs1.get(0).getString("endDate"));
		        	}
		        	
			        approveDAO.saveApprove001(parameter);
		        } else { //수정 시 팀장마감승인 여부 체크
		        	rs1 = approveDAO.saveChk002(parameter);
		        	
		        	if(rs1.size() > 0){
		        		throw new Exception("이미 팀장마감승인 되었습니다.");
		        	}
		        	
			        approveDAO.saveApprove002(parameter);
		        }
		
				procCnt++;
				
				logger.debug(">>>>>>>>>>>>>> 승인신청 완료");
				
				procResult.put("resultData", "");
				procResult.put("resultCount", procCnt);
			} catch (Exception e) {
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", e.getMessage());    		
			}
		}
		
		//승인신청 등록내역 조회
		else if(txDiv.equals("SelectApproveList"))
		{
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			//구분값이 ALL인경우 콤마로 넘어옴
			parameter.put("strGubun", StringUtil.getWhereInQuery(parameter.get("gubun").toString()));
			
			rs = approveDAO.selectApproveList(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "승인신청 등록내역 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				JSONArray rsArray = new JSONArray(rs);
				
				procResult.put("resultData", rsArray.toString());
				procResult.put("resultCount", rs.size());
			}							
		}
		
		else if(txDiv.equals("SaveTlApproveInfo")){
			try {
				int procCnt = 0; //처리건수
				RecordSet rs1 = null; //유효성 체크
				
				boolean bOK = true;
				
				JSONArray datas = txData.getJSONArray("datas");
				
				if (bOK)
				{
	    			for (int i=0 ; i < datas.length() ; i++) {
						Map<String, Object> rowData = new HashMap<String, Object>();
				        
						rowData.put("upjangCd", chkIsNull(datas,i,"upjangCd"));
						rowData.put("gubun", chkIsNull(datas,i,"gubun"));
						rowData.put("reqId", chkIsNull(datas,i,"reqId"));
						rowData.put("startDt", chkIsNull(datas,i,"startDt"));
						rowData.put("endDt", chkIsNull(datas,i,"endDt"));
						rowData.put("prDate", chkIsNull(datas,i,"prDate"));
						rowData.put("sabun", chkIsNull(datas,i,"sabun"));
						rowData.put("clsGubn", chkIsNull(datas,i,"clsGubn"));

						if ("000".equals(chkIsNull(datas,i,"gubun"))) { // 팀장마감승인 여부 체크
							rs1 = approveDAO.saveTlChk001(rowData);
							
							if(rs1.size() > 0){
								throw new Exception("이미 팀장승인 되었습니다.");
							}
							
							approveDAO.saveTlApprove001(rowData);
						} else { // 팀장마감승인 여부 체크
							rs1 = approveDAO.saveChk002(rowData);
							
							if(rs1.size() > 0){
								throw new Exception("이미 팀장승인 되었습니다.");
							}
							
							approveDAO.saveTlApprove002(rowData);
							
							if("Y".equals(chkIsNull(datas,i,"clsGubn")))
							{
								//MAS_CLOSE_MGMT Delete처리
								approveDAO.deleteTlApprove002(rowData);
							}
						}
						
						procCnt++;
	    			}
				}

				logger.debug(">>>>>>>>>>>>>> 팀장승인 완료");
				
				procResult.put("resultData", "");
				procResult.put("resultCount", procCnt);
			} catch (Exception e) {
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", e.getMessage());    		
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

		//로그저장start
		int insLogCnt = 0;
		String tHeader = "";
		String tData = "";
		String tResult = "";
		tHeader = txHeader.toString();
		tData = txData.toString();
		tResult = result.getJSONObject("data").toString();
		parameter.put("txId", txHeader.getString("txId"));
		parameter.put("txDiv", txDiv);
		parameter.put("tHeader", tHeader);
		parameter.put("tData", tData);
		parameter.put("tResult", tResult);
		insLogCnt += approveDAO.logInsert(parameter);
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
