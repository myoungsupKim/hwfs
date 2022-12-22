package com.hwfs.sc.cmn.service;

import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.cmn.dao.ExternalVanApprvIFDAO;
import com.hwfs.sc.cmn.util.StringUtil;

 /**
 * ExternalVanApprvIFServiceImpl에 대한 설명 작성
 * @ClassName ExternalVanApprvIFServiceImpl.java
 * @Description ExternalVanApprvIFServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.01.03.  김명섭        최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2019.01.03.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class ExternalVanApprvIFServiceImpl extends DefaultServiceImpl implements ExternalVanApprvIFService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name="/sc/cmn/ExternalVanApprvIFDAO")
	private ExternalVanApprvIFDAO ExternalVanApprvIFDAO;
	
	/**
	 * saveData 설명
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
	@CustomAnnotationDefinition(txId="IF_HWHNRF_C001",Description="VAN 승인내역 인터페이스용 Service")
	public JSONObject saveData(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {
		
		JSONObject processResult = new JSONObject();
		JSONObject result = new JSONObject();
		int insRow = 0;
		int dupRow = 0;

    	try
    	{

    		String txDiv = (String) txHeader.get("txDiv");
    		
    		if(isNull(txDiv)){
    			processResult.put("ErrorCode", -1);
    			processResult.put("ErrorMsg", "txDiv는 필수 입니다.");
    			result.put("data", processResult);
    			return result;
    		}
    		
    		//FDK데이터저장
    		if("FDK".equals(txDiv)){
    			
    			JSONArray datas = txData.getJSONArray("datas"); //KEY로 사용한 datas는 약속된 KEY로써 변경하지 마세요.

    			for (int i=0 ; i < datas.length() ; i++) {
    				if(isNull(datas.getJSONObject(i).getString("trml_no"))){
    					processResult.put("ErrorCode", -2);
    					processResult.put("ErrorMsg", "단말기ID는 필수 입니다.");
    					result.put("data", processResult);
    					return result;
    				}
    				if(!isDate(datas.getJSONObject(i).getString("run_date"))){
    					processResult.put("ErrorCode", -2);
    					processResult.put("ErrorMsg", "거래일자 날짜형식이 바르지 않습니다.(YYYYMMDD)");
    					result.put("data", processResult);
    					return result;
    				}			
    			}

    			for (int i=0 ; i < datas.length() ; i++) {
    				Map<String, Object> rowData = new HashMap<String, Object>();		

    				rowData.put("trml_no", StringUtil.trimStr(chkIsNull(datas,i,"trml_no"))); 
    		        rowData.put("auth_gubun", StringUtil.trimStr(chkIsNull(datas,i,"auth_gubun")));  
    		        rowData.put("card_num", StringUtil.trimStr(chkIsNull(datas,i,"card_num")));
    		        rowData.put("issue_code", StringUtil.trimStr(chkIsNull(datas,i,"issue_code")));
    		        rowData.put("entry_code", StringUtil.trimStr(chkIsNull(datas,i,"entry_code")));
    		        rowData.put("exp_date", StringUtil.trimStr(chkIsNull(datas,i,"exp_date")));
    		        rowData.put("run_date", StringUtil.trimStr(chkIsNull(datas,i,"run_date")));
    		        rowData.put("run_time", StringUtil.trimStr(chkIsNull(datas,i,"run_time")));
    		        rowData.put("run_hal", StringUtil.trimStr(chkIsNull(datas,i,"run_hal")));
    		        if(chkIsNull(datas,i,"auth_gubun").equals("R")) {
        		        rowData.put("auth_amt", StringUtil.trimStr("-" + chkIsNull(datas,i,"auth_amt")));    		        	
    		        }else{
        		        rowData.put("auth_amt", chkIsNull(datas,i,"auth_amt"));
    		        }
    		        rowData.put("auth_no", StringUtil.trimStr(chkIsNull(datas,i,"auth_no")));
    		        rowData.put("busi_no", StringUtil.trimStr(chkIsNull(datas,i,"busi_no")));
    		        rowData.put("merch_num", StringUtil.trimStr(chkIsNull(datas,i,"merch_num")));
    		        rowData.put("merch_name", StringUtil.trimStr(chkIsNull(datas,i,"merch_name")));
    		        rowData.put("bank_code", StringUtil.trimStr(chkIsNull(datas,i,"bank_code")));
    		        rowData.put("bank_saup", StringUtil.trimStr(chkIsNull(datas,i,"bank_saup")));
    		        rowData.put("recd_stat", "I");
    		        rowData.put("create_by", "IF_VAN_INFO");
    		        rowData.put("brch_cd", StringUtil.trimStr(chkIsNull(datas,i,"brch_cd")));
    		        //rowData.put("brch_cd", "001");

    		        if(isDupData(rowData)){
    		        	dupRow += 1;
    		        }else{
        		        insRow += ExternalVanApprvIFDAO.insert(rowData);
    		        }
    			}
    			
    		} //if("FDK".equals(txDiv))

    		//전달하고자하는 메시지등을 기술한다.
    		processResult.put("procCount", insRow);
    		processResult.put("dupCount", dupRow);
    		
    	}
    	catch (Exception e)
    	{
    		//전달하고자하는 메시지등을 기술한다.
    		processResult.put("ErrorCode", -9);
    		processResult.put("ErrorMsg", "저장 중 오류가 발생했습니다.");
    	}
		
		result.put("data", processResult);

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

	/**
	 * 중복데이터체크
	 *
	 * @param data
	 * @return
	 */
	public boolean isDupData(Map rowData) throws Exception{
		int dupcnt = ExternalVanApprvIFDAO.dupcnt(rowData);
		if(dupcnt > 0)return true;
		return false;
	}	
}
