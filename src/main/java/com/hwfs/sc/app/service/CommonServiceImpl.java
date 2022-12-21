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
import com.hwfs.sc.app.dao.CommonDAO;
import com.hwfs.sc.cmn.dto.SmsDTO;
import com.hwfs.sc.cmn.service.SmsSendService;

 /**
 * 식재앱 공통 인터페이스용  ServiceImpl에 대한 설명 작성
 * @ClassName CommonServiceImpl.java
 * @Description CommonServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.06.20.  김명섭        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.06.20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class CommonServiceImpl extends DefaultServiceImpl implements CommonService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name="/sc/app/commonDAO")
	private CommonDAO commonDAO;

	/** SmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/smsSendService")
	private SmsSendService smsSendService;

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
	@CustomAnnotationDefinition(txId="IF_COMMON_SERVICE",Description="식재앱 공통 인터페이스용 Service")
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

		//공통코드조회
		if(txDiv.equals("SelectCommonCode")){
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = commonDAO.selectCommonCode(parameter);

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
		
		//동의어조회
		else if(txDiv.equals("SelectSameText"))
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = commonDAO.selectSameText(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "동의어 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0)
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "동의어정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
				}
			}			
			
		}

		//문자발송(푸시알림미수신대상자)
		else if(txDiv.equals("SmsSend"))
		{
			int procCnt = 0; //처리건수

			boolean bOK = true;
			
			JSONArray datas = txData.getJSONArray("datas");
			
			procResult.put("resultData", "");
			procResult.put("resultCount", 0);

			for (int i=0 ; i < datas.length() ; i++) {
				if(isNull(datas.getJSONObject(i).getString("recvCellNum"))){
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "수신자 전화번호가 없는 데이터가 존재합니다.");
					bOK = false;
					break;
				}
				if(isNull(datas.getJSONObject(i).getString("sendMsg"))){
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "전송 메세지가 없는 데이터가 존재합니다.");
					bOK = false;
					break;
				}
				if(isNull(datas.getJSONObject(i).getString("sabun"))){
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "사번정보 없는 데이터가 존재합니다.");
					bOK = false;
					break;
				}
			}
			
			if (bOK)
			{
				
				String strCallbackNum = propertiesService.getString("ems.sms.callback.no", "");
				String strCcId = propertiesService.getString("ems.sms.cmn.send.deptId", "");

				for (int i=0 ; i < datas.length() ; i++) {
    				
    				//SMS 발송
					SmsDTO smsDTO = new SmsDTO();
    				smsDTO.setTrPhone(chkIsNull(datas,i,"recvCellNum"));	//수신자 전화번호
    				smsDTO.setTrMsg(chkIsNull(datas,i,"sendMsg"));			//전송 메시지
    				
    				//송신자번호가 없는 경우는 기본 전화번호로 설정한다.
    				smsDTO.setTrCallback(strCallbackNum);
    				
    				//전송할 시간(YYYYMMDD HH24MI) : 값이 없으면 현재 시간
    				if (!chkIsNull(datas,i,"sendDate").equals("")){
        				smsDTO.setTrSendDate(chkIsNull(datas,i,"sendDate"));
    				}
    				
    				smsDTO.setTrCcId(strCcId);								//시스템공통에서 보내는 메시지에 대한 부서 설정
    				smsDTO.setTrUserId(chkIsNull(datas,i,"sabun"));			//당사자 사번
    				smsDTO.setTrCustNo("");									//해당 사항 없음
    				
    				//SMS 전송
    				smsSendService.saveSms(smsDTO);
    				
    				procCnt += 1;

    			}

			}

			procResult.put("resultData", "");
			procResult.put("resultCount", procCnt);
		}
		
		//공지사항조회
		else if(txDiv.equals("SelectBbsInfo"))
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = commonDAO.SelectBbsInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "공지사항 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0)
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "공지사항이 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
				}
			}			
			
		}
		
		//시스템작업일시조회
		else if(txDiv.equals("SelectConstruction"))
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = commonDAO.selectConstruction(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "시스템작업일시 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0)
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "시스템작업일시정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
				}
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
		insLogCnt += commonDAO.logInsert(parameter);
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
