package com.hwfs.batch.fm.fmo.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordMetadata;
import hone.core.util.record.RecordSet;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.hwfs.batch.defaults.DefaultBatchDAO;
import com.hwfs.cmn.service.PropertiesService;
import com.hwfs.fm.fmo.dao.MoadamSysInterfaceSqlDAO;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.JSONObject;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;

import javax.crypto.*;
/**
 * Moadam JOB Schedule Dao Class
 *
 * @ClassName MoadamSysInterfaceDAO.java
 * @Description MoadamSysInterfaceDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  
 * </pre>
 * @author hye.jin94
 * @since 2021. 09. 27.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2020 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/fm/fmo/moadamSysInterfaceDAO")
public class MoadamSysInterfaceDAO extends DefaultBatchDAO {

    /**
     * 
     * @param parameter
     * @return
     * @throws Exception
     */
	
	@Resource(name = "propertiesService")
	protected PropertiesService propertiesService;

	/** MoadamSysInterfaceSqlDAO Bean 생성 */
	@Resource(name = "/fm/fmo/moadamSysInterfaceSqlDAO")
	private MoadamSysInterfaceSqlDAO moadamSysInterfaceSqlDAO;
	
	@Resource(name ="transactionManager")
	private PlatformTransactionManager txManger;
	
    /** LogService */
	private final static Logger logger = LoggerFactory.getLogger(MoadamSysInterfaceDAO.class);

	//모아담 인증토큰 받아오기

	@SuppressWarnings("unchecked")
	public Integer batchJobSuspense(Map<String, Object> mapParam) throws Exception {
		Integer procCnt = 0;
		
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
		
		//**///
		try{
			
			String sendUrl =  propertiesService.getString("moadam.url")+"/api/getAuth";
			//String sendUrl="http://apidev.moadam.co.kr/api/getAuth";
			
			System.out.println("MoadamUrl:"+sendUrl);
			
			ObjectMapper mapper=new ObjectMapper();
			HashMap<String, Object> resultMap = new HashMap();
			
			//업장리스트 조회해오기 2022.07.04
			Map<String, Object> tmp = new HashMap<String, Object>(); 
			RecordSet rsUpjang = moadamSysInterfaceSqlDAO.selectUpjangList(tmp); //업장리스트 조회해오기
			
		
			for ( int j=0; j < rsUpjang.size(); j++ ) {

			Record r = rsUpjang.get(j);
				
					
			String keyCode = r.getString("keyCode");
			String interfaceCode = r.getString("code");
			
			//resultMap.put("keyCode", propertiesService.getString("moadam.param.p_key_code"));  //키코드 String
			resultMap.put("keyCode", keyCode);  //키코드 String
			resultMap.put("userid", propertiesService.getString("moadam.param.p_user_id"));  //발급계정아이디 String
			resultMap.put("passwd", propertiesService.getString("moadam.param.p_user_pw"));  //발급계정비밀번호 String
			
			
			System.out.println(keyCode);
			System.out.println(propertiesService.getString("moadam.param.p_user_id"));
			System.out.println(propertiesService.getString("moadam.param.p_user_pw"));
		
			String json = mapper.writeValueAsString(resultMap);

			URL url = new URL(sendUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Accept-Charset", "UTF-8");
			conn.setConnectTimeout(60000); conn.setReadTimeout(60000); //인증토큰 받아오기 세션타임아웃 60초
			OutputStream os = conn.getOutputStream();
			os.write(json.getBytes("UTF-8"));
			os.flush(); // 리턴된 결과 읽기
			

			System.out.println("ResponseCode : " + conn.getResponseCode());
			
            if (conn.getResponseCode() != 200) { 
            	procCnt = -1;
                System.out.println("Failed: HTTP error code : " + conn.getResponseCode());
            	throw new RuntimeException("Failed: HTTP error code : " + conn.getResponseCode());
            } else {
                System.out.println("Access token Sucess");
                //jsonObject = getJsonObjectString(in);
            }


    		String inputLine = null; 
    		StringBuffer outResult = new StringBuffer();

			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));

			while ((inputLine = in.readLine()) != null) {
			outResult.append(inputLine);
			}
			
			
			//0000:정상  0001:넘겨받은 변수 없음  0002:필수 값 없음  0003:결과 값 없음(회원 조회 안됨)
			String res=outResult.toString();
			
			//in.close();   
			conn.disconnect();

			System.out.println(res);

			JSONParser parser = new JSONParser();
			JSONObject jObject = (JSONObject)parser.parse(res);
			JSONObject result = (JSONObject)parser.parse(jObject.get("result").toString());
			result.put("interfaceCode", interfaceCode); //i/f업장 구분값

			String code = (String)jObject.get("code");
		       
			//0000:정상  0001:넘겨받은 변수 없음  0002:필수 값 없음  0003:결과 값 없음(회원 조회 안됨)
			if(!code.equals("0000")) {
		        	if(code.equals("0001")){
		        		System.out.println("0001 넘겨받은 변수 없음");
						logger.error("0001 넘겨받은 변수 없음");
		        	}else if(code.equals("0002")){
		        		System.out.println("0002 필수 값 없음");
						logger.error("0002 필수 값 없음");
		        	}else if(code.equals("0003")){
		        		System.out.println("0003 결과 값 없음(회원 조회 안됨)");
						logger.error("0003 결과 값 없음(회원 조회 안됨) ");
		        	}else{
		        		System.out.println(code);
						logger.error(code+"error!!");
		        	}
		        	return 0;
		        }
		        
			System.out.println(jObject.get("result").toString());
			//*//
			System.out.println(result.get("access_token").toString());
			System.out.println(result.get("interfaceCode").toString());

			//주문내역 받아오기
			procCnt = batchJobSuspense1(result, "GET");
			}
			txManger.commit(txStatus);
		}catch(Exception e){
			txManger.rollback(txStatus);
			logger.error(e.getMessage(), e);
			e.printStackTrace();
		}

		//**///
		
		return procCnt;
}

	@SuppressWarnings("unchecked")
	public Integer batchJobSuspense1(JSONObject params, String type) throws Exception {
		int rtn = 0;
	
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
		
	        try {
	        	
				ObjectMapper mapper=new ObjectMapper();
				HashMap<String, Object> resultMap = new HashMap();
			
				//조회 날짜 생성
				Map<String, Object> temp = new HashMap<String, Object>(); 
				RecordSet rs = moadamSysInterfaceSqlDAO.selectDdayList(temp); //디데이계산 변경요청 2022.05.31
				
				Map<String, Object> dupRowData = rs.get(0);
				System.out.println(dupRowData);
				String sday =  (String)dupRowData.get("sday");
				String eday =  (String)dupRowData.get("eday");
				
				String interfaceCode =  params.get("interfaceCode").toString();
				
				/*
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Calendar c0 = Calendar.getInstance(); 
				c0.add(Calendar.DATE, 1); // 오늘날짜로부터 +1  
				String sday = sdf.format(c0.getTime()); // String으로 저장 
				
				Calendar c1 = Calendar.getInstance(); 
				c1.add(Calendar.DATE, 3); // 오늘날짜로부터 +3  
				String eday = sdf.format(c1.getTime()); // String으로 저장  
		   		*/
				System.out.println(params.get("access_token").toString());
				System.out.println(sday);
				System.out.println(eday);
				System.out.println(interfaceCode);
				
				StringBuilder urlBuilder = new StringBuilder(propertiesService.getString("moadam.url")+"/api/getOrder");
	        	//String sendUrl =  propertiesService.getString("moadam.url")+"/api/getOrder?access_token=";
			
				urlBuilder.append("?" + URLEncoder.encode("access_token","UTF-8") + "=" + URLEncoder.encode(params.get("access_token").toString(),"UTF-8"));
				urlBuilder.append("&" + URLEncoder.encode("sDate","UTF-8") + "=" + URLEncoder.encode(sday,"UTF-8"));
				urlBuilder.append("&" + URLEncoder.encode("eDate","UTF-8") + "=" + URLEncoder.encode(eday,"UTF-8"));
				urlBuilder.append("&" + URLEncoder.encode("dDay","UTF-8") + "=" + "");
				//변경??
				//urlBuilder.append("&" + URLEncoder.encode("endStatus","UTF-8") + "=" + "");
				urlBuilder.append("&" + URLEncoder.encode("endYn","UTF-8") + "=" + "");
				urlBuilder.append("&" + URLEncoder.encode("branchCode","UTF-8") + "=" + "");
				urlBuilder.append("&" + URLEncoder.encode("zeroYn","UTF-8") + "=" + "N");//수량0 제외요청 2022.02.15
				urlBuilder.append("&" + URLEncoder.encode("cancelYn","UTF-8") + "=" + "Y");//취소내역(endStatus=2) 포함요청 2022.04.12
				
				System.out.println("MoadamUrl="+urlBuilder);

				
				String json = mapper.writeValueAsString(resultMap);

				URL url = new URL(urlBuilder.toString());
				HttpURLConnection conn1 = (HttpURLConnection) url.openConnection();
				conn1.setDoOutput(true);
				conn1.setRequestMethod(type);
				conn1.setRequestProperty("Content-Type", "application/json");
				conn1.setRequestProperty("Accept-Charset", "UTF-8");
				conn1.setConnectTimeout(300000);//주문정보 받아오기 - 커넥션 타임아웃 5분 
				conn1.setReadTimeout(300000); //주문정보 받아오기 - 컨텐츠조회 타임아웃 5분
				OutputStream os = conn1.getOutputStream();
				os.write(json.getBytes("UTF-8"));
				os.flush(); // 리턴된 결과 읽기
				
				 
				System.out.println("ResponseCode : " + conn1.getResponseCode());
				
				
	            if (conn1.getResponseCode() != 200) { 
	            	rtn = -1;
	                System.out.println("Failed: HTTP error code : " + conn1.getResponseCode());
	            	throw new RuntimeException("Failed: HTTP error code : " + conn1.getResponseCode());
	            } else {
	                System.out.println("Sucess");
	                //jsonObject = getJsonObjectString(in);
	            }
	            
	            String inputLine = null; 
	    		StringBuffer outResult = new StringBuffer();
	    		
	            
	            BufferedReader in = new BufferedReader(new InputStreamReader(conn1.getInputStream(),"UTF-8"));

				while ((inputLine = in.readLine()) != null) {
				outResult.append(inputLine);
				}
				
				
				String res=outResult.toString();
				
				in.close();   
				conn1.disconnect();

				System.out.println(res);
				

				System.out.println("******##Parsing##*******");
		        JSONParser parser = new JSONParser();
		
		        // 따옴표 변환 필요
		        res = res.replace("'", "\"");
		        Object obj = parser.parse( res );

		        JSONObject jsonObj = (JSONObject) obj;
		        String code = (String)jsonObj.get("code");
		       
		      //0000:정상  0001:넘겨받은 변수 없음  0002:넘겨받은 변수 형식 Invalid  0003:필수 값 없음
			  //0004:잘못된 access token값  0005:결과 값 없음 
		        if(!code.equals("0000")) {
		        	if(code.equals("0001")){
		        		System.out.println("0001 넘겨받은 변수 없음");
						logger.error("0001 넘겨받은 변수 없음");
		        	}else if(code.equals("0002")){
		        		System.out.println("0002 넘겨받은 변수 형식 Invalid");
						logger.error(" 0002 넘겨받은 변수 형식 Invalid");
		        	}else if(code.equals("0003")){
		        		System.out.println("0003 필수 값 없음");
						logger.error("0003 필수 값 없음");
		        	}else if(code.equals("0004")){
		        		System.out.println("0004 잘못된 access token값");
						logger.error("0004 잘못된 access token값");
		        	}else if(code.equals("0005")){
		        		System.out.println("0005 결과 값 없음");
						logger.error("0005 결과 값 없음 ");
		        	}else{
		        		System.out.println(code);
						logger.error(code+"error!!");
		        	}
		        	return 0;
		        }
		        
				JSONArray array = (JSONArray)jsonObj.get("result");
		        System.out.println("array : " + array);
		        System.out.println("**Array Size: " + array.size());
		       
		       
		        for (int i = 0; i < array.size(); i ++){
		        	Map<String, Object> parameter = new HashMap<String, Object>();
		        	 
		        	System.out.println("@Array("+i+"):" +array.get(i));
		        	
		        	obj = array.get(i);
		            JSONObject nObj = (JSONObject) obj;
		            //System.out.println("**nObj:"+nObj);
		    		logger.debug("nObj=>"+nObj);
		    		
		    		
		            String idx = (String) nObj.get("idx");
		            String orderCode = (String) nObj.get("orderCode");
		            String orderDate = (String) nObj.get("orderDate");
		            String orderCount = (String) nObj.get("orderCount");
		            String regDate = (String) nObj.get("regDate");
		            String productCode = (String) nObj.get("productCode");
		            String productName = (String) nObj.get("productName");
		            String productSize = (String) nObj.get("productSize");
		            String productUnit = (String) nObj.get("productUnit");
		            String itemCode = (String) nObj.get("itemCode");
		            String branchCode = (String) nObj.get("branchCode");
		            String dDay = (String) nObj.get("dDay");    
		       
		            //추가??
		            String endStatus = (String) nObj.get("endStatus");   
		            String memo = (String) nObj.get("memo");   
		            
		    		parameter.put("idx", idx); //주문일련번호
		    		parameter.put("orderCode", orderCode);//주문코드
		    		parameter.put("orderDate", orderDate);//배송일
		    		parameter.put("orderCount", orderCount);//주문수량
		    		parameter.put("regDate", regDate);//주문일
		    		parameter.put("productCode", productCode);//상품코드
		    		parameter.put("productName", productName);//상품명
		    		parameter.put("productSize", productSize);//상품규격
		    		parameter.put("productUnit", productUnit);//상품단위
		    		parameter.put("itemCode", itemCode);//공급처 상품코드
		    		parameter.put("branchCode", branchCode);//지점코드
		    		parameter.put("dDay", dDay);//리드타임?
		    		
		    		parameter.put("endStatus", endStatus);//
		    		parameter.put("memo", memo);//구매자 요청사항
		    	
		    		parameter.put("interfaceCode", interfaceCode);//i/f업장구분
		    		//임시테이블 저장
		    		System.out.println("******DB *******");
		    		logger.debug("parameter=>"+parameter);

		    		
		    		rtn += moadamSysInterfaceSqlDAO.updateOrderList(parameter);
		    		
		    		//System.out.println("******rtn =" + rtn);
		    		//System.out.println("******end*******");
		        }
		        txManger.commit(txStatus);
	
	        } catch(Exception e){
	        /*	logger.error(e.getMessage(), e);
				e.printStackTrace();*/
				txManger.rollback(txStatus);
				throw e;
			}
	        
	        return rtn;
	}
	
}
