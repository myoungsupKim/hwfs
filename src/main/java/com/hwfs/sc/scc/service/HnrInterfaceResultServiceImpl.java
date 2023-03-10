package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.scc.dao.HnrInterfaceResultDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 리조트 픽스 발주내용 전달 IF 관리t Service Implementation
 * 
 * @ClassName OrgConfigServiceImpl.java
 * @Description OrgConfigServiceImpl Class
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
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scc/hnrInterfaceResultService")
public class HnrInterfaceResultServiceImpl extends DefaultServiceImpl implements HnrInterfaceResultService {
	
	/** LogService */
	//private final static Logger logger = LoggerFactory.getLogger(HnrFicsOrderInterfaceDAO.class);
	
	/** HnrInterfaceResultDAO Bean 생성 */
	@Resource(name = "/sc/scc/hnrInterfaceResultDAO")
	private HnrInterfaceResultDAO hnrInterfaceResultDAO;
	
	@Resource(name ="transactionManager")
	private PlatformTransactionManager txManger;

	/**
	 * 리조트 픽스 발주내용 목록을 조회한다.
	 */
	public Map<String, RecordSet> selectList(Map<String, Object> mapParam) throws Exception {
		Map<String, RecordSet> hnrInterfaceResultList = new HashMap<String, RecordSet>();
		hnrInterfaceResultList.put("hnrInterfaceResultList", hnrInterfaceResultDAO.selectHnrInterfaceResult(mapParam));
		return hnrInterfaceResultList;
	}


	/**
	 * 리조트 픽스 발주내용 중 PRID 별로 선택하여 수동으로 IF를 호출 및 IF결과내용 저장 
	 */
	@Override
	public int saveList(DataSetMap dataSetMap, LoginDTO loginDTO) throws Exception {
		
		int procStatus=0;
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
		String inputLine = null; 
		StringBuffer outResult = new StringBuffer();
		
		String hnrUrl = propertiesService.getString("hnrFicsOrderIf.url"); // 리조트 인터페이스 url
		//String hnrUrl = "http://172.16.1.121:8092/login.test.json"; // 성공url
		//String hnrUrl = "http://172.16.1.121:8092/login.test1.json"; // 실패url
		
		// 수기로 전송시에 배치 돌아가고있는지, 이미 처리중인 prid 인지 체크하는 로직 필요! 
		int chkBatchExe = hnrInterfaceResultDAO.selectBatchExecution();
		if(chkBatchExe != 0 ) {
			procStatus = 300; //hnrFicsOrderInterfaceJob is Running 
            return procStatus;
		}
		
		URL url = new URL(hnrUrl);
		HttpURLConnection conn = null;
		OutputStream os = null;
		BufferedReader in = null;
		InputStreamReader isr = null;
		
		try {			
			
			
			JSONObject jsonObject = new JSONObject();
			JSONArray req_array = new JSONArray();
			
			for(int i=0; i<dataSetMap.size(); i++) {
				Map<String, Object> rowData = dataSetMap.get(i);
				int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
				// 데이터 머지
				if(rowType==DataSet.ROW_TYPE_INSERTED || rowType == DataSet.ROW_TYPE_UPDATED) {
					
					// API RQ JSON 생성
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
			}
			
			// 발주정보 조회 결과 map -> API RQ json
			String json = jsonObject.put("prlist", req_array).toString();
			
			//System.out.println("ORDER IF RQ JSON ==>"+ json) ;
			
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
			
	        if (conn.getResponseCode() != 200) { 
	            throw new BizException("Failed: HTTP error code : " + conn.getResponseCode());
	        } 
			
	        isr = new InputStreamReader(conn.getInputStream(),"UTF-8");
	        in = new BufferedReader(isr);
	        while ((inputLine = in.readLine()) != null) {
				outResult.append(inputLine);
			}
			
			String res=outResult.toString(); //API 호출 결과 string
			
			isr.close();
			in.close();
			conn.disconnect();
	
			JSONObject resObject = new JSONObject(res); //API 호출결과 string -> json
			//System.out.println("ORDER IF RS JSON ==> " + resObject);
			
			String apiResult = resObject.getString("success"); // 통신성공여부
			String totalRst = resObject.getString("totalRst"); // 전체결과여부
			
			if(apiResult.equals("true")) {
				JSONArray resArray = resObject.getJSONArray("prlist");

				for(int i=0; i<resArray.length(); i++) {
					
					JSONObject resObj = resArray.getJSONObject(i);
					Map<String, Object> paramMap = new ObjectMapper().readValue(resObj.toString(), Map.class); 
					paramMap.put("uuser", loginDTO.getSabun());
					//System.out.println("resObj cast to Param ==> " + paramMap);
					
					// API RS ARR 한줄 씩 인터페이스 결과 테이블에 update
					if(totalRst.equals("Y")) { // 전체결과가 성공일 경우
						hnrInterfaceResultDAO.updateInterfaceOrderListAllY(paramMap);
					} else { // 전체결과가 실패일 경우
						procStatus = 200; // API totalRst return N
						hnrInterfaceResultDAO.updateInterfaceOrderListAllN(paramMap);
					}
				}
				
				txManger.commit(txStatus);
				
			} else {
				procStatus = 100; //API success return false
	        	//throw new BizException("Failed: API Call Fail : " + apiResult);
	            return procStatus;
			}
		}catch(Exception e){
			//logger.error(e.getMessage(), e);
			txManger.rollback(txStatus);
			e.printStackTrace();
		} finally {
			//System.out.println("finally");
			txStatus.flush();
			if(isr!=null) isr.close();
			if(in!=null) in.close();
			if(conn!=null) conn.disconnect();
		}
		return procStatus;
	}
}
