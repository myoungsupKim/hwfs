package com.hwfs.batch.fm.fmo.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordMetadata;
import hone.core.util.record.RecordSet;

import java.sql.Types;
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
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.hwfs.batch.defaults.DefaultBatchDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.service.PropertiesService;
import com.hwfs.fm.fmo.dao.HubmekaSysInterfaceSqlDAO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;


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
 * Hubmeka JOB Schedule Dao Class
 *
 * @ClassName hubmekaSysInterfaceDAO.java
 * @Description hubmekaSysInterfaceDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  
 * </pre>
 * @author hye.jin94
 * @since 2022. 06. 13.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2020 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/fm/fmo/hubmekaSysInterface1DAO")
public class HubmekaSysInterface1DAO extends DefaultBatchDAO {

    /**
     * 
     * @param parameter
     * @return
     * @throws Exception
     */
	
	@Resource(name = "propertiesService")
	protected PropertiesService propertiesService;

	/** MoadamSysInterfaceSqlDAO Bean 생성 */
	@Resource(name = "/fm/fmo/hubmekaSysInterfaceSqlDAO")
	private HubmekaSysInterfaceSqlDAO hubmekaSysInterfaceSqlDAO;
	
	@Resource(name ="transactionManager")
	private PlatformTransactionManager txManger;
	
    /** LogService */
	private final static Logger logger = LoggerFactory.getLogger(HubmekaSysInterface1DAO.class);

	//허브메카 주문정보 받아오기
	@SuppressWarnings("unchecked")
	public Integer batchJobSuspense(Map<String, Object> mapParam) throws Exception {
		
		int hubRtn = 0;
		
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
		
	        try {
	        	
				
				String ServiceGubun = String.valueOf(mapParam.get("in_url"));
				String UserId = String.valueOf(mapParam.get("in_userId"));
				String sday = String.valueOf(mapParam.get("in_stockInDay"));
				String eday = String.valueOf(mapParam.get("in_endstockInDay"));
				
				Map<String, Object> temp = new HashMap<String, Object>(); 
				
				temp.put("userId", UserId); 
				temp.put("piStat", "R"); 
				hubmekaSysInterfaceSqlDAO.updateUserList(temp); //고객 인터페이스 상태 R 일괄변경
				
					//System.out.println(sday);
					//System.out.println(eday);

				Map<String, Object> delParam = new HashMap<String, Object>();
				
				delParam.put("if_userid", UserId); //id
				delParam.put("sday", sday); // 발주시작일자 -- API호출인자
				delParam.put("eday", eday); // 발주종료일자 -- API호출인자
				
				hubmekaSysInterfaceSqlDAO.deleteOrderTempList(delParam); //기존 temp데이터 삭제
				
				
					StringBuilder urlBuilder = new StringBuilder(propertiesService.getString("hubmeka.Orderurl"));
					
					JSONObject data = new JSONObject();
					
					data.put("in_apikey", "T7DB-SMY3-KCXN-GR37-XLLNX7Q27M"); // 
					data.put("in_url", ServiceGubun); // 서비스구분
					data.put("in_userId", UserId); // user id
					data.put("in_stockInDay", sday); // 발주시작일자
					data.put("in_endstockInDay", eday); // 발주종료일자
					
					
					System.out.println("Hubmeka Order Url="+urlBuilder);
					//System.out.println("json="+data);
				
					String json = data.toString();
					
					URL url = new URL(urlBuilder.toString());
					HttpURLConnection conn1 = (HttpURLConnection) url.openConnection();
					conn1.setDoInput(true);
					conn1.setDoOutput(true);
					conn1.setRequestMethod("POST");
					conn1.setRequestProperty("Content-Type", "application/json");
					conn1.setRequestProperty("Accept-Charset", "UTF-8");
					conn1.setRequestProperty("Accept", "application/json");
					
					conn1.setConnectTimeout(600000);//주문정보 받아오기 - 커넥션 타임아웃 10분 
					conn1.setReadTimeout(600000); //주문정보 받아오기 - 컨텐츠조회 타임아웃 10분
				
					OutputStream os = conn1.getOutputStream();
					os.write(json.getBytes("UTF-8"));
					os.flush(); // 리턴된 결과 읽기 : 버퍼에 남아있는 모든 데이터 출력
					os.close(); // 자원 풀어주기
					
					//System.out.println("ResponseCode : " + conn1.getResponseCode());

		            if (conn1.getResponseCode() != 200) { 
		            	hubRtn = -1;
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
	
					System.out.println("★"+UserId+" if결과 : "+res);
					
					//System.out.println("******##Parsing##*******");
			        JSONParser parser = new JSONParser();
			
			        // 따옴표 변환 필요
			        //res = res.replace("'", "\"");
			        Object obj = parser.parse( res );
			        
			       
			        JSONObject jsonObj = (JSONObject) obj;
					JSONArray array = (JSONArray)jsonObj.get("orderList");
					
					List<Map> selectlist = new ArrayList<Map>();
					Map<String,Object> dbmap=null;
					
					hubRtn += array.size()+1;
			        for (int i = 0; i < array.size(); i ++){

			        	obj = array.get(i);
			            JSONObject nObj = (JSONObject) obj;
			            
			        	System.out.println("@Array("+i+"):" +array.get(i));
			        	
			        	dbmap=new HashMap<String,Object>();
			        	
			            dbmap.put("if_userid", (String) nObj.get("if_userid"));
			            dbmap.put("if_key", (String) nObj.get("if_key"));
			            dbmap.put("if_code", (String) nObj.get("if_code"));
			            dbmap.put("if_orderDay", (String) nObj.get("if_orderDay"));
			            dbmap.put("if_stockInDay", (String) nObj.get("if_stockInDay"));
			            dbmap.put("if_materialCode", (String) nObj.get("if_materialCode"));
			            dbmap.put("if_materialName", (String) nObj.get("if_materialName"));
			            dbmap.put("if_qty", nObj.get("if_qty").toString());
			            dbmap.put("if_remark", (String) nObj.get("if_remark"));
			            dbmap.put("if_dotYN", (String) nObj.get("if_dotYN"));
			            dbmap.put("if_stopYN", (String) nObj.get("if_stopYN"));
			            dbmap.put("if_deletionYN", (String) nObj.get("if_deletionYN"));    
			            dbmap.put("if_unit", (String) nObj.get("if_unit"));   
			            dbmap.put("if_spec", (String) nObj.get("if_spec"));   
			            dbmap.put("if_vatYN", (String) nObj.get("if_vatYN"));   
			            dbmap.put("if_leadTime", (String) nObj.get("if_leadTime"));   
			            dbmap.put("if_modifierdate", (String) nObj.get("if_modifierdate"));   
			         
			            selectlist.add(dbmap);
			        }
			        
			        if (array.size() > 0) {
			        	int[] Insrtn = null;
			        	Insrtn = batchJobSuspense1(selectlist); //DB INSERT
			        }
			        //merge프로시저 호출
			        Map<String, Object> rowData = new HashMap<String, Object>();
			        
			        rowData.put("userId", UserId);
			        rowData.put("sday", sday);
			        rowData.put("eday", eday);
			        
			        //tmp2 += hubmekaSysInterfaceSqlDAO.mergeOrderList(rowData); //주문정보 merge
			        //tmp2 += hubmekaSysInterfaceSqlDAO.updateZeroList(rowData); //삭제내역 0처리
			        Map<String, Object> returnVal = new HashMap<String, Object>();
			       
			  
			        returnVal = ifmerge(rowData); //프로시저 호출

					rowData.put("rtnMsg", returnVal.get("O_RTNMSG").toString());
		            rowData.put("rtnCd", returnVal.get("O_RTN").toString());
					
					if(!"TRUE".equals(returnVal.get("O_RTN").toString())){
						if(returnVal.get("O_RTNMSG") == null)returnVal.put("O_RTNMSG","오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
						throw new BizException(returnVal.get("O_RTNMSG").toString());
					}
			        
					//프로시저 내에서 같이 수행되도록 변경
					/*
			        Map<String, Object> temp1 = new HashMap<String, Object>(); 
					temp1.put("piStat", "S"); 
					temp1.put("userId", UserId); 
					tmp1 += hubmekaSysInterfaceSqlDAO.updateUserList(temp1); //고객 인터페이스 상태 S변경
					*/
				
		        txManger.commit(txStatus);
	
	        } catch(Exception e){
	        	logger.error(e.getMessage(), e);
				e.printStackTrace();
				txManger.rollback(txStatus);
				throw e;
			}
	        
	        return hubRtn;
	}
	
	public int[] batchJobSuspense1(List<Map> selectlist) throws Exception {
		
		int[] Insrtn = null;

		Insrtn = hubmekaSysInterfaceSqlDAO.updateOrderList(selectlist); //주문TEMP테이블 INSERT
		
		return Insrtn;
	}

	
	/**
	 * 주문내역 MERGE 프로시저 호출
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public Map<String, Object> ifmerge(Map<String, Object> rowData) throws Exception {
		
		Map<String, Object> pMap = new HashMap<String, Object>();
		//IF_HUB_ORDER_TEMP_PRO
	
		pMap.put("p_userid", 	  String.valueOf(rowData.get("userId"))); //고객아이디
		pMap.put("p_sdate", 	  String.valueOf(rowData.get("sday"))); //발주시작일자
		pMap.put("p_edate",  	  String.valueOf(rowData.get("eday"))); //발주종료일자
	
		return hubmekaSysInterfaceSqlDAO.if_hub_order_temp_pro(pMap);
	}
	
	
	/**
	 * 수동실행 시 필요한 값 추출
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectParamList(Map<String, Object> mapParam) throws Exception {
		return hubmekaSysInterfaceSqlDAO.selectParamList(mapParam);
	}	
	
	
	
}
