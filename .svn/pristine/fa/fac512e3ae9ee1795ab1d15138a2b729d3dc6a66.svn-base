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
import com.hwfs.sc.app.dao.TransactionDAO;

 /**
 * 식재앱 입금매입매출 인터페이스용  ServiceImpl에 대한 설명 작성
 * @ClassName TransactionServiceImpl.java
 * @Description TransactionServiceImpl Class 
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
public class TransactionServiceImpl extends DefaultServiceImpl implements TransactionService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name="/sc/app/transactionDAO")
	private TransactionDAO transactionDAO;

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
	@CustomAnnotationDefinition(txId="IF_TRANSACTION_SERVICE",Description="식재앱 입금매입매출 인터페이스용 Service")
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

		//입금내역 조회
		if(txDiv.equals("SelectDepositInfo")){
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = transactionDAO.selectDepositInfo(parameter);

			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "입금내역 조회 중 오류가 발생했습니다.");
				
			} else {
				rs = removeNull(rs);

				if(rs.size() == 0)
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "조회된 내역이 없습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
				}
			}
		}

		//매출실적 조회
		else if(txDiv.equals("SelectCreditInfo"))
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = transactionDAO.selectCreditInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "매출실적조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				JSONArray rsArray = new JSONArray(rs);
				
				procResult.put("resultData", rsArray.toString());
				procResult.put("resultCount", rs.size());
			}							
		}
		
		//기본여신 조회
		else if(txDiv.equals("SelectDefaultCreditInfo"))
		{
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = transactionDAO.selectDefaultCreditInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "기본여신조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				JSONArray rsArray = new JSONArray(rs);
				
				procResult.put("resultData", rsArray.toString());
				procResult.put("resultCount", rs.size());
			}							
		}
		
		//매출액재료비 조회
		else if(txDiv.equals("SelectProfitandlossInfo"))
		{
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = transactionDAO.selectProfitandlossInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "매출액재료비조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				JSONArray rsArray = new JSONArray(rs);
				
				procResult.put("resultData", rsArray.toString());
				procResult.put("resultCount", rs.size());
			}
		}
		
		//입고현황 조회
		else if(txDiv.equals("SelectTransactionInfo"))
		{
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = transactionDAO.selectTransactionInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "입고현황조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				JSONArray rsArray = new JSONArray(rs);
				
				procResult.put("resultData", rsArray.toString());
				procResult.put("resultCount", rs.size());
			}							

		}
		
		//입고현황상세 조회
		else if(txDiv.equals("SelectTransactionDetailInfo"))
		{
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = transactionDAO.selectTransactionDetailInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "입고현황상세조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				JSONArray rsArray = new JSONArray(rs);
				
				procResult.put("resultData", rsArray.toString());
				procResult.put("resultCount", rs.size());
			}							

		}
		
//		//임시여신 신청
//		else if(txDiv.equals("SaveCreditOver")){
//			try {
//				int procCnt = 0; //처리건수
//				RecordSet rs1 = null; //유효성 체크
//				
//				sParamString = txData.getString("data");
//				JSONObject txParam = new JSONObject(sParamString);
//				parameter = toMap(txParam);
//				
//				rs1 = creditOverDAO.selectCreditOverReqYn(parameter);
//				
//				if(rs1.size() > 0){
//					throw processException("미승인건이 존재합니다.");
//				}
//
//				creditOverDAO.saveCreditOver(parameter);
//				
//				procCnt++;
//				
//				logger.debug(">>>>>>>>>>>>>> 임시여신 신청 완료");
//				
//				procResult.put("resultData", "");
//				procResult.put("resultCount", procCnt);
//			} catch (Exception e) {
//				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
//				procResult.put("resultData", "");
//				procResult.put("resultCount", 0);
//				procResult.put("ErrorCode", -1); //오류
//				procResult.put("ErrorMsg", e.getMessage());    		
//			}
//			
//		}
//		
//		//임시여신 승인
//		else if(txDiv.equals("SaveCreditOverApprv")){
//			try {
//				int procCnt = 0; //처리건수
//				RecordSet rs1 = null; //유효성 체크
//				
//				sParamString = txData.getString("data");
//				JSONObject txParam = new JSONObject(sParamString);
//				parameter = toMap(txParam);
//				
//				rs1 = creditOverDAO.selectCreditOverApprvYn(parameter);
//				String apprYn = (String) rs1.get(0).get("apprYn");
//				
//				if(LimsUtil.checkNull(apprYn).equals("Y")){
//					throw processException("승인된 건입니다.");
//				} 
//				if(LimsUtil.checkNull(apprYn).equals("C")){
//					throw processException("반려된 건입니다.");
//				}	
//
//				creditOverDAO.saveCreditOverApprv1(parameter);
//				creditOverDAO.saveCreditOverApprv2(parameter);
//				
//				procCnt++;
//				
//				logger.debug(">>>>>>>>>>>>>> 임시여신 승인 완료");
//				
//				procResult.put("resultData", "");
//				procResult.put("resultCount", procCnt);
//			} catch (Exception e) {
//				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
//				procResult.put("resultData", "");
//				procResult.put("resultCount", 0);
//				procResult.put("ErrorCode", -1); //오류
//				procResult.put("ErrorMsg", e.getMessage());    		
//			}
//			
//		}
//
//		//임시여신 반려
//		else if(txDiv.equals("SaveCreditOverReject")){
//			try {
//				int procCnt = 0; //처리건수
//				RecordSet rs1 = null; //유효성 체크
//				
//				sParamString = txData.getString("data");
//				JSONObject txParam = new JSONObject(sParamString);
//				parameter = toMap(txParam);
//				
//				rs1 = creditOverDAO.selectCreditOverApprvYn(parameter);
//				String apprYn = (String) rs1.get(0).get("apprYn");
//				
//				if(LimsUtil.checkNull(apprYn).equals("Y")){
//					throw processException("승인된 건입니다.");
//				} 
//				if(LimsUtil.checkNull(apprYn).equals("C")){
//					throw processException("반려된 건입니다.");
//				}	
//
//				creditOverDAO.saveCreditOverReject(parameter);
//				
//				procCnt++;
//				
//				logger.debug(">>>>>>>>>>>>>> 임시여신 반려 완료");
//				
//				procResult.put("resultData", "");
//				procResult.put("resultCount", procCnt);
//			} catch (Exception e) {
//				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
//				procResult.put("resultData", "");
//				procResult.put("resultCount", 0);
//				procResult.put("ErrorCode", -1); //오류
//				procResult.put("ErrorMsg", e.getMessage());    		
//			}
//			
//		}		
		
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
		insLogCnt += transactionDAO.logInsert(parameter);
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
