package com.hwfs.ms.cmn.util;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.ls.cmn.util.LimsUtil;

 /**
 * 견적서내용을 html탬플릿에 맞게 파싱한다.
 *
 * @ClassName CreateInspectIssuePdf.java
 * @Description CreateInspectIssuePdf Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 17.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 17.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class CreateEstimateReport {
	/** LogService */
	static Logger logger = LoggerFactory.getLogger(LimsUtil.class);
	
    public static String createHtml(Map<String, Object> paramMap) throws Exception {
    	
    	StringBuilder strBuilder = new StringBuilder();
        FileInputStream fis = new FileInputStream(LimsUtil.checkNull(paramMap.get("htmlFile")));
        BufferedReader br = new BufferedReader(new InputStreamReader(fis, "UTF-8"));
        
    	try{
    		
    		DecimalFormat num = new DecimalFormat("#,###");
        	
            String line;
            while ((line = br.readLine()) != null) {
                strBuilder.append(line);
            }
            
            String strContent = strBuilder.toString();
            
            strContent = strContent.replace("{고객사명}", LimsUtil.checkNull(paramMap.get("emailName")));
            strContent = strContent.replace("{견적서아이디}", LimsUtil.checkNull(paramMap.get("schEstiId")));
            strContent = strContent.replace("{견적적용기간}", LimsUtil.checkNull(paramMap.get("schDate1"))+ " ~ " +LimsUtil.checkNull(paramMap.get("schDate2")));
            
            StringBuffer testResult = new StringBuffer();
            RecordSet testResultList = (RecordSet) paramMap.get("testResultList");
            for (Record tr : testResultList) {
            	testResult.append("<tr>");
                testResult.append("<td width=100 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("itemName"))+"</span></p>");
                testResult.append("</td>");
                testResult.append("<td width=50 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("className"))+"</span></p>");
                testResult.append("</td>");
                testResult.append("<td width=60 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("itemCode"))+"</span></p>");
                testResult.append("</td>");
                testResult.append("<td width=300 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("itemSize"))+"</span></p>");
                testResult.append("</td>");
                testResult.append("<td width=50 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("itemUnit"))+"</span></p>");
                testResult.append("</td>");
                testResult.append("<td width=80 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+num.format(((BigDecimal)tr.get("estiAmt")))+"</span></p>");
                testResult.append("</td>");
                testResult.append("<td width=50 style=\"height:20px;font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;\"><p><span>"+LimsUtil.checkNull(tr.get("dDays"))+"</span></p>");
                testResult.append("</td>");
                testResult.append("</tr>");
            }
            strContent = strContent.replace("{{견적서내용}}", testResult.toString());
            
            strContent = strContent.replace("{작성일자}", LimsUtil.getDate("yyyy년 MM월 dd일"));
            
            return strContent;
    		
    	}catch (Exception e) {
    		logger.error(e.getMessage());
        } finally {
            if(fis != null)  try { fis.close(); } catch (Exception e)  {logger.error(e.getMessage());}
            if(br != null) try { br.close(); } catch (Exception e) {logger.error(e.getMessage());}
        }
		
    	return null;    	
    }

}
