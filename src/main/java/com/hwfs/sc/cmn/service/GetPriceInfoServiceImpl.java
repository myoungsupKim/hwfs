package com.hwfs.sc.cmn.service;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
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
import com.hwfs.sc.cmn.dao.GetPriceInfoDAO;
import com.hwfs.sc.cmn.util.DateUtil;
import com.hwfs.sc.cmn.util.StringUtil;

import java.util.Calendar;
import java.text.SimpleDateFormat;

/**
 * GetPriceInfoServiceImpl에 대한 설명 작성
 * 
 * @ClassName GetPriceInfoServiceImpl.java
 * @Description GetPriceInfoServiceImpl Class
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
@Service("/sc/cmn/getPriceInfoService")
public class GetPriceInfoServiceImpl extends DefaultServiceImpl implements GetPriceInfoService {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** GetPriceInfoDAO Bean 생성 */
	@Resource(name = "/sc/cmn/getPriceInfoDAO")
	private GetPriceInfoDAO getPriceInfoDAO;
	
	@SuppressWarnings("unchecked")
	@Override
	public int getPriceInfo() throws Exception {

		Map<String, Object> parameter1 = new HashMap<String, Object>();
		StringBuilder urlBuilder =  new StringBuilder(super.propertiesService.getString("data.go.kr.url"));
		urlBuilder.append(super.propertiesService.getString("data.go.kr.context.getPriceInfo"));
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+super.propertiesService.getString("data.go.kr.getPriceInfo.key")); /*Service Key*/
        //urlBuilder.append("&" + URLEncoder.encode("itemCode","UTF-8") + "=" + URLEncoder.encode("A019170", "UTF-8")); /*품목코드*/
        urlBuilder.append("&" + URLEncoder.encode("startDate","UTF-8") + "=" + URLEncoder.encode("20180101", "UTF-8")); /*검색시작일자 형식 : YYYYMMDD ※ 검색시작일자는 2015년 01월 01일부터 가능하며, 2015년 01월 01일 이전 일자는 데이터가 존재하지 않음 ※ 2015년 01월 01일이전 데이터 요청시 resultCode '21'번이 반환됨 */
        urlBuilder.append("&" + URLEncoder.encode("endDate","UTF-8") + "=" + URLEncoder.encode("20180131", "UTF-8")); /*검색종료일자 형식 : YYYYMMDD ※ 검색종료일자는 검색시작일자로부터 최대 30일까지이며, D-2일까지만 요청 가능 ※ D-2일보다 이후의 데이터를 요청시 resultCode '21'번이 반환됨 ※ 웹브라우저에서 요청페이지번호없이 URL 요청시 최대 2일정도만 요청을 권장함(대량의 데이터 전송으로 웹브라우저가 다운될 수도 있음) */
        //urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*요청페이지번호, 없을 때는 전체목록을 응답함*/
        //urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한페이지에 보여줄 item 개수, 없을 때는 전체목록을 응답함*/
		URL url = new URL(urlBuilder.toString());
		
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        System.out.println(sb.toString());
		return 0;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public int getPriceInfo2() throws Exception {
		
		int rtn = -1;
		Map<String, Object> temp = new HashMap<String, Object>(); 
		String stdDate = ""; 
		
		RecordSet rsCond = getPriceInfoDAO.selectCondList(temp);
		if ( "Y".equals(rsCond.get(0).get("set1").toString()) ) {
			String occrDtFr = rsCond.get(0).get("set2").toString();
			String occrDtTo = rsCond.get(0).get("set3").toString();
			int termDay = Integer.parseInt(rsCond.get(0).get("set4").toString());
			List<String> occrDateList = DateUtil.getBetweenDays(occrDtFr, occrDtTo);
			logger.debug("occrDateList=>"+occrDateList.toString());
			
			for (int z=0; z<occrDateList.size(); z++ ) {
				//if ( z%termDay == 0 ) {
					stdDate = occrDateList.get(z).toString();
					rtn += excuteGetPrice(stdDate);
				//}
			}
		} else {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar c0 = Calendar.getInstance();
			stdDate = sdf.format(c0.getTime());
			rtn += excuteGetPrice(stdDate);
		}
		

		return rtn;
		
	}
	
	public int excuteGetPrice(String stdDate) {
		
		int rtn = -1;
		
		int year = Integer.parseInt(stdDate.substring(0, 4));
		int month = Integer.parseInt(stdDate.substring(4, 6))-1;
		int day = Integer.parseInt(stdDate.substring(6, 8));
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		
		Calendar c1 = Calendar.getInstance();
		c1.set(year, month, day);
		String strToday = sdf.format(c1.getTime());
		System.out.println("stdDate=" + strToday);
		
		Calendar c2 = Calendar.getInstance();
		c2.set(year, month, day);
		c2.add(Calendar.DATE, -1);
		String strYesterday = sdf.format(c2.getTime());
		
		Calendar c3 = Calendar.getInstance();
		c3.set(year, month, day);
		c3.add(Calendar.DATE, -7);
		String strLstWeek = sdf.format(c3.getTime());

		Calendar c4 = Calendar.getInstance();
		c4.set(year, month, day);
		c4.add(Calendar.DATE, -14);
		String strLstWeek2 = sdf.format(c4.getTime());
		
		Calendar c5 = Calendar.getInstance();
		c5.set(year, month, day);
		c5.add(Calendar.MONTH, -1);
		String strLstMonth = sdf.format(c5.getTime());
		
		Calendar c6 = Calendar.getInstance();
		c6.set(year, month, day);
		c6.add(Calendar.YEAR, -1);
		String strLstYear = sdf.format(c6.getTime());
		
		
		JSonClient js = new JSonClient();
		
		try {
			String endPointUrl = super.propertiesService.getString("kamis.or.kr.url");
					endPointUrl += "?action="+super.propertiesService.getString("kamis.or.kr.action");
					endPointUrl += "&p_product_cls_code="+super.propertiesService.getString("kamis.or.kr.param.p_product_cls_code");
					endPointUrl += "&p_country_code="+super.propertiesService.getString("kamis.or.kr.param.p_country_code");
					//endPointUrl += "&p_regday="+super.propertiesService.getString("kamis.or.kr.param.p_regday");
					endPointUrl += "&p_regday="+String.format("%04d", year) + "-" + String.format("%02d", month+1) + "-"+String.format("%02d", day);
					endPointUrl += "&p_convert_kg_yn="+super.propertiesService.getString("kamis.or.kr.param.p_convert_kg_yn");
					endPointUrl += "&p_item_category_code="+super.propertiesService.getString("kamis.or.kr.param.p_item_category_code");
					endPointUrl += "&p_cert_key="+super.propertiesService.getString("kamis.or.kr.param.p_cert_key");
					endPointUrl += "&p_cert_id="+super.propertiesService.getString("kamis.or.kr.param.p_cert_id");
					endPointUrl += "&p_returntype="+super.propertiesService.getString("kamis.or.kr.param.p_returntype");
			
			JSONObject txHeader = new JSONObject();
			JSONObject txData = new JSONObject();
			JSONObject txResult = new JSONObject();
			
			txHeader.put("encoding", "utf-8");
			
			System.out.println("endPointUrl="+endPointUrl);
			JSONObject txReturn = js.RemoteCallJSon(endPointUrl, txHeader, txData, txResult);
			logger.debug("txReturn=>"+txReturn.toString());
			
			JSONArray condition = txReturn.getJSONArray("condition");
			Map<String, Object> condParam = RequestUtils.JSONObject2Map(condition.getJSONObject(0));
			logger.debug("parameter=>"+condParam);
						
			JSONObject data = txReturn.getJSONObject("data");
			JSONArray item = data.getJSONArray("item");

			Map<String, Object> temp = new HashMap<String, Object>(); 
			RecordSet rs = getPriceInfoDAO.selectTargetList(temp);
			
			for ( int i=0; i <item.length(); i++ ) {
				Map<String, Object> inData = new HashMap<String, Object>(); 
				
            	Map<String, Object> parameter = RequestUtils.JSONObject2Map(item.getJSONObject(i));
            	logger.debug("parameter=>"+parameter);
            	
            	String itemName = parameter.get("item_name").toString();
            	
            	for ( int j=0; j < rs.size(); j++ ) {
            		Record r = rs.get(j);
            		String matchItem = r.getString("set3");
            		if ( matchItem.equals(parameter.get("item_name")) ) {
            			inData.put("itemClass2", r.getString("set2"));
            			inData.put("itemClass3", r.getString("set1"));
            			inData.put("itemClass4", r.getString("code"));
            		}
            	}
            	
            	if ( StringUtil.isObjNull(inData.get("itemClass4")) ) {
            		continue;
            	}
            	
            	inData.put("regDay", condParam.get("p_regday").toString().replaceAll("-", ""));
    			inData.put("convertKg", condParam.get("p_convert_kg_yn").toString());
            	inData.put("itemName", itemName);
            	inData.put("kindName", parameter.get("kind_name").toString());
            	inData.put("rank", parameter.get("rank").toString());
            	
            	
            	inData.put("day1", strToday);
            	if ( "-".equals(parameter.get("dpr1").toString().replace(",", "")) ){
            		inData.put("dpr1", null);
            	} else {
            		inData.put("dpr1", parameter.get("dpr1").toString().replace(",", ""));
            	}
            	
            	inData.put("day2", strYesterday);
            	if ( "-".equals(parameter.get("dpr2").toString().replace(",", "")) ){
            		inData.put("dpr2", null);
            	} else {
            		inData.put("dpr2", parameter.get("dpr2").toString().replace(",", ""));
            	}
            	
            	inData.put("day3", strLstWeek);
            	if ( "-".equals(parameter.get("dpr3").toString().replace(",", "")) ){
            		inData.put("dpr3", null);
            	} else {
            		inData.put("dpr3", parameter.get("dpr3").toString().replace(",", ""));
            	}
            	
            	inData.put("day4", strLstWeek2);
            	if ( "-".equals(parameter.get("dpr4").toString().replace(",", "")) ){
            		inData.put("dpr4", null);
            	} else {
            		inData.put("dpr4", parameter.get("dpr4").toString().replace(",", ""));
            	}
            	
            	inData.put("day5", strLstMonth);
            	if ( "-".equals(parameter.get("dpr5").toString().replace(",", "")) ){
            		inData.put("dpr5", null);
            	} else {
            		inData.put("dpr5", parameter.get("dpr5").toString().replace(",", ""));
            	}
            	
            	inData.put("day6", strLstYear);
            	if ( "-".equals(parameter.get("dpr6").toString().replace(",", "")) ){
            		inData.put("dpr6", null);
            	} else {
            		inData.put("dpr6", parameter.get("dpr6").toString().replace(",", ""));
            	}
            	
            	inData.put("day7", null);
            	if ( "-".equals(parameter.get("dpr7").toString().replace(",", "")) ){
            		inData.put("dpr7", null);
            	} else {
            		inData.put("dpr7", parameter.get("dpr7").toString().replace(",", ""));
            	}
            	
            	logger.debug("inData=>"+inData);
            	
            	rtn = getPriceInfoDAO.insertPriceInfo(inData);
            	
            }
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return rtn;
	}
}
