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

import com.hwfs.batch.defaults.DefaultBatchDAO;
import com.hwfs.cmn.service.PropertiesService;
import com.hwfs.ei.cmn.RequestUtils;
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


/**
 * Moadam JOB Schedule Dao Class
 *
 * @ClassName MoadamSysInterface1DAO.java
 * @Description MoadamSysInterface1DAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  
 * </pre>
 * @author hye.jin94
 * @since 2021. 10. 08.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2020 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/fm/fmo/moadamSysInterface1DAO")
public class MoadamSysInterface1DAO extends DefaultBatchDAO {

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
	
    /** LogService */
	private final static Logger logger = LoggerFactory.getLogger(MoadamSysInterface1DAO.class);

	//모아담 인증토큰 받아오기

	@SuppressWarnings("unchecked")
	public Integer batchJobSuspense(Map<String, Object> mapParam) throws Exception {
		Integer procCnt = 0;
	
		try{
			
			String sendUrl =  propertiesService.getString("moadam.url")+"/api/getAuth";
			//String sendUrl="http://apidev.moadam.co.kr/api/getAuth";
			
			System.out.println("MoadamUrl="+sendUrl);
			
			ObjectMapper mapper=new ObjectMapper();
			HashMap<String, Object> resultMap = new HashMap();
			
			//업장리스트 조회해오기 2022.07.04
			Map<String, Object> tmp = new HashMap<String, Object>(); 
			RecordSet rsUpjang = moadamSysInterfaceSqlDAO.selectUpjangList(tmp); //업장리스트 조회해오기
			
		
			for ( int j=0; j < rsUpjang.size(); j++ ) {

			Record r = rsUpjang.get(j);
				
					
			String keyCode = r.getString("keyCode");
			String interfaceCode = r.getString("code");
			resultMap.put("keyCode", keyCode);  //키코드 String
			
			//resultMap.put("keyCode", propertiesService.getString("moadam.param.p_key_code"));  //키코드 String
			resultMap.put("userid", propertiesService.getString("moadam.param.p_user_id"));  //발급계정아이디 String
			resultMap.put("passwd", propertiesService.getString("moadam.param.p_user_pw"));  //발급계정비밀번호 String
			
			System.out.println(keyCode);
			/*
			System.out.println(propertiesService.getString("moadam.param.p_key_code"));
			System.out.println(propertiesService.getString("moadam.param.p_user_id"));
			System.out.println(propertiesService.getString("moadam.param.p_user_pw"));
			*/
			
			String json = mapper.writeValueAsString(resultMap);

			URL url = new URL(sendUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Accept-Charset", "UTF-8");
			conn.setConnectTimeout(60000); conn.setReadTimeout(60000);//인증토큰받아오기 세션타임아웃 60초
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
						logger.error(code+"error!");
		        	}
		        	return 0;
		        }
			
		    /*    
			System.out.println(jObject.get("result").toString());
			System.out.println(result.get("access_token").toString());
			*/
		    System.out.println("*인터페이스 코드 : "+result.get("interfaceCode").toString());
		        
			procCnt = batchJobSuspense1(result, "POST"); //주문정보 피드백
		}

		}catch(Exception e){
			logger.error(e.getMessage(), e);
			e.printStackTrace();
			}

		return procCnt;
	}

	@SuppressWarnings("unchecked")
	public Integer batchJobSuspense1(JSONObject params, String type) throws Exception {
		
		int rtn = 0;
	
	        try { //주문정보 피드백보내주기

	        	String sendUrl =  propertiesService.getString("moadam.url")+"/api/setOrderCheck";
				//String sendUrl="http://apidev.moadam.co.kr/api/setOrderCheck";
				
				//System.out.println("MoadamUrl="+sendUrl);
				
				ObjectMapper mapper=new ObjectMapper();
				HashMap<String, Object> resultMap = new HashMap();
			
				Map<String, Object> temp = new HashMap<String, Object>(); 
				
				String interfaceCode =  params.get("interfaceCode").toString();
				temp.put("interfaceCode", interfaceCode);
				
				/*피드백 보낼 주문정보 I/F 내역 조회*/
				RecordSet rs = moadamSysInterfaceSqlDAO.selectTargetList(temp);
				 
				//api로 전달 할 최상단 json객체
				JSONObject jsonroot=new JSONObject();

				//db에서 조회해온 주문정보 가상의 list객체에 담기(selectlist)
				ArrayList<Map<String,Object>> selectlist=new ArrayList<Map<String,Object>>();
				Map<String,Object> dbmap=null;
				
				for ( int j=0; j < rs.size(); j++ ) {
					Record r = rs.get(j);
					dbmap=new HashMap<String,Object>();
					
				    dbmap.put("idx", r.getString("idx"));
				    dbmap.put("orderCode", r.getString("orderCode"));
				    dbmap.put("productCode", r.getString("productCode"));
				    dbmap.put("itemCode", r.getString("itemCode"));
				    dbmap.put("orderCount", r.getString("orderCount"));
				    
				    /*
				    System.out.println("*************************");
		            System.out.println("idx : " + r.getString("idx")); //주문일련번호
					System.out.println("orderCode : " + r.getString("orderCode")); //주문코드
					System.out.println("productCode : " + r.getString("productCode")); //상품코드
					System.out.println("itemCode : " +  r.getString("itemCode")); //공급처 상품코드
					System.out.println("orderCount : " + r.getString("orderCount")); //주문수량
					*/
					
				    selectlist.add(dbmap);	
				    
            	}
				
				//json 배열목록을 담아줄 jsonarray 객체생성
				JSONArray jsonList=new JSONArray();

				//주문정보(selectlist)목록을 JSON배열목록에 출력하기 위한 임의의 JSON오브젝트
				JSONObject jsontmp=null;

				//selectlist를 객체 하나씩 뽑아온다
				for(Map<String,Object> selectone : selectlist){

				    Set<String> key=selectone.keySet();
				    jsontmp=new JSONObject();
				   
				    //MAP의 KEY/VALUE를 통하여 JSON임시객체에 담아준후 
				    for (Iterator<String> iterator=key.iterator();iterator.hasNext();){

				        String tmpekey=(String) iterator.next();
				        String tmpvalue=(String) selectone.get(tmpekey);
				   
				      //  jsontmp=new JSONObject();
				        jsontmp.put(tmpekey, tmpvalue);
				    }
				    //System.out.println("**jsontmp**: "+ jsontmp); 
				    
				    //JSON배열목록에 추가
				    jsonList.add(jsontmp);

				}
				
				
				//json set
				jsonroot.put("access_token",params.get("access_token").toString());
				jsonroot.put("orderInfo",jsonList);
				
		        //System.out.println("json Array : " + jsonroot);
		        
		        Object obj=new JSONObject();
		        for (int i = 0; i < jsonList.size(); i ++){

		        	obj = jsonList.get(i);
		        	JSONObject nObj = (JSONObject) obj;
		    
		            String idx = (String) nObj.get("idx");
		            String orderCode = (String) nObj.get("orderCode");
		            String productCode = (String) nObj.get("productCode");
		            String itemCode = (String) nObj.get("itemCode");
		            String orderCount = (String) nObj.get("orderCount");
		            
		        }
				//System.out.println(jsonList);
				
				String json = mapper.writeValueAsString(jsonroot);
				
				URL url = new URL(sendUrl);
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setDoOutput(true);
				conn.setRequestMethod("POST");
				conn.setRequestProperty("Content-Type", "application/json");
				conn.setRequestProperty("Accept-Charset", "UTF-8");
				conn.setConnectTimeout(300000); conn.setReadTimeout(300000); //주문정보 피드백보내기 세션타임아웃 5분
				OutputStream os = conn.getOutputStream();
				os.write(json.getBytes("UTF-8"));
				os.flush(); // 리턴된 결과 읽기
		
				System.out.println("ResponseCode : " + conn.getResponseCode());
				
	            if (conn.getResponseCode() != 200) { 
	            	rtn = -1;
	                System.out.println("Failed: HTTP error code : " + conn.getResponseCode());
	            	throw new RuntimeException("Failed: HTTP error code : " + conn.getResponseCode());
	            } else {
	                System.out.println("Access Sucess");
	                rtn += jsonList.size();
	                //jsonObject = getJsonObjectString(in);
	            }

	            String inputLine = null; 
	    		StringBuffer outResult = new StringBuffer();
	    		
	            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));

				while ((inputLine = in.readLine()) != null) {
				outResult.append(inputLine);
				}
				
				
				String res=outResult.toString();
				
				in.close();   
				conn.disconnect();

				System.out.println(res);
				

				JSONParser parser = new JSONParser();
				JSONObject jObject = (JSONObject)parser.parse(res);
				
				String code = (String)jObject.get("code");
			       
				//0000:정상  0001:넘겨받은 변수 없음  0002:잘못된 토큰  0003:매칭 안됨 (매칭안되는 주문번호)
				if(!code.equals("0000")) {
			        	if(code.equals("0001")){
			        		System.out.println("0001 넘겨받은 변수 없음"+res);
							logger.error("0001 넘겨받은 변수 없음"+res);
			        	}else if(code.equals("0002")){
			        		System.out.println("0002 잘못된 토큰"+res);
							logger.error("0002 잘못된 토큰"+res);
			        	}else if(code.equals("0003")){
			        		System.out.println("0003 매칭 안됨 (매칭안되는 주문번호)"+res);
							logger.error("0003 매칭 안됨 (매칭안되는 주문번호)"+res);
			        	}else{
			        		System.out.println(code);
							logger.error(code+"error!!");
			        	}
			        	return rtn;
			        }
			       
				
	     } catch(Exception e){
				logger.error(e.getMessage(), e);
				e.printStackTrace();
	     }
	        
	        return rtn;
	}
}
