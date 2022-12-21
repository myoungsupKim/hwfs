package com.hwfs.batch.fm.fmo.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

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
import com.hwfs.fm.fmo.dao.HubmekaSysInterfaceSqlDAO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;


/**
 * Hubmeka JOB Schedule Dao Class
 *
 * @ClassName hubmekaPriceSysInterfaceDAO.java
 * @Description hubmekaPriceSysInterfaceDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  
 * </pre>
 * @author hye.jin94
 * @since 2022. 07. 20.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2020 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/fm/fmo/hubmekaPriceSysInterfaceDAO")
public class HubmekaPriceSysInterfaceDAO extends DefaultBatchDAO {

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
	private final static Logger logger = LoggerFactory.getLogger(HubmekaPriceSysInterfaceDAO.class);

	//허브메카 주문정보 받아오기
	@SuppressWarnings("unchecked")
	public Integer batchJobSuspense(Map<String, Object> mapParam) throws Exception {
		int tmp1 = 0;
		int tmp2 = 0;
		int rtn = 0;
		
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
		
	        try {
	        	
				ObjectMapper mapper=new ObjectMapper();
				HashMap<String, Object> resultMap = new HashMap();
				 

				String ServiceGubun = String.valueOf(mapParam.get("in_url"));
				String UserId = String.valueOf(mapParam.get("in_userId"));
				String sday = String.valueOf(mapParam.get("in_startDay"));
				String gubun = String.valueOf(mapParam.get("in_gubun"));
				
				Map<String, Object> temp = new HashMap<String, Object>(); 
				
				temp.put("userId", UserId); 
				temp.put("piStat", "R"); 
				tmp1 += hubmekaSysInterfaceSqlDAO.updateUserList2(temp); //고객 단가 수동 인터페이스 상태 R
				
				
				
				Map<String, Object> tempList = new HashMap<String, Object>(); 
				
				
				tempList.put("userId", UserId);
				tempList.put("startDate", sday);
				tempList.put("schGubun", gubun);
				
				tmp2 += hubmekaSysInterfaceSqlDAO.deleteIflog(temp); //해당 아이디 기존 인터페이스 로그 삭제  (최종전송내역만 관리)
				
				/*허브메카로 송신할 단가내역 조회*/
				RecordSet rs = hubmekaSysInterfaceSqlDAO.selectPriceList(tempList);
				 
				//API로 전달 할 최상단 JSON객체
				JSONObject jsonroot=new JSONObject();

				//DB에서 조회해온 단가정보를 가상의 list객체에 담기(selectlist)
				ArrayList<Map<String,Object>> selectlist=new ArrayList<Map<String,Object>>();
				Map<String,Object> dbmap=null;
	
				
				for ( int j=0; j < rs.size(); j++ ) {
					Record r = rs.get(j);
					dbmap=new HashMap<String,Object>();
					
				    dbmap.put("if_largeName", r.getString("className2")); //대분류명
				    dbmap.put("if_materialCode", r.getString("itemCode")); //품목코드
				    dbmap.put("if_materialName", r.getString("itemName")); //품목명
				    dbmap.put("if_spec", r.getString("itemSize")); //규격
				    dbmap.put("if_unit", r.getString("poUom")); //단위
				    dbmap.put("if_sellingPrice", r.getString("salePrice")); //운영율단가
				    dbmap.put("if_buyingPrice", r.getString("contractPrice")); //본사단가 
				    dbmap.put("if_vatYN", r.getString("taxYn")); //과세여부
				    dbmap.put("if_leadTime", r.getString("leadTime")); //선발주일수
				    dbmap.put("if_minPurchaseQty", r.getString("minQty")); //구매최소수량
				    dbmap.put("if_applyPurchaseQty", r.getString("applyQty")); //?
				    dbmap.put("if_dotYN", r.getString("dotYn")); //소수점발주 가능여부
				    
				    selectlist.add(dbmap);	
				   
            	}
				
				
				JSONArray jsonList=new JSONArray(); //JSON 배열목록을 담아줄 JSONArray 객체생성
				JSONObject jsontmp=null; //단가정보(selectlist)목록을 JSON배열목록에 출력하기 위한 임의의 JSON오브젝트

				for(Map<String,Object> selectone : selectlist){ //selectlist를 객체 하나씩 뽑아옴

				    Set<String> key=selectone.keySet();
				    jsontmp=new JSONObject();
				   
				    for (Iterator<String> iterator=key.iterator();iterator.hasNext();){ //MAP의 KEY/VALUE를 통하여 JSON임시객체에 담기

				        String tmpekey=(String) iterator.next();
				        String tmpvalue=(String) selectone.get(tmpekey);
				   
				        jsontmp.put(tmpekey, tmpvalue);
				    }
				 
				    //JSON배열목록에 추가
				    jsonList.add(jsontmp);

				}
				
				
				JSONObject data = new JSONObject();
				
				data.put("in_apikey", "T7DB-SMY3-KCXN-GR37-XLLNX7Q27M"); // 
				data.put("in_url", ServiceGubun); // 서비스구분
				data.put("in_userId", UserId); // user id
				data.put("in_startDay", sday); // 단가시작일
			
				//json set
				jsonroot.put("header",data);
				jsonroot.put("priceList",jsonList);
			
				
				String json = mapper.writeValueAsString(jsonroot);
				
				StringBuilder urlBuilder = new StringBuilder(propertiesService.getString("hubmeka.Priceurl"));
				
				URL url = new URL(urlBuilder.toString());
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setDoOutput(true);
				conn.setRequestMethod("POST");
				conn.setRequestProperty("Content-Type", "application/json");
				conn.setRequestProperty("Accept-Charset", "UTF-8");
				conn.setConnectTimeout(600000); conn.setReadTimeout(600000); //단가정보 피드백보내기 세션타임아웃 10분
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
				
				String status = (String)jObject.get("status");
				//System.out.println("#################status:"+status);
			
				String count = String.valueOf(jObject.get("count"));
				//System.out.println("#################count:"+count);
				rtn = Integer.parseInt(count);
				//System.out.println("#################rtn:"+count);
				
			
				if(!status.equals("200")) {
			        	
			        System.out.println("단가전송 결과실패!" + res);
					logger.error("단가전송 결과실패!" + res);
					rtn = -1;
			        
					return rtn;
			    } else {
			    	
	                tmp2 += hubmekaSysInterfaceSqlDAO.insertIflog(tempList); //해당 아이디 인터페이스 로그 추가
			    }
					
				
				Map<String, Object> temp1 = new HashMap<String, Object>(); 
				temp1.put("piStat", "S"); 
				temp1.put("userId", UserId); 
				tmp1 += hubmekaSysInterfaceSqlDAO.updateUserList2(temp1); //단가 수동 인터페이스 상태 S변경
	
				txManger.commit(txStatus);
				
	        } catch(Exception e){
	        	logger.error(e.getMessage(), e);
				e.printStackTrace();
				txManger.rollback(txStatus);
				throw e;
			}
	        
	        return rtn;
	}

	
	/**
	 * 수동실행 시 필요한 값 추출
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectParamList2(Map<String, Object> mapParam) throws Exception {
		return hubmekaSysInterfaceSqlDAO.selectParamList2(mapParam);
	}	
	
	
	
}
