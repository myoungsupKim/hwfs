package com.hwfs.batch.sc.scc.dao;

import hone.core.util.record.RecordSet;
import java.util.Map;
import javax.annotation.Resource;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.hwfs.batch.defaults.DefaultBatchDAO;
import com.hwfs.cmn.service.PropertiesService;
import com.hwfs.sc.scc.dao.HnrFicsOrderInterfaceSqlDAO;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * HnrFicsOrder JOB Schedule Dao Class
 *
 * @ClassName HnrFicsOrderInterfaceDAO.java
 * @Description HnrFicsOrderInterfaceDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  
 * </pre>
 * @author  
 * @since  
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2020 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/scc/hnrFicsOrderInterfaceDAO")
public class HnrFicsOrderInterfaceDAO extends DefaultBatchDAO {
   
	@Resource(name = "propertiesService")
	protected PropertiesService propertiesService;

	/** MoadamSysInterfaceSqlDAO Bean 생성 */
	@Resource(name = "/sc/scc/hnrFicsOrderInterfaceSqlDAO")
	private HnrFicsOrderInterfaceSqlDAO hnrFicsOrderInterfaceSqlDAO;
	
	@Resource(name ="transactionManager")
	private PlatformTransactionManager txManger;
	
    /** LogService */
	private final static Logger logger = LoggerFactory.getLogger(HnrFicsOrderInterfaceDAO.class);

	@SuppressWarnings("unchecked")
	public Integer batchJobSuspense(Map<String, Object> mapParam) throws Exception {
		
		Integer procCnt = 0;
		String inputLine = null; 
		RecordSet batchOrderListRs;
		StringBuffer outResult = new StringBuffer();
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
		
		String hnrUrl = propertiesService.getString("hnrFicsOrderIf.url"); // 리조트 인터페이스 url
		URL url = new URL(hnrUrl);
		HttpURLConnection conn =  null;//(HttpURLConnection) url.openConnection();
		OutputStream os = null;
		BufferedReader in = null;
		InputStreamReader isr = null;
		
		try {
			
			JSONObject jsonObject = new JSONObject();
			JSONArray req_array = new JSONArray();
			
			// 인터페이스 대상 발주정보 조회
			batchOrderListRs = super.queryForRecordSet("sc.scc.HnrFicsOrderInterfaceSqlDAO.selectBatchOrderList", mapParam);
			
			if(batchOrderListRs.getRowCount() > 0){
			
				for(int i=0; i<batchOrderListRs.getRowCount(); i++) {
					Map<String, Object> rowData = batchOrderListRs.get(i);
					
					JSONObject data = new JSONObject();
					data.put("outDate", rowData.get("createDate")); // 발주일자
					data.put("inDate", rowData.get("needDate")); // 입고일자
					data.put("itemCode", rowData.get("hnrItemcode")); // 리조트 자재코드
					data.put("subinvCode", rowData.get("hnrSubinvCode")); // 리조트 창고코드
					data.put("qty", rowData.get("transQty")); // 수량 (창고발주수량)
					data.put("unitAmt", rowData.get("salPrice")); // 판매단가
					data.put("saleAmt", rowData.get("price")); // 판매금액
					data.put("prNum", rowData.get("prNum")); //발주번호
					data.put("prId", rowData.get("prId")); // 발주항번
					data.put("rstYN", ""); // 결과상태
					data.put("rstMSG", ""); // 결과메시지
					
					req_array.put(data);
				}
				
				// 발주정보 조회 결과 map -> API RQ json
				String json = jsonObject.put("prlist", req_array).toString();
				
				//System.out.println("batchJobSuspense json ==> "+ json) ;
				conn = (HttpURLConnection) url.openConnection();
				conn.setDoOutput(true);
				conn.setRequestMethod("POST");
				conn.setRequestProperty("Content-Type", "application/json");
				conn.setRequestProperty("Accept-Charset", "UTF-8");
				conn.setConnectTimeout(60000); 
				conn.setReadTimeout(60000);
				
				os = conn.getOutputStream();
				os.write(json.getBytes("UTF-8"));
				os.flush(); // 리턴된 결과 읽기
				
		        if (conn.getResponseCode() != 200) { // http 응답 에러일경우 
		        	procCnt = -1;
		            //System.out.println("Failed: HTTP error code : " + conn.getResponseCode());
		        	throw new RuntimeException("Failed: HTTP error code : " + conn.getResponseCode());
		        } 
				
		        isr = new InputStreamReader(conn.getInputStream(),"UTF-8");
		        in = new BufferedReader(isr);
				while ((inputLine = in.readLine()) != null) {
					outResult.append(inputLine);
				}
				
				String res=outResult.toString(); //API 호출 결과 string
				
				isr.close();
				in.close();
				conn.disconnect(); //커넥션정리 
		
				JSONObject resObject = new JSONObject(res); //API 호출결과 string -> json
				
				String apiResult = resObject.getString("success"); // apiRS성공여부
				String totalRst = resObject.getString("totalRst"); // 전체 처리결과 여부
				
				if(apiResult.equals("true")) {
					// System.out.println("api 호출 성공");
					
					JSONArray resArray = resObject.getJSONArray("prlist");
	
					for(int i=0; i<resArray.length(); i++) {
						
						JSONObject resObj = resArray.getJSONObject(i);
						Map<String, Object> paramMap = new ObjectMapper().readValue(resObj.toString(), Map.class); // json->map
						//System.out.println("resObj cast to Param ==> " + paramMap);
						
						// API RS ARR 한줄 씩 인터페이스 결과 테이블에 update
						if(totalRst.equals("Y")) { // 전체결과가 성공일 경우
							procCnt += hnrFicsOrderInterfaceSqlDAO.updateInterfaceOrderListAllY(paramMap);
						} else { // 전체결과가 실패일 경우
							procCnt += hnrFicsOrderInterfaceSqlDAO.updateInterfaceOrderListAllN(paramMap);
						}
						
					}
					
					//System.out.println("updateOrderList 결과 cnt ==> " + procCnt);
					txManger.commit(txStatus);
					
				} else {
					procCnt = -1;
		            //System.out.println("Failed: API Call Fail : " + apiResult);
		        	//throw new RuntimeException("Failed: API Call Fail : " + apiResult);
					//return procCnt;
				}
			} else {
				// 인터페이스 대상이 없을 경우 
				procCnt = 0;
			}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
			txManger.rollback(txStatus);
			e.printStackTrace();
		} finally {
			txStatus.flush();
			if(isr!=null) isr.close();
			if(in!=null) in.close();
			if(conn!=null) conn.disconnect();
		}
		
		return procCnt;
	}
	
}
