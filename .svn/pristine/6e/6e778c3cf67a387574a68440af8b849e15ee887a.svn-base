package com.hwfs.sc.cmn.service;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;

import javax.annotation.Resource;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.http.entity.StringEntity;
//import org.json.JSONArray;
//import org.json.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.hanwha.JSonSimpleAdaptor.Client.JSonClient;

import com.hwfs.cmn.crypto.aria.ARIAUtil;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ei.cmn.RequestUtils;
import com.hwfs.sc.cmn.dao.GetSaleInfoDAO;
import com.hwfs.sc.cmn.util.DateUtil;
import com.hwfs.sc.cmn.util.StringUtil;

import java.util.Calendar;
import java.text.SimpleDateFormat;

/**
 * GetSaleInfoServiceImpl에 대한 설명 작성
 * 
 * @ClassName GetSaleInfoServiceImpl.java
 * @Description GetSaleInfoServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.05.29.   kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : kihoon
 * @since 2018.05.29.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/getSaleInfoService")
public class GetSaleInfoServiceImpl extends DefaultServiceImpl implements GetSaleInfoService {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
    

	/** GetSaleInfoDAO Bean 생성 */
	@Resource(name = "/sc/cmn/getSaleInfoDAO")
	private GetSaleInfoDAO getSaleInfoDAO;
	
	@SuppressWarnings("unchecked")
	@Override
	public int GetSaleInfo() throws Exception {

		int rtn = -1;
		int rtn0 = -1;
		
		Map<String, Object> parameter1 = new HashMap<String, Object>();
		//StringBuilder urlBuilder =  new StringBuilder("https://bob.hwhnr.co.kr/api/hwfc/sales");
		//StringBuilder urlBuilder =  new StringBuilder("http://bob.hwhnr.co.kr/api/hwfc/sales");
		StringBuilder urlBuilder =  new StringBuilder("http://bob.efoodist.com/api/hwfc/sales");
		//urlBuilder.append(super.propertiesService.getString("data.go.kr.context.GetSaleInfo"));
	    //String preDate = new SimpleDateFormat("yyyyMMdd", Locale.KOREA).format(new Date());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c0 = Calendar.getInstance(); 
		String tday = sdf.format(c0.getTime()); // String으로 저장 
		c0.add(Calendar.DATE, -1); // 오늘날짜로부터 -1  
		String yday = sdf.format(c0.getTime()); // String으로 저장 
		
		Map<String, Object> temp = new HashMap<String, Object>(); 
		//temp.put("from_date",yday);
		//temp.put("to_date",yday);
		temp.put("from_date",tday);
		temp.put("to_date",tday);
		//동일일자 매출데이타 처리여부 확인
		RecordSet rs =  getSaleInfoDAO.selectSaleInfo(temp);

		Record r = rs.get(0);		 
		String cnt_yn = r.getString("cnt");
	    System.out.println("마감데이타 여부 :"+cnt_yn);
	    
		if (cnt_yn.equals("N")) {
			
    		//삭제 후 다시 등록
        	rtn0 = getSaleInfoDAO.deleteSaleInfo(temp); 
    	    System.out.println("기존데이타 삭제 :"+rtn0);
			
		    //URL url = new URL("http://bob.hwhnr.co.kr/api/hwfc/sales");
    	    URL url = new URL("http://bob.efoodist.com/api/hwfc/sales");
		    //URL url = new URL("http://211.197.235.171/api/hwfc/sales");
		    
	        //String urlParameters = "from_date=" + pday + "&to_date="+ yday;
	
	        //JSONObject reqPrm = new JSONObject();
	        
	        //reqPrm.put("from_date", pday);
	        //reqPrm.put("to_date", yday);
	            
	        HttpURLConnection conn = (HttpURLConnection)url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Content-Type", "application/json");
	        //StringEntity params2 = new StringEntity(reqPrm.toString(), "UTF-8");
	        
	        conn.setDoInput(true);
	        conn.setDoOutput(true);
	        
	        conn.setRequestProperty("Accept", "application/json");
	
	        String datajson =  "{\"from_date\": \""+tday+"\",\"to_date\": \""+tday+"\"}";
	        //String datajson =  "{\"from_date\": \""+yday+"\",\"to_date\": \""+yday+"\"}";
	        
	        //String datajson =  "{\"from_date\": \""+"20200221"+"\",\"to_date\": \""+"20200225"+"\"}";
	        //System.out.println("json:"+datajson);
	
	        OutputStream os = conn.getOutputStream();
	        os.write(datajson.getBytes("UTF-8"));
	        os.close();
	        
	        Charset charset = Charset.forName("UTF-8");
	        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(),charset));
	        
	        String inputLine;
	        StringBuffer response = new StringBuffer();
	
	        while ((inputLine = in.readLine()) != null) {
	            response.append(inputLine);
	        }
	        in.close();
	        //System.out.println(response.toString());
	        
	        String stdDate = tday;
	        
	        String jsonStr = response.toString();
	        //System.out.println("jsonStr : " + jsonStr);
	        
	        JSONParser parser = new JSONParser();
	
	        // 따옴표 변환 필요
	        jsonStr = jsonStr.replace("'", "\"");
	     
	        Object obj = parser.parse( jsonStr );
	        //System.out.println("obj : " + obj);
	        JSONObject jsonObj = (JSONObject) obj;
	        //System.out.println("jsonObj : " + jsonObj.toString());
	        
	        //String sObj = obj.toString();
	        //sObj = sObj.replace("{\"data\":", "");
	        //sObj = sObj.replace(",\"code\":\"000\",\"msg\":\"성공했습니다.\"}", "");        
	        //System.out.println("sObj : " + sObj);        
	        //JSONArray mArray;
	        //mArray = new JSONArray(sObj);        
	        //System.out.println("mArray : " + mArray);
	        
			JSONArray array = (JSONArray)jsonObj.get("data");
	        //System.out.println("array : " + array);
	                
	        for (int i = 0; i < array.size(); i ++){
	
	            //System.out.println("array.get(i) : " + array.get(i));
	        	obj = array.get(i);
	        	//Map<String , Object> rowData = (Map<String , Object>) array.get(i);
	            //System.out.println("obj : " + obj);
	        	//System.out.println("rowData : " + rowData);
	        	
	            JSONObject nObj = (JSONObject) obj;
	            
	            String customer_code = (String) nObj.get("customer_code");
	            String warehouse_no = (String) nObj.get("warehouse_no");
	            String sales_class = (String) nObj.get("sales_class");
	            String vat_class = (String) nObj.get("vat_class");
	            String meal_code = (String) nObj.get("meal_code");
	            meal_code = meal_code.replaceAll("0", "");
	            String amount = (String) nObj.get("amount");
	            String price = (String) nObj.get("price");
	            String trans_date = (String) nObj.get("trans_date");
	            String quantity = (String) nObj.get("quantity");
	            String payment_type = (String) nObj.get("payment_type");
	            String upjang_code = (String) nObj.get("upjang_code");    
	            String remark = (String) nObj.get("remark");    
	
	    		Map<String, Object> parameter = new HashMap<String, Object>();
	    		
	    		parameter.put("customer_code", customer_code);
	    		parameter.put("warehouse_no", warehouse_no);
	    		parameter.put("sales_class", sales_class);
	    		parameter.put("vat_class", vat_class);
	    		parameter.put("meal_code", meal_code);
	    		parameter.put("amount", amount);
	    		parameter.put("price", price);
	    		parameter.put("trans_date", trans_date);
	    		parameter.put("quantity", quantity);
	    		parameter.put("payment_type", payment_type);
	    		parameter.put("upjang_code", upjang_code);
	    		parameter.put("remark", remark);
	    		
	    		//임시테이블 저장
	        	rtn = getSaleInfoDAO.insertSaleInfo(parameter);
	        	
	        }      
        
		} else {
			//마감데이타 존재 패스
			
		}
       
		return rtn;
	
	
	}
	
}
