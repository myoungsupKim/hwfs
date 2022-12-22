package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.hanwha.JSonSimpleAdaptor.Client.JSonClient;
import hone.online.xplatform.map.DataSetMap;

import java.security.SecureRandom;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ei.cmn.RequestUtils;
import com.hwfs.fm.fms.dao.SalePriceHistoryMgntDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.util.DateUtil;
import com.hwfs.sc.cmn.util.StringUtil;



/* 적용불가-BigData Pilot */
/*****
import org.rosuda.REngine.*;
import org.rosuda.REngine.Rserve.*;
*****/
/**
 * 판매가격 이력관리 SalePriceHistoryMgntServiceImpl Service Implementation
 * 
 * @ClassName SalePriceHistoryMgntServiceImpl.java
 * @Description SalePriceHistoryMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.06.04    kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 kihoon
 * @since 2018.06.04
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/salePriceHistoryMgntService")
public class SalePriceHistoryMgntServiceImpl extends DefaultServiceImpl implements SalePriceHistoryMgntService {
	
	/** salePriceHistoryMgntDAO Bean 생성 */
	@Resource(name = "/fm/fms/salePriceHistoryMgntDAO")
	private SalePriceHistoryMgntDAO salePriceHistoryMgntDAO;
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	private String nextLine = System.getProperty("line.separator");
	private int nWidth = 720;
	private int nHeight = 500;
	
	
	
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		
		RecordSet rs = salePriceHistoryMgntDAO.selectPeriod(mapParam);
		String pDate = rs.get(0).getString("pDate").toString();
		mapParam.put("schPeriod", pDate);
		
		String condTerm = "";
		String[] term = pDate.split(",");
		for (String cond : term) {
			condTerm += ", NVL(\"" + cond.trim() + "_UNIT_CNT\", 0) AS \""
					+ cond.trim() + "_UNIT_CNT\"";
			condTerm += " , NVL(\"" + cond.trim() + "_UNIT_AVG\", 0) AS \""
					+ cond.trim() + "_UNIT_AVG\"";
			condTerm += " , NVL(\"" + cond.trim() + "_BUY_RATIO\", 0) AS \""
					+ cond.trim() + "_BUY_RATIO\"";
			condTerm += " , NVL(\"" + cond.trim()
					+ "_STRATEGY_RATIO\", 0) AS \"" + cond.trim()
					+ "_STRATEGY_RATIO\"";
			condTerm += " , NVL(\"" + cond.trim() + "_MARGIN_SUM\", 0) AS \""
					+ cond.trim() + "_MARGIN_SUM\"";
			condTerm += " , NVL(\"" + cond.trim() + "_SALE_RATIO\", 0) AS \""
					+ cond.trim() + "_SALE_RATIO\"";
			condTerm += " , NVL(\"" + cond.trim() + "_MARGIN_RATIO\", 0) AS \""
					+ cond.trim() + "_MARGIN_RATIO\"";
		}

		mapParam.put("schCondTerm", condTerm);
		
		Date today = new Date();
        Locale currentLocale = new Locale("KOREAN", "KOREA");
        String pattern = "yyyyMM";
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
        
                	
		if ( formatter.format(today).equals(mapParam.get("schEdDate").toString().substring(0, 6)) ) {
			mapParam.put("schCurMonth", formatter.format(today));
			mapParam.put("schEdDate", LimsUtil.getDateAdd("yyyyMM", "month", -1));
		} else {
			mapParam.put("schCurMonth", null); 
		}
		logger.debug(formatter.format(today)+"=="+mapParam.get("schEdDate").toString().substring(0, 6));
		return salePriceHistoryMgntDAO.selectList(mapParam);
	}
	
	public List<Map<String,Object>> selectListKamis(Map<String, Object> mapParam) throws Exception {

			JSonClient js = new JSonClient();
		
			String endPointUrl = super.propertiesService.getString("kamis.or.kr.url");
					endPointUrl += "?action="+super.propertiesService.getString("kamis.or.kr.action");
					endPointUrl += "&p_product_cls_code=" + mapParam.get("schGnb").toString();
					endPointUrl += "&p_country_code=" + mapParam.get("schLoc").toString();
					endPointUrl += "&p_regday=" + mapParam.get("schDate").toString();
					//endPointUrl += "&p_regday="+String.format("%04d", year) + "-" + String.format("%02d", month) + "-"+String.format("%02d", day);
					endPointUrl += "&p_convert_kg_yn=" + mapParam.get("schKgYn").toString();
					endPointUrl += "&p_item_category_code=" + mapParam.get("schType").toString();
					endPointUrl += "&p_cert_key="+super.propertiesService.getString("kamis.or.kr.param.p_cert_key");
					endPointUrl += "&p_cert_id="+super.propertiesService.getString("kamis.or.kr.param.p_cert_id");
					endPointUrl += "&p_returntype="+super.propertiesService.getString("kamis.or.kr.param.p_returntype");
			
			JSONObject txHeader = new JSONObject();
			JSONObject txData = new JSONObject();
			JSONObject txResult = new JSONObject();
			JSONObject txReturn = new JSONObject();
			
			txHeader.put("encoding", "utf-8");
			List<Map<String, Object>> listItem = new ArrayList<Map<String, Object>>();
			
			try {
				System.out.println("endPointUrl="+endPointUrl);
				txReturn = js.RemoteCallJSon(endPointUrl, txHeader, txData, txResult);
				logger.debug("txReturn=>"+txReturn.toString());
			
				JSONArray condition = txReturn.getJSONArray("condition");
				Map<String, Object> condParam = RequestUtils.JSONObject2Map(condition.getJSONObject(0));
				logger.debug("parameter=>"+condParam);
							
				JSONObject data = txReturn.getJSONObject("data");
				JSONArray item = data.getJSONArray("item");
			
				logger.debug("data=>"+data);
				logger.debug("item=>"+item);
			
				JSONArray jsonParam = new JSONArray (item.toString());
				for (int i=0; i<jsonParam.length(); i++) {
					Map<String, Object> map = new HashMap<String, Object>();
					JSONObject json = jsonParam.getJSONObject(i);
					Iterator iter = json.keys();
					while (iter.hasNext()) {
						String key = iter.next().toString();
						if ( key.indexOf("dpr") != -1 ) {
							map.put(key, json.getString(key).replaceAll(",", ""));
						} else {
							map.put(key, json.getString(key));
						}
					}
					listItem.add(map);
				}
			} catch (Exception ept) {
				Map<String, Object> map = new HashMap<String, Object>();
				listItem.add(map);
			}
			
		return listItem;
	}
	
	public RecordSet selectTrendList(Map<String, Object> mapParam) throws Exception {
			
			RecordSet rs = salePriceHistoryMgntDAO.selectCondList(mapParam);
			String pDate = rs.get(0).getString("pCond").toString();
			mapParam.put("schCond", pDate);
			logger.debug("mapParam=>"+mapParam.toString());
			return salePriceHistoryMgntDAO.selectTrendList(mapParam);
	}
	
	public List <Map> selectPredict(Map<String, Object> mapParam, Map<String, Object> mapParam2) throws Exception {
		
		RecordSet rs = salePriceHistoryMgntDAO.selectCondList(mapParam);
		String pDate = rs.get(0).getString("pCond").toString();
		mapParam.put("schCond", pDate);
		mapParam.put("schItmCls", mapParam2.get("pItemCls").toString());
		logger.debug("mapParam=>"+mapParam.toString());
		
		RecordSet rsResult = salePriceHistoryMgntDAO.selectTrendList2(mapParam);
		
		List <Map> rowMaps = new ArrayList<Map>();
		Map<String, Object> rtn = null;
		Map<String, Object> rtnVal = null;
/*****		
		RConnection c = null;
		org.rosuda.REngine.REXP x = null;

		
		try {
            c = new RConnection();
            
            rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 1);
			rtnVal.put("title", "Start REngine");
			rtnVal.put("type", "text");
			rtn = getRVersion(c);
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
			
			
			rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 2);
			rtnVal.put("title", "Load Library");
			rtnVal.put("type", "text");
			rtn = loadLibrary(c);
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
					
			
			rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 3);
			rtnVal.put("title", "Load Date");
			rtnVal.put("type", "text");
			rtn = loadData(c, rsResult);
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
			 
			
			rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 4);
			rtnVal.put("title", "Preprocessing");
			rtnVal.put("type", "text");
			
			int nYear = (int) Math.ceil(DateUtil.getGapForMonth(mapParam.get("schFrDt").toString(), mapParam.get("schToDt").toString())/12)+1;
			rtn = preProcessing(c, nYear);
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
			

			rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 5);
			rtnVal.put("title", "Generate Chart(Current)");
			rtnVal.put("type", "image");
			rtn = preProcessingChart(c);
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
			
			
			rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 6);
			rtnVal.put("title", "Generate Chart(CP)");
			rtnVal.put("type", "image");
			rtn = checkSMA_CP(c);
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
			
			
			rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 7);
			rtnVal.put("title", "Generate Chart(SP)");
			rtnVal.put("type", "image");
			rtn = checkSMA_SP(c);
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
			
			
			rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 8);
			rtnVal.put("title", "Generate Chart(KP)");
			rtnVal.put("type", "image");
			rtn = checkSMA_KP(c);
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
			
			
			rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 9);
			rtnVal.put("title", "Check ACF");
			rtnVal.put("type", "image");
			rtn = getACF(c);
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
			
			
			rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 10);
			rtnVal.put("title", "Check Auto Arima");
			rtnVal.put("type", "text");
			rtn = checkAutoARIMA(c);
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
			
			
			rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 11);
			rtnVal.put("title", "Forecast Text(Auto)");
			rtnVal.put("type", "text");
			rtn = getForecastText(c, nYear, "arima");
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
			
			
			rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 12);
			rtnVal.put("title", "Forecast Chart(Auto)");
			rtnVal.put("type", "image");
			rtn = getForecastChart(c, nYear, "arima");
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
			
			rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 13);
			rtnVal.put("title", "Forecast Text(HoltWinters)");
			rtnVal.put("type", "text");
			rtn = getForecastText(c, nYear, "ets");
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
			
			
			rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 14);
			rtnVal.put("title", "Forecast Chart(HoltWinters)");
			rtnVal.put("type", "image");
			rtn = getForecastChart(c, nYear, "ets");
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
			
			rtnVal = new HashMap<String, Object>();
			rtnVal.put("step", 15);
			rtnVal.put("title", "Forecast Model");
			rtnVal.put("type", "text");
			rtn = setForecastModel(c, nYear);
			rtnVal.put("code", rtn.get("code").toString());
			rtnVal.put("resultMsg", rtn.get("result").toString());
			rowMaps.add(rtnVal);
				
		} catch (REngineException e) {
			rowMaps = null;
			System.out.println(e.getMessage().toString());
        } finally {
        	c.close();
        }
*****/
		logger.debug(rowMaps.toString());
		return rowMaps;
	}
	
/*****
	public Map<String, Object> getRVersion(RConnection c) throws RserveException, REXPMismatchException {
		logger.debug("##  RServe Start  ##");
		StringBuffer code = new StringBuffer(); 
		String command = null;
		code.append(nextLine);
		code.append("## Start REngine ##");
		code.append(nextLine);
		command = "R.version.string";
		code.append(command);
		code.append(nextLine);
		
		REXP x = c.eval(command);
		code.append(x.asString());
		code.append(nextLine);
		
		logger.debug("R version : " + x.asString());
				
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("code", code);
		rtnMap.put("result", x.asString());
		return rtnMap;
	}
	
	public Map<String, Object> loadLibrary(RConnection c) throws REngineException, REXPMismatchException {
		
		String[] lib = { "astsa", "fpp", "tidyverse", "xts", "TTR", "forecast", "reshape2", "ggplot2" };
		
		StringBuffer code = new StringBuffer(); 
		code.append(nextLine);
		code.append("## Load Library ##");
		code.append(nextLine);
		
		String command = null;
		for( String element:lib) {
			command = "library(" + element + ")";
			c.eval(command);
			code.append(command);
			code.append(nextLine);
		}
		
		logger.debug("##  Load Library  ##");
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("code", code.toString());
		rtnMap.put("result", "NA");
		return rtnMap;
	}
	
	public Map<String, Object> loadData(RConnection c, RecordSet rsResult) throws REngineException, REXPMismatchException, ParseException {

		
		Integer[] sContractSt = new Integer[rsResult.getRowCount()];
		Double[] sAvgCp = new Double[rsResult.getRowCount()];
		Double[] sAvgSp = new Double[rsResult.getRowCount()];
		Double[] sAvgKp = new Double[rsResult.getRowCount()];
		Integer nStdDate = 0;
		
		for (int i = 0; i < rsResult.getRowCount(); i++) {
			if ( i == (rsResult.getRowCount() - 2) ) {
				nStdDate = rsResult.get(i).getInt("contractStart");
			}
			
			sContractSt[i] = rsResult.get(i).getInt("contractStart");
			sAvgCp[i] = rsResult.get(i).getDouble("avgCp");
			sAvgSp[i] = rsResult.get(i).getDouble("avgSp");
			sAvgKp[i] = rsResult.get(i).getDouble("avgKp");
		}
		
		StringBuffer code = new StringBuffer(); 
		code.append(nextLine);
		code.append("##  Load Data  ##");
		code.append(nextLine);
		String command = null;
		
		
		String[] target = { "dt", "cp", "sp", "kp" };
		
		command = "dt <- c" + Arrays.toString(sContractSt).replace("[",  "(").replace("]", ")");
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "cp <- c" + Arrays.toString(sAvgCp).replace("[",  "(").replace("]", ")");
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "sp <- c" + Arrays.toString(sAvgSp).replace("[",  "(").replace("]", ")");
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "kp <- c" + Arrays.toString(sAvgKp).replace("[",  "(").replace("]", ")");
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "DF_S <- data.frame(dt, cp, sp, kp)";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		//c.parseAndEval("DF <- data.frame(dt, cp, sp, kp)");
		
		command = "DF_S$Date <- as.Date(as.character(DF_S$dt), format=\"%Y%m%d\")";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "DF <- DF_S[-c(1)]";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		
		SimpleDateFormat originalFormat = new SimpleDateFormat("yyyyMMdd");
		Date date = originalFormat.parse(nStdDate.toString());
		SimpleDateFormat newFormat = new SimpleDateFormat("yyyy-MM-dd");
		String formatedDate = newFormat.format(date);
		
		command = "DF <- subset(DF_S, Date < '" + formatedDate + "')";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "capture.output(summary(DF))";
		code.append(command);
		code.append(nextLine);
		REXPString s1 = (REXPString) c.eval(command);
		String[] output1 = s1.asStrings();
		
		StringBuffer resultMsg = new StringBuffer(); 
		for (String x: output1) {
			resultMsg.append(x);
			resultMsg.append(nextLine);
		}
		code.append(resultMsg.toString());
		code.append(nextLine);
		
		
		command = "DF_T <- subset(DF_S, Date >= '" + formatedDate + "')";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "capture.output(summary(DF_T))";
		code.append(command);
		code.append(nextLine);
		REXPString s2 = (REXPString) c.eval(command);
		String[] output2 = s2.asStrings();
		
		for (String y: output2) {
			resultMsg.append(y);
			resultMsg.append(nextLine);
		}
		code.append(resultMsg.toString());
		code.append(nextLine);
			
		
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("code", code.toString());
		rtnMap.put("result", resultMsg.toString());
		
		return rtnMap;
	}
	
	public Map<String, Object> preProcessing(RConnection c, int nYear) throws REngineException, REXPMismatchException {

		StringBuffer code = new StringBuffer(); 
		code.append(nextLine);
		code.append("##  Preprocessing  ##");
		code.append(nextLine);
		String command = null;
		
		String[] target = { "CP", "SP", "KP" };
		for( String element:target) {
			command = "DF_" + element+ " <- data.frame(DF$Date, DF$" + element.toLowerCase()+")" ;
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
		}
		
		code.append(nextLine);
		for( String element:target) {
			command = "TS_" + element+ " <- xts(DF$" + element.toLowerCase() + ", DF$Date, frequency = " + String.valueOf(nYear)+ ")" ;
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
			
			command = "TS_" + element+ "_T <- xts(DF_T$" + element.toLowerCase() + ", DF_T$Date, frequency = 3)" ;
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
		}
		
		//return "preprocessing";
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("code", code.toString());
		rtnMap.put("result", "NA");
		
		return rtnMap;
	}
	
	public Map<String, Object> preProcessingChart(RConnection c) throws REngineException, REXPMismatchException {
		
		String rtn = "";
		SecureRandom random = new SecureRandom();
		String rNum = "";
		String filePath = "";
		String png = "";

		rNum = String.format("%06d", random.nextInt(1000000));
    	filePath = propertiesService.getString("global.imagerepository.path") + "/rChart/" + rNum + ".png";
    	rtn = "/rChart/" + rNum + ".png";
    	logger.debug("filePath=>"+filePath);
        
    	png = "png(width = " + nWidth + ", height = " + nHeight + ", file = \"" + filePath + "\", antialias=\"cleartype\")";
        png = png.replaceAll("\\\\", "/");
                    
        StringBuffer sb = new StringBuffer();
       
		sb.append("ggplot(DF, aes(x=Date)) + ");
		sb.append("geom_line(aes(y=cp, col = 'CP')) + ");
		sb.append("geom_point(aes(y=cp, col = 'CP'), size=2) + ");
		sb.append("geom_line(aes(y=sp, col = 'SP')) + ");
		sb.append("geom_point(aes(y=sp, col = 'SP'), size=2) + ");
		sb.append("geom_line(aes(y=kp, col = 'KP')) + ");
		sb.append("geom_point(aes(y=kp, col = 'KP'), size=2) + ");
		sb.append("labs(title='', x='Date', y='Price') + ");
		sb.append("theme(panel.grid.minor = element_blank()) ");
		
		StringBuffer code = new StringBuffer(); 
		code.append(nextLine);
		code.append("##  Generate Chart(Current)  ##");
		code.append(nextLine);
		String command = null;
		command = "chart1 <- " + sb.toString();
		code.append(command);
		c.parseAndEval(command);
		
		code.append(nextLine);
		command = png;
		code.append(command);
		c.eval(command);
		
		command = "print(chart1);dev.off()";
		code.append(nextLine);
		code.append(command);
        c.parseAndEval(command);
		
		logger.debug(sb.toString());
		
		//c.parseAndEval(sb.toString());
		//c.parseAndEval(sb.toString());
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("code", code.toString());
		rtnMap.put("result", rtn);
		
		return rtnMap;
	}
	
	public Map<String, Object> checkSMA_CP(RConnection c) throws REXPMismatchException, REngineException {
		logger.debug("##  check CP SMA  ##");
		StringBuffer code = new StringBuffer(); 
		String command = null;
		code.append(nextLine);
		code.append("## check CP SMA ##");
		code.append(nextLine);
				
		// SMA
		String[] period = { "3", "11", "19" };
		for( String n : period) {
			command = "TS_CP_SMA" + n +" <- SMA(TS_CP, n=" + n + ")";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
		}
		
		String rtn = "";
		SecureRandom random = new SecureRandom();
		String rNum = "";
		String filePath = "";
		String png = "";

		rNum = String.format("%06d", random.nextInt(1000000));
    	filePath = propertiesService.getString("global.imagerepository.path") + "/rChart/" + rNum + ".png";
    	rtn = "/rChart/" + rNum + ".png";
    	logger.debug("filePath=>"+filePath);
        
    	png = "png(width = " + nWidth + ", height = " + nHeight + ", file = \"" + filePath + "\", antialias=\"cleartype\")";
        png = png.replaceAll("\\\\", "/");
		command = png;
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command ="par(mfrow = c(2,2))";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "plot.ts(TS_CP)";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "title('summary')";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "grid()";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		
		for( String n : period) {
			command = "plot.ts(TS_CP_SMA" + n + ")";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
			
			command = "title('SMA"+n+"')";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
			
			command = "grid()";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
		}
        
        command = "dev.off()";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
				
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("code", code);
		rtnMap.put("result", rtn);
		return rtnMap;
	}
	
	public Map<String, Object> checkSMA_SP(RConnection c) throws REXPMismatchException, REngineException {
		logger.debug("##  check SP SMA  ##");
		StringBuffer code = new StringBuffer(); 
		String command = null;
		code.append(nextLine);
		code.append("## check SP SMA ##");
		code.append(nextLine);
				
		// SMA
		String[] period = { "3", "11", "19" };
		for( String n : period) {
			command = "TS_SP_SMA" + n +" <- SMA(TS_SP, n=" + n + ")";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
		}
		
		String rtn = "";
		SecureRandom random = new SecureRandom();
		String rNum = "";
		String filePath = "";
		String png = "";

		rNum = String.format("%06d", random.nextInt(1000000));
    	filePath = propertiesService.getString("global.imagerepository.path") + "/rChart/" + rNum + ".png";
    	rtn = "/rChart/" + rNum + ".png";
    	logger.debug("filePath=>"+filePath);
        
    	png = "png(width = " + nWidth + ", height = " + nHeight + ", file = \"" + filePath + "\", antialias=\"cleartype\")";
        png = png.replaceAll("\\\\", "/");
		command = png;
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command ="par(mfrow = c(2,2))";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "plot.ts(TS_SP)";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "title('summary')";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "grid()";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		
		for( String n : period) {
			command = "plot.ts(TS_SP_SMA" + n + ")";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
			
			command = "title('SMA"+n+"')";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
			
			command = "grid()";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
		}
        
        command = "dev.off()";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
				
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("code", code);
		rtnMap.put("result", rtn);
		return rtnMap;
	}
	
	
	public Map<String, Object> checkSMA_KP(RConnection c) throws REXPMismatchException, REngineException {
		logger.debug("##  check KP SMA  ##");
		StringBuffer code = new StringBuffer(); 
		String command = null;
		code.append(nextLine);
		code.append("## check KP SMA ##");
		code.append(nextLine);
				
		// SMA
		String[] period = { "3", "11", "19" };
		for( String n : period) {
			command = "TS_KP_SMA" + n +" <- SMA(TS_KP, n=" + n + ")";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
		}
		
		String rtn = "";
		SecureRandom random = new SecureRandom();
		String rNum = "";
		String filePath = "";
		String png = "";

		rNum = String.format("%06d", random.nextInt(1000000));
    	filePath = propertiesService.getString("global.imagerepository.path") + "/rChart/" + rNum + ".png";
    	rtn = "/rChart/" + rNum + ".png";
    	logger.debug("filePath=>"+filePath);
        
    	png = "png(width = " + nWidth + ", height = " + nHeight + ", file = \"" + filePath + "\", antialias=\"cleartype\")";
        png = png.replaceAll("\\\\", "/");
		command = png;
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command ="par(mfrow = c(2,2))";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "plot.ts(TS_KP)";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "title('summary')";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command = "grid()";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		
		for( String n : period) {
			command = "plot.ts(TS_KP_SMA" + n + ")";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
			
			command = "title('SMA"+n+"')";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
			
			command = "grid()";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
		}
        
        command = "dev.off()";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
				
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("code", code);
		rtnMap.put("result", rtn);
		return rtnMap;
	}
	
	public Map<String, Object> getACF(RConnection c) throws REXPMismatchException, REngineException {
		logger.debug("##  ACF  ##");
		StringBuffer code = new StringBuffer(); 
		String command = null;
		code.append(nextLine);
		code.append("## ACF ##");
		code.append(nextLine);
		
		String rtn = "";
		SecureRandom random = new SecureRandom();
		String rNum = "";
		String filePath = "";
		String png = "";

		rNum = String.format("%06d", random.nextInt(1000000));
    	filePath = propertiesService.getString("global.imagerepository.path") + "/rChart/" + rNum + ".png";
    	rtn = "/rChart/" + rNum + ".png";
    	logger.debug("filePath=>"+filePath);
        
    	png = "png(width = " + nWidth + ", height = " + nHeight + ", file = \"" + filePath + "\", antialias=\"cleartype\")";
        png = png.replaceAll("\\\\", "/");
		command = png;
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		
		command = "par(mfrow = c(2,3))";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		String[] target = { "CP", "SP", "KP" };
		for( String element:target) {
			command = "pacf(TS_" + element + ", main='pacf_"+ element +"')" ;
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
		}
		
		for( String element:target) {
			command = "acf(TS_" + element + " , main='acf_"+element+"')" ;
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
		}
		command = "dev.off()";
		code.append(command);
		c.parseAndEval(command);
				
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("code", code);
		rtnMap.put("result", rtn);
		return rtnMap;
	}
	
	public Map<String, Object> checkAutoARIMA(RConnection c) throws REXPMismatchException, REngineException {
		logger.debug("##  Check Auto ARIMA  ##");
		StringBuffer code = new StringBuffer(); 
		String command = null;
		code.append(nextLine);
		code.append("## Check Auto ARIMA ##");
		code.append(nextLine);
		
		String[] target = { "CP", "SP", "KP" };
		for( String element:target) {
			
			command = "capture.output(summary(auto.arima(TS_"+ element +")))" ;
			code.append(command);
			code.append(nextLine);
			REXPString x = (REXPString) c.parseAndEval(command);
			String[] output = x.asStrings();
			
			StringBuffer resultMsg = new StringBuffer(); 
			for (String s: output) {
				resultMsg.append(s);
				resultMsg.append(nextLine);
			}
			code.append(resultMsg.toString());
		}
				
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("code", code);
		rtnMap.put("result", code);
		return rtnMap;
	}
	
	public Map<String, Object> getForecastText(RConnection c, int nYear, String mode) throws REngineException, REXPMismatchException {

		StringBuffer code = new StringBuffer(); 
		code.append(nextLine);
		code.append("##  Forecast Text ##");
		code.append(nextLine);
		String command = null;
		
		String[] target = { "CP", "SP", "KP" };
		for( String element:target) {
			if ( "arima".equals(mode) ) {
				command = "TS_" + element+ "_ARIMA_AUTO <- auto.arima(TS_" + element +")" ;
			} else if ("ets".equals(mode) ) {
				command = "TS_" + element+ "_ETSF <- HoltWinters(TS_" + element +", alpha = 0.1, beta = F, gamma = F)" ;
			}
			code.append(command);
			code.append(nextLine);
			logger.debug("#"+command);
			c.parseAndEval(command);
		}
		
		code.append(nextLine);
		StringBuffer resultMsg = new StringBuffer(); 
		
		for( String element:target) {
			if ( "arima".equals(mode) ) {
				command = "capture.output(summary(TS_"+ element + "_ARIMA_AUTO))";
			} else if ( "ets".equals(mode) ) {
				command = "capture.output(summary(TS_"+ element + "_ETSF))";
			}
				code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
			
			
			REXPString s = (REXPString) c.eval(command);
			String[] output1 = s.asStrings();
			
			resultMsg.append(command);
			for (String x: output1) {
				resultMsg.append(nextLine);
				resultMsg.append(x);
				resultMsg.append(nextLine);
			}
			
			if( "arima".equals(mode) ) {
				command = "capture.output(forecast(TS_"+ element + "_ARIMA_AUTO, h=6))";
			} else if ( "ets".equals(mode) ) {
				command = "capture.output(forecast(TS_"+ element + "_ETSF, h=6))";
			}
			
			code.append(command);
			code.append(nextLine);
			REXPString x = (REXPString) c.parseAndEval(command);
			String[] output2 = x.asStrings();
			
			resultMsg.append(command);
			for (String y: output2) {
				resultMsg.append(nextLine);
				resultMsg.append(y);
				resultMsg.append(nextLine);
			}
		}
				
		code.append(resultMsg.toString());
		code.append(nextLine);
		logger.debug(resultMsg.toString()); 
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("code", code.toString());
		rtnMap.put("result", resultMsg.toString());
		
		return rtnMap;
	}
	
	public Map<String, Object> getForecastChart(RConnection c, int nYear, String mode) throws REXPMismatchException, REngineException {
		logger.debug("##  Forecast Chart  ##");
		StringBuffer code = new StringBuffer(); 
		String command = null;
		code.append(nextLine);
		code.append("## Forecast Chart ##");
		code.append(nextLine);
				
				
		String rtn = "";
		SecureRandom random = new SecureRandom();
		String rNum = "";
		String filePath = "";
		String png = "";

		rNum = String.format("%06d", random.nextInt(1000000));
    	filePath = propertiesService.getString("global.imagerepository.path") + "/rChart/" + rNum + ".png";
    	rtn = "/rChart/" + rNum + ".png";
    	logger.debug("filePath=>"+filePath);
        
    	png = "png(width = " + nWidth + ", height = " + nHeight + ", file = \"" + filePath + "\", antialias=\"cleartype\")";
        png = png.replaceAll("\\\\", "/");
		command = png;
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		command ="par(mfrow = c(3,1))";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
		
		String[] target = { "CP", "SP", "KP" };
		for( String n : target) {
			
			if ( "arima".equals(mode) ) {
				command = "plot(forecast(TS_" + n +"_ARIMA_AUTO, h=6), main=\""+n+"\")";
			} else if ( "ets".equals(mode) ) {
				command = "plot(forecast(HoltWinters(TS_" + n + ", alpha = 0.1, beta = F, gamma = F), h=6, main=\""+n+"\"))";
			}
			
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
		}
        
		
        command = "dev.off()";
		code.append(command);
		code.append(nextLine);
		c.parseAndEval(command);
				
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("code", code);
		rtnMap.put("result", rtn);
		return rtnMap;
	}
	
	public Map<String, Object> setForecastModel(RConnection c, int nYear) throws REngineException, REXPMismatchException {

		StringBuffer code = new StringBuffer(); 
		code.append(nextLine);
		code.append("##  Forecast Model ##");
		code.append(nextLine);
		String command = "";
		
		command = "set.seed(1234)";
		code.append(command);
		code.append(nextLine);
		c.eval(command);
		
		String[] target = { "CP", "SP", "KP" };
		
		for( String element:target) {
					
			command = "MODELS_" + element + " <- list (";
			command	+= "	MOD_" + element + "_ARIMA = auto.arima(TS_" + element + ", ic=\"aicc\", stepwise = FALSE),";
			command	+= "	MOD_" + element + "_EXPONENTIAL = ets(TS_" + element + ", ic=\"aicc\", restrict = FALSE),";
			command	+= "	MOD_" + element + "_NEURAL = nnetar(TS_" + element + ")";
			command	+= ")";
			
			code.append(command);
			code.append(nextLine);
			c.eval(command);
			
			code.append(nextLine);
			command = "forecasts"+ element + " <- lapply(MODELS_" + element + ", forecast, 4)";
			code.append(command);
			c.parseAndEval(command);
			code.append(nextLine);
			
			command = "forecasts"+ element + "$naive <- naive(TS_" + element + ", 4)"; 
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
			
			command = "acc_" + element +" <- lapply(forecasts"+ element + ", function(f) {";
			command += " accuracy(f, TS_"+ element + "_T)[2,,drop=FALSE]";
			command += "})";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
			
			command = "acc_" + element + " <- Reduce(rbind, acc_" + element + ")";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
			
			
			command = "row.names(acc_" + element + ") <- names(forecasts" + element + ")";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
			
			
			command = "acc_" + element +" <- acc_" + element + "[order(acc_" + element + "[, 'MASE']), ]";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
			
			
			command = "round(acc_" + element + ", 2)";
			code.append(command);
			code.append(nextLine);
			code.append(nextLine);
			c.parseAndEval(command);
		}
		
		code.append(nextLine);
		code.append(nextLine);
		StringBuffer resultMsg = new StringBuffer(); 
		
		REXPString s = null;
		for( String element2:target) {
			command = "capture.output(round(acc_" + element2 + ", 2))";
			code.append(command);
			code.append(nextLine);
			c.parseAndEval(command);
			
			s = (REXPString) c.eval(command);
			String[] output1 = s.asStrings();
			
			resultMsg.append(command);
			for (String x: output1) {
				resultMsg.append(nextLine);
				resultMsg.append(x);
				
			}
			resultMsg.append(nextLine);
			resultMsg.append(nextLine);
		}
		
		code.append(resultMsg.toString());
		logger.debug(resultMsg.toString()); 
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("code", code.toString());
		rtnMap.put("result", resultMsg.toString());
		
		return rtnMap;
	}
	
*****/	
	
	
	public RecordSet selectStatusList(Map<String, Object> mapParam) throws Exception {
		return salePriceHistoryMgntDAO.selectStatusList(mapParam);
	}
	
	
	public RecordSet selectLstOrderList(Map<String, Object> mapParam) throws Exception {
		return salePriceHistoryMgntDAO.selectLstOrderList(mapParam);
	}
	
	
	public RecordSet selectContractList(Map<String, Object> mapParam, LoginDTO loginDTO) throws Exception {
		Map<String, Object> rowData = new HashMap<String, Object>();
		rowData.put("schCenter", mapParam.get("schCenter").toString());
		rowData.put("schUpjangCd", mapParam.get("schUpjangCd").toString());
		rowData.put("schLstDt", mapParam.get("schLstDt").toString());
		rowData.put("schStatus", mapParam.get("schStatus").toString());
		rowData.put("sabun", loginDTO.getSabun());
		
		return salePriceHistoryMgntDAO.selectContractList(rowData);
	}
	
	
	/**
	 * 식자재영업 표준단가 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveContractList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		int updRowCnt = 0;
		
		for ( int i=0; i<list.size(); i++ ){
			Map<String, Object> rowData = list.get(i);
			rowData.put("sabun", loginDTO.getSabun());
			updRowCnt += salePriceHistoryMgntDAO.saveContractList(rowData);
		}
		
		return updRowCnt;
	}
}
