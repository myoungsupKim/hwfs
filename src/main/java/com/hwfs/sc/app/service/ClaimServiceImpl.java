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

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.app.dao.ClaimDAO;
import com.hwfs.sc.cmn.util.StringUtil;

 /**
 * 식재앱 클레임관리 인터페이스용  ServiceImpl에 대한 설명 작성
 * @ClassName ClaimServiceImpl.java
 * @Description ClaimServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.09.05.  김명섭        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.09.05.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class ClaimServiceImpl extends DefaultServiceImpl implements ClaimService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name="/sc/app/claimDAO")
	private ClaimDAO claimDAO;

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
	@CustomAnnotationDefinition(txId="IF_CLAIM_SERVICE",Description="식재앱 클레임관리 인터페이스용 Service")
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

		//창고정보조회
		if(txDiv.equals("SelectSubinv")){
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = claimDAO.selectSubinv(parameter);

			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "공통코드 조회 중 오류가 발생했습니다.");
				
			} else {
				
				rs = removeNull(rs);
				
				if(rs.size() == 0)
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "공통코드가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
				}				
			}
			
		}
		
		//발주내역조회
		else if(txDiv.equals("SelectClaimReqInfo"))
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = claimDAO.selectClaimReqInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				JSONArray rsArray = new JSONArray(rs);
				
				procResult.put("resultData", rsArray.toString());
				procResult.put("resultCount", rs.size());
			}							

		}
		
		//클레임이미지조회
		else if(txDiv.equals("SelectClaimImg"))
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = claimDAO.selectClaimImg(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				JSONArray rsArray = new JSONArray(rs);
				
				procResult.put("resultData", rsArray.toString());
				procResult.put("resultCount", rs.size());
			}							

		}

		//클레임신청및취소
		else if(txDiv.equals("SaveClaimInfo"))
		{
			int procCnt = 0; //처리건수
			int delRowCnt = 0;

			boolean bOK = true;
			
			JSONArray datas = txData.getJSONArray("datas");
			
			procResult.put("resultData", "");
			procResult.put("resultCount", 0);

			for (int i=0 ; i < datas.length() ; i++) {
				
				JSONObject txParam = datas.getJSONObject(i);
				parameter = toMap(txParam);
				
				//클레임신청 체크
				if ("01".equals(parameter.get("prcsStatus"))){
					
					bOK = true;
					
					int claimYn = claimDAO.claiminsertYn(parameter);
					if(claimYn > 0){
						procResult.put("resultData", "");
						procResult.put("resultCount", 0);
						procResult.put("ErrorCode", -1); //오류
						procResult.put("ErrorMsg", "이미 등록된 주문건 입니다. 재조회 후 요청해 주세요.");
						bOK = false;
					}
					
					String flag = claimDAO.ticketFlag(parameter);
					if(!"TRUE".equals(flag)){
						procResult.put("resultData", "");
						procResult.put("resultCount", 0);
						procResult.put("ErrorCode", -1); //오류
						procResult.put("ErrorMsg", "매출 또는 선수금 등록 건이 있어 식권 전량폐기가 불가능 합니다.");
						bOK = false;
					}
					
					if (bOK){
						if ( "Y".equals(parameter.get("wmCancelYn")) && "C05002".equals(parameter.get("claimKind"))) {
							parameter.put("prcsStatus", "09");	// 센터 재고부족으로 발주취소된 경우
						}
						procCnt += claimDAO.saveClaim(parameter);
					}else{
						break;
					}
					procResult.put("resultData", "");
					procResult.put("resultCount", procCnt);
				}

				//클레임취소 체크
				else if ("08".equals(parameter.get("prcsStatus"))){
					
					bOK = true;
					
					String procStatus = claimDAO.claimStatus(parameter);//상태값 재 조회
					if(!"01".equals(procStatus)){
						procResult.put("resultData", "");
						procResult.put("resultCount", 0);
						procResult.put("ErrorCode", -1); //오류
						procResult.put("ErrorMsg", "처리상태를 확인해 주세요.");
						bOK = false;//요청이 아닐경우.
					}

					if (bOK){
						//클레임취소시 등록이미지 모두 삭제
						parameter.put("strRefSeq", StringUtil.getWhereInQuery(parameter.get("refSeq").toString()));
						
						procCnt += claimDAO.claimHistorySave(parameter);//히스토리 저장
						delRowCnt += claimDAO.deleteClaim(parameter);//클레임 삭제
						delRowCnt += claimDAO.appendFileDelete(parameter);//첨부파일 삭제
						delRowCnt += claimDAO.deleteClaimImgP(parameter);//클레임 이미지 삭제(PC)
						delRowCnt += claimDAO.deleteClaimImgM(parameter);//클레임 이미지 삭제(모바일)
					}else{
						break;
					}
					procResult.put("resultData", "");
					procResult.put("resultCount", procCnt);
					
				}else{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "클레임처리구분이 올바르지 않습니다.");
				}
			}
		}

		//클레임이미지등록및삭제(이미지업로드후)
		else if(txDiv.equals("ClaimImgSave"))
		{
			int procCnt = 0; //처리건수
			
			boolean bOK = true;
			
			JSONArray datas = txData.getJSONArray("datas");
			
			procResult.put("resultData", "");
			procResult.put("resultCount", 0);

			for (int i=0 ; i < datas.length() ; i++) {
				
				JSONObject txParam = datas.getJSONObject(i);
				parameter = toMap(txParam);
				
				//등록
				if ("I".equals(parameter.get("procGubun"))){
					procCnt += claimDAO.claimImgSave(parameter);
				}
				//삭제
				else if ("D".equals(parameter.get("procGubun"))){
					parameter.put("strRefSeq", StringUtil.getWhereInQuery(parameter.get("refSeq").toString()));
					//클레임이미지 삭제시 모바일이미지 삭제
					//procCnt += claimDAO.appendFileDelete(parameter);//첨부파일 삭제
					//procCnt += claimDAO.deleteClaimImgP(parameter);//클레임 이미지 삭제(PC)
					procCnt += claimDAO.deleteClaimImgM(parameter);//클레임 이미지 삭제(모바일)
				}
				else{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "처리구분이 올바르지 않습니다.");
				}
			}
			procResult.put("resultData", "");
			procResult.put("resultCount", procCnt);
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
		insLogCnt += claimDAO.logInsert(parameter);
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
