package test;

import hone.hanwha.JSonSimpleAdaptor.Client.JSonClient;

import org.json.JSONArray;
import org.json.JSONObject;

import com.hwfs.cmn.crypto.aria.ARIAUtil;

 /**
 * TestJsonClient
 * @ClassName TestJsonClient.java
 * @Description TestJsonClient Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.19.   lsjmanse      최초생성
 *  2015.03.25.   kksoo         프로젝트에 맞게 조정
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 3. 25.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class TestJsonClient {

	/**
	 * Json 서비스 요청 main 기능 설명
	 *
	 * @param args
	 */
	public static void main(String[] args) {
		jsonClient ();
	}

	/**
	 * jsonClient 테스트
	 */
	private static void jsonClient () {
		JSonClient js = new JSonClient();
        
		try {
			String endPointUrl= "http://localhost:8080/sc/cmn/jsonCommon.jDo";
			JSONObject txHeader = new JSONObject();
			JSONObject txData = new JSONObject();
			JSONObject txResult = new JSONObject();
			
			//암호화 통신 설정
            boolean encYn = false;				//암호화 통신 여부
            String ariaKey = "hwfsjson2014";	//Aria Key
            ARIAUtil ariaUtil = null;			//Aria Utility
            
			//서비스 헤더 설정
			txHeader.put("txId", "IF_SALE_INQ");	//(필수)서비스 IF ID
			txHeader.put("salesDt", "20150320");	//영업일자 : POS에 맞게 설정
			txHeader.put("encoding", "utf-8");		//(필수)char encoding
			
			//(옵션)서비스 요청 데이터 설정 : 파라미터 또는 데이터로 사용
			if (encYn){
				txHeader.put("encYn", encYn);		//(옵션)암호화 여부
				ariaUtil = new ARIAUtil (ariaKey);
				JSONObject txDataEnc = new JSONObject();
				txDataEnc.put("posVer", "데이터...");
				txData.put("encData", ariaUtil.encrypt(txDataEnc.toString()));	//암호화하여 전송
			}else{
				txData.put("posVer", "데이터...");
				//Array 전송 시
				JSONArray jsonArr = new JSONArray();
				jsonArr.put(0, "ARR0");
				jsonArr.put(1, "ARR1");
				jsonArr.put(2, "ARR2");
				txData.put("jsonArr", jsonArr.toString());
			}
            
			//서비스 호출
			JSONObject txReturn = js.RemoteCallJSon(endPointUrl, txHeader, txData, txResult);
            
			//결과 처리			
			System.out.println("***********" + txReturn.toString());
			txResult = (JSONObject) txReturn.get("txResult");
			System.out.println("resultCode  : " + txResult.getInt("resultCode"));
			System.out.println("resultCode  : " + txResult.getInt("resultCode"));
			if (txResult.getInt("resultCode") >= 0) {
				//결과 데이터 처리
				if (encYn) {
					String encData = txReturn.get("txData").toString();	
					txData = new JSONObject(ariaUtil.decrypt(encData));	//복호화하여 처리
				}else{
					txData = txReturn.getJSONObject("txData");					
				}
				System.out.println("***********" + txData.toString());
			}else{
				System.out.println ("*********오류메시지=" + txResult.get("resultMessage"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
}
