package com.hwfs.fm.fmo.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.fm.fmo.service.HubmekaSysInterfaceService;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
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
 * HubmekaSysInterfaceService에 대한 설명 작성
 * @ClassName HubmekaSysInterfaceService.java
 * @Description HubmekaSysInterfaceService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  
 * </pre>
 * @author hye.jin94
 * @since 2022. 08. 05.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2020 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmo/hubmekaSysInterfaceService")
public class HubmekaSysInterfaceServiceImpl extends DefaultServiceImpl  implements HubmekaSysInterfaceService{


	/** HubmekaSysInterfaceSqlDAO Bean 생성 */
	@Resource(name = "/fm/fmo/hubmekaSysInterfaceSqlDAO")
	private HubmekaSysInterfaceSqlDAO hubmekaSysInterfaceSqlDAO;

	//허브메카 주문정보 받아오기
	@SuppressWarnings("unchecked")
	public int batchJobSuspense() throws Exception {
		int hubRtn = 0;
	
	        try {
	  
				//조회 날짜 생성
				System.out.println("허브메카 1 -> 고객리스트 조회 시작");
				
				Map<String, Object> temp = new HashMap<String, Object>(); 
				
				SimpleDateFormat format1 = new SimpleDateFormat ("HHmm");
				Calendar time = Calendar.getInstance();    
				String format_time1 = format1.format(time.getTime());
			
				        
				System.out.println("허브메카 배치 구분 : " + format_time1);
				// 3시 2분(1), 3시 32분(2), 4시 2분(3), 4시 32분(4)
				//20220830120 - 1 :  2시 2분(5), 2시 17분(6) , 2시 32분(7) ,3시 42분(8), 3시 52분(9) 추가 요청
				if (format_time1.equals("1502")) {
					temp.put("magamGubun", "1"); 
				} else if (format_time1.equals("1532")) {
					temp.put("magamGubun", "2"); 
				} else if (format_time1.equals("1602")) {
					temp.put("magamGubun", "3"); 
				} else if (format_time1.equals("1632")) {
					temp.put("magamGubun", "4"); 
				} else if (format_time1.equals("1402")) {
					temp.put("magamGubun", "5"); 
				} else if (format_time1.equals("1417")) {
					temp.put("magamGubun", "6"); 
				} else if (format_time1.equals("1432")) {
					temp.put("magamGubun", "7"); 
				} else if (format_time1.equals("1542")) {
					temp.put("magamGubun", "8"); 
				} else if (format_time1.equals("1552")) {
					temp.put("magamGubun", "9"); 
				} else {
					temp.put("magamGubun", ""); 
				}
				
				RecordSet rs = hubmekaSysInterfaceSqlDAO.selectUserList(temp); //고객리스트 조회해오기
				
				System.out.println("허브메카 1 -> 고객리스트 조회 완료");
				
				System.out.println("허브메카 2 -> 고객 인터페이스 상태변경 시작");
				temp.put("piStat", "R"); 
				
				hubmekaSysInterfaceSqlDAO.updateUserList(temp); //고객 인터페이스 상태 R 일괄변경
				
				System.out.println("허브메카 2 -> 고객 인터페이스 상태변경 완료");
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				Calendar c0 = Calendar.getInstance(); 
				c0.add(Calendar.DATE, 1); // 오늘날짜로부터 +1  
				String sday = sdf.format(c0.getTime()); // String으로 저장 
				
				Calendar c1 = Calendar.getInstance(); 
				c1.add(Calendar.DATE, 5); // 오늘날짜로부터 +5 
				String eday = sdf.format(c1.getTime()); // String으로 저장  
		   	

				Map<String, Object> delParam = new HashMap<String, Object>();
	   
				delParam.put("sday", sday); // 발주시작일자
				delParam.put("eday", eday); // 발주종료일자
				
				System.out.println("허브메카 3 -> 기존 temp데이터 일괄삭제 시작");
				
				hubmekaSysInterfaceSqlDAO.deleteOrderTempAllList(delParam); //기존 temp데이터 일괄삭제
	
				System.out.println("허브메카 3 -> 기존 temp데이터 일괄삭제 완료");
				
				System.out.println("허브메카 4 -> 각 고객별 API호출 시작");
				
				for ( int j=0; j < rs.size(); j++ ) {
	
					Record r = rs.get(j);
					
					String ServiceGubun = r.getString("serviceGubun");
					String UserId = r.getString("userid");
		
		        	System.out.println("허브메카 5-"+j+" 호출 시작~~~~ : " + UserId);
		        	
					
					StringBuilder urlBuilder = new StringBuilder(propertiesService.getString("hubmeka.Orderurl"));
					
					JSONObject data = new JSONObject();
					
					data.put("in_apikey", "T7DB-SMY3-KCXN-GR37-XLLNX7Q27M");
					data.put("in_url", ServiceGubun); // 서비스구분
					data.put("in_userId", UserId); // user id
					data.put("in_stockInDay", sday); // 발주시작일자
					data.put("in_endstockInDay", eday); // 발주종료일자
				
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
		            	System.out.println("허브메카 5-"+j+" 호출 완료~~~~ : " + UserId);
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
					
					System.out.println("★"+UserId+" 파싱 시작");
			        JSONParser parser = new JSONParser();
			
			        // 따옴표 변환 필요
			        //res = res.replace("'", "\"");
			        Object obj = parser.parse( res );
			        
			       
			        JSONObject jsonObj = (JSONObject) obj;
					JSONArray array = (JSONArray)jsonObj.get("orderList");
					
			        
					//ArrayList<Map<String,Object>> selectlist=new ArrayList<Map<String,Object>>();
					List<Map> selectlist = new ArrayList<Map>();
					Map<String,Object> dbmap=null;
					
					hubRtn += array.size()+1;
			        for (int i = 0; i < array.size(); i ++){

			        	obj = array.get(i);
			            JSONObject nObj = (JSONObject) obj;
			            
			        	System.out.println("@Array("+j+"-"+i+"):" +array.get(i));
			        	
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
			        System.out.println("★"+UserId+" 파싱 완료");
			        
			       
			        Map<String, Object> rowData = new HashMap<String, Object>();
			        
			        rowData.put("userId", UserId);
			        rowData.put("sday", sday);
			        rowData.put("eday", eday);
			        
			        if (array.size() > 0) {
			        System.out.println("허브메카 6-"+j+" 주문TEMP테이블 INSERT 시작!! : " + UserId);
			        
			        int[] Insrtn = null;
			        Insrtn = batchJobSuspense1(selectlist); //DB INSERT
			        
			        System.out.println("허브메카 6-"+j+" 주문TEMP테이블 INSERT 완료!! : " + UserId);
			        }
			        
			        
			        
			        System.out.println("허브메카 7-"+j+" merge프로시저 호출 시작 : " + UserId);
			        //merge프로시저 호출
			        Map<String, Object> returnVal = new HashMap<String, Object>();
			      
			        
			        returnVal = ifmerge(rowData); //프로시저 호출

					rowData.put("rtnMsg", returnVal.get("O_RTNMSG").toString());
		            rowData.put("rtnCd", returnVal.get("O_RTN").toString());
					
					if(!"TRUE".equals(returnVal.get("O_RTN").toString())){
						if(returnVal.get("O_RTNMSG") == null)returnVal.put("O_RTNMSG","오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
						throw new BizException(returnVal.get("O_RTNMSG").toString());
					}
					System.out.println("허브메카 7-"+j+" merge프로시저 호출 완료 : " + UserId);
					
					if(j < rs.size()-1) {
						System.out.println("허브메카 5-"+(j+1)+" 단계로 이동");
					}
					
				}
				System.out.println("허브메카 8 -> 전체 고객사 인터페이스 성공★");
		        //txManger.commit(txStatus);
	
	        } catch(Exception e){
	        	//logger.error(e.getMessage(), e);
				e.printStackTrace();
				//txManger.rollback(txStatus);
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
	
	
	
}
