package com.hwfs.sc.cmn.web;

import hone.hanwha.CustomAnnotaion.CustomAnnotationHandler;
import hone.hanwha.CustomAnnotaion.ServiceMethod;

import java.util.Date;
import java.util.Map;

import org.apache.commons.lang.time.FastDateFormat;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ReflectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.crypto.aria.ARIAUtil;
import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.exception.BizException;

 /**
 * 공통 json 처리 Controller
 * <pre>
 * - POS 등의 외부 연동 json 공통 콘트롤러
 * - [중요]개발자는 컨트롤러를 만들지 않는다.
 * </pre>
 * @ClassName JsonCommonController.java
 * @Description JsonCommonController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.19.   lsjmanse      최초생성
 *  2015.03.25.   kksoo         프로젝트에 맞게 조정 (개인정보보호 요건, 보안, 취약점 처리 등)
 * </pre>
 * @author 
 * @since 2015. 03. 19.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
public class JsonCommonController extends DefaultController {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** CustomAnnotationHandler Service */
    @Autowired
    private CustomAnnotationHandler caHandler;

    /**
	 * json요청을 처리한다.
	 * <pre>
	 * - POS 등의 외부 연동 json 공통 콘트롤러
	 * - [중요]개발자는 컨트롤러를 만들지 않는다.
	 * </pre>
     * 
     * @param rawData JSONObject
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/sc/cmn/jsonCommon.jDo")
    public ModelAndView Json(JSONObject rawData)  {
   		//json에 결과를 전달할 객체 생성
    	ModelAndView mav = new ModelAndView("jSonView");

    	JSONObject txHeader = new JSONObject() ;		
    	JSONObject txData  = new JSONObject();
    	JSONObject txResult = new JSONObject();

    	try
    	{
    		//ARIA 설정
    		ARIAUtil ariaUtil = null;
    		
    		//데이타를 헤더부와 데이터부, RESULT 부로 분리한다. 
    		txHeader = rawData.getJSONObject("txHeader");		
    		txData = rawData.getJSONObject("txData");
    		txResult = rawData.getJSONObject("txResult");
    		
    		String txId = (String) txHeader.get("txId");
    		
    		//암호화 통신 여부 확인
    		boolean encYn = false;
    		if (txHeader.has("encYn"))
    			encYn = txHeader.getBoolean("encYn");
    		logger.debug("암호화 통신인 경우 복호화 처리");
    		//암호화 통신인 경우 복호화 처리
    		if (encYn && txData.has("data")) {
    		    String jsonAriaKey = propertiesService.getString("crypto.aria.json.key");
    			ariaUtil = new ARIAUtil (jsonAriaKey);
    			String encData = txData.getString("data");
    			String decData = ariaUtil.decrypt (encData);
    			//txData = new JSONObject (encData);
    			txData.put("data", decData);
    		}
    		
    		Map serviceMethodMap = caHandler.getServiceMethodMap();    		
    		Object refectionService = serviceMethodMap.get(txId);

    		//annotation 을 사용한 서비스를 호출한다. 
    		if (refectionService !=null)
    		{   
    			logger.debug("서비스를 호출한다. (txId와 매핑되는 서비스 메소드 호출)");
    			//서비스를 호출한다. (txId와 매핑되는 서비스 메소드 호출)
    			ServiceMethod sm = (ServiceMethod) refectionService;
    			logger.debug("sm.getMethod() : " + sm.getMethod());
    			logger.debug("sm.getBeanObject() : " + sm.getBeanObject());
    			logger.debug("txHeader : " + txHeader.toString());
    			logger.debug("txData : " + txData.toString());
    			logger.debug("txResult : " + txResult.toString());
    			//TxServiceDescriptor descriptor = sm.getDescriptor();    //서비스 Description			
    			Object invokeResult = ReflectionUtils.invokeMethod(sm.getMethod(), sm.getBeanObject(), txHeader, txData, txResult);
    			logger.debug("invokeResult : " + invokeResult.toString());
    			
    			logger.debug("서비스로부터 반환된 데이터 설정");
    			//서비스로부터 반환된 데이터 설정 
    			JSONObject txReturn = (JSONObject) invokeResult;
    			
    			JSONObject txResultData = new JSONObject();
    			
    			String sData = "";
    			JSONObject tmp = null;
    			if(txReturn.has("data")){
		    		
   				 	tmp = txReturn.getJSONObject("data");
   				 	sData = tmp.toString();
		    	}
		    	    			
    			//logger.debug("기존 sData : " + sData);    
    			// \ replace 처리 필요 프리미엄급식앱용으로 수정 20191001 김호석
    		    if (txId.equals("IF_FC_INFO_RESULT") || txId.equals("IF_FC_CUST_RESULT") || txId.equals("IF_FC_WEATHER_RESULT")
    		    	|| txId.equals("IF_FC_RECIPE_RESULT") || txId.equals("IF_FC_MENU_RESULT") || txId.equals("IF_HANWHA_MENU_RESULT") ) {
    		    	
    		    	sData = sData.replace("\\\"","\""); 
    		    	//sData = sData.replace("\"","\""); 
    		    	sData = sData.replace("\"[{","[{");
    		    	sData = sData.replace("}]\"","}]");
    		    	//sData = sData.replace("\"[","[");
    		    	//sData = sData.replace("]\"","]"); 
    		    	//logger.debug("변경 sData : " + sData);
    		    	//암호화통신인 경우 처리
        			if (encYn) {
        				sData =  ariaUtil.encrypt(sData);	//암호화하여 전송
        				//mav.addObject("txData", ariaUtil.encrypt(txReturn.toString()));	//암호화하여 전송
        			}
        			
        			mav.addObject("txData", sData);
    		    		    	
    		    } else { 
    		    	logger.debug("암호화통신인 경우 처리");                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
        			//암호화통신인 경우 처리
        			if (encYn) {
        				sData =  ariaUtil.encrypt(sData);	//암호화하여 전송
        				//mav.addObject("txData", ariaUtil.encrypt(txReturn.toString()));	//암호화하여 전송
        			}
//        			else {
//        				//mav.addObject("txData", txReturn);
//        			}
        			txResultData.put("data", sData);
        			mav.addObject("txData", txResultData);    		    	
    		    }
    			
    			//처리결과 설정
    			JSONObject successResult = new JSONObject();
    			FastDateFormat fdf = FastDateFormat.getInstance("yyyy-MM-dd' 'HH:mm:ss");
    			String currentDt = fdf.format(new Date());
    			successResult.put("resultDateTime", currentDt);
    			if(tmp == null){
    				successResult.put("resultCode", DefaultConsts.OK_CODE);
    				successResult.put("resultMessage", "OK");
    			}else{
    				if (tmp.has("ErrorMsg")) {
    					if (tmp.has("ErrorCode")) successResult.put("resultCode", tmp.get("ErrorCode"));
    					else successResult.put("resultCode", DefaultConsts.ERR_CODE);
    					
    					successResult.put("resultMessage", tmp.getString("ErrorMsg"));
    				}
    				else {
        				successResult.put("resultCode", DefaultConsts.OK_CODE);
        				successResult.put("resultMessage", "OK");
    				}
    			}
    			
    			mav.addObject("txHeader", txHeader);
    			mav.addObject("txResult", successResult);
    		}
    		else
    		{
    			//PMD Rule 위배로 수정
    			throw new BizException (txId +" is not Serviced");
    		}
    	}
    	catch (Exception e)
    	{
    		//에러처리
    		String currentDt;
    		try 
    		{
				FastDateFormat fdf = FastDateFormat.getInstance("yyyy-MM-dd' 'HH:mm:ss");
				currentDt = fdf.format(new Date());
			
				//오류결과 설정
				JSONObject errorResult = new JSONObject();
				errorResult.put("resultDateTime", currentDt);
				errorResult.put("resultCode", DefaultConsts.ERR_CODE);
				
				//Biz에서 발생시킨 업무 오류
				if (e.getCause() instanceof com.hwfs.cmn.exception.BizException) {
					errorResult.put("resultMessage", e.getCause().getMessage()); //원본 메시지 전달
				}
				//오류메시지를 상세하게 표시할 경우는 그대로 표시
				else if (propertiesService.getBoolean("errmsg.show.detail", true))
					errorResult.put("resultMessage", e.getStackTrace());
				//오류메시지를 상세하게 표시하지 않을 경우는 메시지 내용을 변환 (개인정보보호 요건 임)
				else
					errorResult.put("resultMessage", messageService.getMessage("fail.common.msg"));
					
				JSONObject emptyObj = new JSONObject();
				emptyObj.put("data", "");
			
				mav.addObject("txHeader",txHeader);
				mav.addObject("txData",  emptyObj);
				mav.addObject("txResult", errorResult);
    		}
    		catch (Exception e1)
    		{
    			logger.error("에러 e1 " +  e1);
    		}
    		
    		logger.error("에러 " +  e.getStackTrace());
    		logger.error("에러 MSG " +  e.getMessage());
    	}
    	
    	return mav;		
    }
}
