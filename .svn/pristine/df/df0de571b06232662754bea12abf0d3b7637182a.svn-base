package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fms.dao.SaleMonthlySumCustDAO;
import com.hwfs.ls.cmn.util.LimsUtil;

 /**
 * SaleMonthlySumCustServiceImpl Service Implementation
 * 
 * @ClassName SaleMonthlySumCustServiceImpl.java
 * @Description SaleMonthlySumCustServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.07.23    kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 kihoon
 * @since 2018.07.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/saleMonthlySumCustService")
public class SaleMonthlySumCustServiceImpl extends DefaultServiceImpl implements SaleMonthlySumCustService {
	
	/** saleMonthlySumCustDAO Bean 생성 */
	@Resource(name = "/fm/fms/saleMonthlySumCustDAO")
	private SaleMonthlySumCustDAO saleMonthlySumCustDAO;
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		
		RecordSet rs = saleMonthlySumCustDAO.selectPeriod(mapParam);
		String pDate = rs.get(0).getString("pDate").toString();
		mapParam.put("schPeriod", pDate);
		String condTerm = "";
		String[] term  = pDate.split(",");
		for( String cond : term ) {
			condTerm += ", NVL(\"" + cond.trim() + "_MARGIN\", 0) AS \"" + cond.trim() + "_MARGIN\"";
			condTerm += " , NVL(\"" + cond.trim() + "_PROFIT_RATIO\", 0) AS \"" + cond.trim() + "_PROFIT_RATIO\"";
			condTerm += " , NVL(\"" + cond.trim() + "_SALE\", 0) AS \"" + cond.trim() + "_SALE\"";
			condTerm += " , NVL(\"" + cond.trim() + "_SALE_VAT_T\", 0) AS \"" + cond.trim() + "_SALE_VAT_T\"";
		}
		
		if ( term.length == 2 ) {
			condTerm += ", NVL(\"" + term[term.length-2].trim() + "_MARGIN\", 0) - NVL(\"" + term[term.length-1].trim() + "_MARGIN\", 0)  AS \"GAP_MARGIN\"";
			condTerm += " , NVL(\"" + term[term.length-2].trim() + "_PROFIT_RATIO\", 0) - NVL(\"" + term[term.length-1].trim() + "_PROFIT_RATIO\", 0) AS \"GAP_PROFIT_RATIO\"";
			condTerm += " , NVL(\"" + term[term.length-2].trim() + "_SALE\", 0) - NVL(\"" + term[term.length-1].trim() + "_SALE\", 0) AS \"GAP_SALE\"";
			condTerm += " , NVL(\"" + term[term.length-2].trim() + "_SALE_VAT_T\", 0) - NVL(\"" + term[term.length-1].trim() + "_SALE_VAT_T\", 0) AS \"GAP_SALE_VAT_T\"";
		}
		
		mapParam.put("schCondTerm", condTerm);
		Date today = new Date();
        Locale currentLocale = new Locale("KOREAN", "KOREA");
        String pattern = "yyyyMMdd";
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
        
        RecordSet rsMxDt = saleMonthlySumCustDAO.selectMaxDt(mapParam);
		String lstDt = rsMxDt.get(0).getString("lstDt").toString();
		
		logger.debug("mapParamBefore=>"+mapParam.toString());
		
		//Date edDateTemp = formatter.parse(mapParam.get("schEdDate").toString()+"01");
		Date edDateTemp = formatter.parse(mapParam.get("schEdDate").toString());
		Calendar calLstDay = Calendar.getInstance();
				 calLstDay.setTime(edDateTemp);
		
		int lstDayOfMonth = calLstDay.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		Date lstDate = formatter.parse(lstDt);	// 최종집계일자
		//Date edDate = formatter.parse(mapParam.get("schEdDate").toString()+lstDayOfMonth); // TO Date
		Date edDate = formatter.parse(mapParam.get("schEdDate").toString()); // TO Date
		 
		int diffYear = lstDate.getYear() - edDate.getYear();
		int diffMonth = (diffYear * 12 + edDate.getMonth()) - (diffYear * 12 + lstDate.getMonth());
		
		logger.debug("edDateTemp=>"+edDateTemp);
		logger.debug("edDate.getMonth()=>"+edDate.getMonth());
		logger.debug("lstDate.getMonth()=>"+lstDate.getMonth());
		logger.debug("lstDt=>"+lstDt);
		logger.debug("lstDayOfMonth=>"+lstDayOfMonth);
		logger.debug("lstDate=>"+lstDate);
		logger.debug("edDate=>"+edDate);
		logger.debug("diffMonth=>"+diffMonth);
		logger.debug("edDate.compareTo(lstDate)=>"+edDate.compareTo(lstDate));
		
		if ( edDate.compareTo(lstDate) <= 0 ) {
			mapParam.put("schCurMonth", null);
			mapParam.put("schEdDate", formatter.format(edDate));
		} else if ( edDate.compareTo(lstDate) > 0 ) {
			Calendar calS = Calendar.getInstance();
            calS.setTime(lstDate);
            //calS.add(Calendar.MONTH, diffMonth);		
            calS.add(Calendar.DATE, +1);
            
            Calendar calE = Calendar.getInstance();
            calE.setTime(edDate);
            	
            mapParam.put("schCurMonth", formatter.format(today));
			mapParam.put("schCurMonthS", formatter.format(calS.getTime()));
			mapParam.put("schCurMonthE", formatter.format(calE.getTime()));
			
			mapParam.put("schEdDate", lstDt);
		}
		
		/*
		if ( diffMonth > 0 ) {
			mapParam.put("schCurMonth", null);
		} else if (diffMonth < 0 ) {
			
            Calendar calS = Calendar.getInstance();
            calS.setTime(edDate);
            calS.add(Calendar.MONTH, diffMonth);		
            calS.add(Calendar.DATE, +1);
            
            Calendar calE = Calendar.getInstance();
            calE.setTime(edDate);
            	
            mapParam.put("schCurMonth", formatter.format(today));
			mapParam.put("schCurMonthS", formatter.format(calS.getTime()));
			mapParam.put("schCurMonthE", formatter.format(calE.getTime()));

		} else {
			mapParam.put("schCurMonth", null);
		}
		
		mapParam.put("schEdDate", lstDt);
		*/
		logger.debug("mapParamAfter=>"+mapParam.toString());
		return saleMonthlySumCustDAO.selectList(mapParam);
	}
}
