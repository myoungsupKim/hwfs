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
import com.hwfs.cmn.util.RequestContextUtil;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.app.dao.InventoryDAO;

 /**
 * 식재앱 재고조회 인터페이스용  ServiceImpl에 대한 설명 작성
 * @ClassName InventoryServiceImpl.java
 * @Description InventoryServiceImpl Class 
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
public class InventoryServiceImpl extends DefaultServiceImpl implements InventoryService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name="/sc/app/inventoryDAO")
	private InventoryDAO inventoryDAO;

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
	@CustomAnnotationDefinition(txId="IF_INVENTORY_SERVICE",Description="식재앱 재고조회 인터페이스용 Service")
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

		//물류센터정보조회
		if(txDiv.equals("SelectCenterInfo")){
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = inventoryDAO.selectCenterInfo(parameter);

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
		
		//재고조회
		else if(txDiv.equals("SelectInventoryInfo"))
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			String strCode = parameter.get("centerCode").toString();
			String strText = parameter.get("searchText").toString();
			
			//데이터오류
			if(strCode.equals("") || strText.equals(""))
			{
				procResult.put("resultCount", 0);
				procResult.put("ErrorCode", -9); //오류
				procResult.put("ErrorMsg", "검색조건 데이터가 올바르지 않습니다.");
			}
			
			else
				
			{
				rs = inventoryDAO.selectInventoryInfo(parameter);
				
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
			
		}

		//사업장관리자재조회
		else if(txDiv.equals("UpjangInventoryInfo"))
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			boolean bOK = true;
			
			Map<String, Object> inParam = new HashMap<String, Object>();
			Map<String, Object> retVal = new HashMap<String, Object>();				
			String callProcName = "APP_UPJANG_INVENTORY_CHK_PRO";

			inParam.put("P_UPJANG_CODE", parameter.get("upjangCd"));
			inParam.put("P_SUBINV_CODE", parameter.get("subinvCode"));
			inParam.put("P_REQ_DATE", parameter.get("reqDate"));
			
			retVal = inventoryDAO.callAppUpjangProcedure(inParam, callProcName);

			//사전체크
			if("FALSE".equals(retVal.get("O_RTN").toString())){
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", retVal.get("O_RTNMSG").toString());
			}
			else {
				parameter.put("sOnhandMonth", retVal.get("O_CLSYYMM").toString());
				parameter.put("sPhysicBdt", retVal.get("O_PHYSICBDT").toString());
				parameter.put("subinvGubun", parameter.get("subinvCode").toString().substring(0, 1));
			//	parameter.put("sOnhandMonth", "202207");
			//	parameter.put("sPhysicBdt", "20220819");
				
				rs = inventoryDAO.upjangInventoryInfo(parameter);

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
			
		}

		//재고등록임시저장
		else if(txDiv.equals("SaveInventoryInfo"))
		{
			String strupjangCd = txHeader.getString("upjangCd");     //업장코드
			String strsubinvCode = txHeader.getString("subinvCode"); //창고코드
			String strreqDate = txHeader.getString("reqDate");       //등록일
			String strchkPoUom = txHeader.getString("chkPoUom");     //등록기준1(수불단위:1,구매단위:2)
			String struserId = txHeader.getString("userId");         //등록자
			String strstatus = txHeader.getString("status");         //등록상태(임시저장:T,재고실사:I)
			
			Map<String, Object> inParam = new HashMap<String, Object>();
			Map<String, Object> retVal = new HashMap<String, Object>();				
			String callProcName = "APP_SAVE_INVENTORY_CHK_PRO";

			inParam.put("P_UPJANG_CODE", strupjangCd);
			inParam.put("P_SUBINV_CODE", strsubinvCode);
			inParam.put("P_REQ_DATE", strreqDate);
			inParam.put("P_STATS", strstatus);
			
			retVal = inventoryDAO.callAppSaveChkProcedure(inParam, callProcName);
			
			//저장체크
			if("FALSE".equals(retVal.get("O_RTN").toString())){
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", retVal.get("O_RTNMSG").toString());
			}
			else {
				int procCnt = 0; //처리건수
				JSONArray datas = txData.getJSONArray("datas");
				
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);

				//재고실사그룹키
				String sGrpCd = retVal.get("O_GRPCD").toString();
				
				Map<String, Object> inParam2 = new HashMap<String, Object>();
				Map<String, Object> retVal2 = new HashMap<String, Object>();				
				String callProcName2 = "APP_SAVE_INVENTORY_PRO";

				for (int i=0 ; i < datas.length() ; i++) {
    				inParam2.put("P_UPJANG_CODE", strupjangCd);
    				inParam2.put("P_SUBINV_CODE", strsubinvCode);
    				inParam2.put("P_REQ_DATE", strreqDate);
    				inParam2.put("P_PO_UOM", strchkPoUom);
    				inParam2.put("P_STATS", strstatus);
    				inParam2.put("P_GRP_CD", sGrpCd);
    				inParam2.put("P_ITEM_CODE", chkIsNull(datas,i,"itemCode"));
    				inParam2.put("P_UOM_CONVERT_RATE", chkIsNull(datas,i,"uomConvertRate"));
    				inParam2.put("P_M_STK_QTY", chkIsNull(datas,i,"mStkQty"));
    				inParam2.put("P_M_STK_QTY_ORG", chkIsNull(datas,i,"mStkQtyOrg"));
    				inParam2.put("P_U_STK_PRICE", chkIsNull(datas,i,"uStkPrice"));
    				inParam2.put("P_M_STK_PRICE", chkIsNull(datas,i,"mStkPrice"));
    				inParam2.put("P_M_REAL_QTY", chkIsNull(datas,i,"mRealQty"));
    				inParam2.put("P_M_USE_QTY", chkIsNull(datas,i,"mUseQty"));
    				inParam2.put("P_U_STK_AMT", chkIsNull(datas,i,"uStkAmt"));
    				inParam2.put("P_M_STK_AMT", chkIsNull(datas,i,"mStkAmt"));
    				inParam2.put("P_U_USE_AMT", chkIsNull(datas,i,"uUseAmt"));
    				inParam2.put("P_M_USE_AMT", chkIsNull(datas,i,"mUseAmt"));
    				inParam2.put("P_VALUE_DATE_INFO", chkIsNull(datas,i,"valueDateInfo"));
    				inParam2.put("P_VALUE_DATE", chkIsNull(datas,i,"valueDate"));
    				inParam2.put("P_MAKER_DATE", chkIsNull(datas,i,"makerDate"));
    				inParam2.put("P_TAX_CODE", chkIsNull(datas,i,"taxCode"));
    				inParam2.put("P_USER_ID", struserId);
    				
    				retVal2 = inventoryDAO.callAppSaveProcedure(inParam2, callProcName2);
    				
    				if("FALSE".equals(retVal2.get("O_RTN").toString())){
    					procResult.put("resultData", "");
    					procResult.put("resultCount", 0);
    					procResult.put("ErrorCode", -2); //오류
    					procResult.put("ErrorMsg", retVal.get("O_RTNMSG").toString());
    				}
    				
					procCnt += 1;
    			}
				
				//구매재고실사call
				if("I".equals(strstatus) && procCnt > 0){
    				inParam2.put("P_STATS", "E");
    				inParam2.put("P_GRP_CD", sGrpCd);
    				inParam2.put("P_USER_ID", struserId);

    				retVal2 = inventoryDAO.callAppSaveProcedure(inParam2, callProcName2);
    				
    				if("FALSE".equals(retVal2.get("O_RTN").toString())){
    					procResult.put("resultData", "");
    					procResult.put("resultCount", 0);
    					procResult.put("ErrorCode", -3); //오류
    					procResult.put("ErrorMsg", retVal.get("O_RTNMSG").toString());
    				}
				}
    			procResult.put("resultData", "");
    			procResult.put("resultCount", procCnt);	
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
		insLogCnt += inventoryDAO.logInsert(parameter);
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
