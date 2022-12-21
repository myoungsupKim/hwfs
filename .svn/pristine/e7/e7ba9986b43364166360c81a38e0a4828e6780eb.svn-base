package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.SalesPerformanceByCustDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * SalesPerformanceByCust Service Implementation
 * 
 * @ClassName SalesPerformanceByCustServiceImpl.java
 * @Description SalesPerformanceByCustServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.08.27    kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : 
 * @since 2018.08.27
 * @version 1.0
 * @see 
 * <pre> 
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/salesPerformanceByCustService")
public class SalesPerformanceByCustServiceImpl extends DefaultServiceImpl implements SalesPerformanceByCustService {
	
	/** SalesPerformanceByCustDAO Bean 생성 */
	@Resource(name = "/fm/fms/salesPerformanceByCustDAO")
	private SalesPerformanceByCustDAO salesPerformanceByCustDAO;
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/**
	 * DATA를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		
		logger.debug("mapParamBefore=>"+mapParam.toString());
		
		RecordSet rsMxDt = salesPerformanceByCustDAO.selectMaxDt(mapParam);
		String lstDt = rsMxDt.get(0).getString("lstDt").toString();
		
		Date today = new Date();
        Locale currentLocale = new Locale("KOREAN", "KOREA");
        String pattern = "yyyyMMdd";
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
        
		Date edDateTemp = formatter.parse(mapParam.get("schTransDtTo").toString());
		Calendar calLstDay = Calendar.getInstance();
				 calLstDay.setTime(edDateTemp);
				 
		Date lstDate = formatter.parse(lstDt);	// 최종집계일자
		
		Date stDate = formatter.parse(mapParam.get("schTransDtFr").toString()); // Fr Date
		Date edDate = formatter.parse(mapParam.get("schTransDtTo").toString()); // TO Date
		
		if ( edDate.compareTo(lstDate) <= 0 && stDate.compareTo(lstDate) <= 0 ) {	// 집계
			
			//mapParam.put("schCurDt", formatter.format(today.getTime()));
			mapParam.put("schCurDtS", formatter.format(stDate));
			mapParam.put("schCurDtE", formatter.format(edDate));
			
		} else if ( edDate.compareTo(lstDate) > 0 && stDate.compareTo(lstDate) < 0 ) {	// 집계 + 수불
			Calendar calS = Calendar.getInstance();
            calS.setTime(lstDate);
            calS.add(Calendar.DATE, +1);
            
            Calendar calE = Calendar.getInstance();
            calE.setTime(edDate);
            	
            mapParam.put("schCurDt", formatter.format(today.getTime()));
			mapParam.put("schCurDtS", formatter.format(calS.getTime()));
			mapParam.put("schCurDtE", lstDt);
			
			mapParam.put("schTransDtTo", formatter.format(calE.getTime()));
		} else {	// 수불
			mapParam.put("schCurDt",  formatter.format(today.getTime()));
			mapParam.put("schCurDtS", formatter.format(stDate));
			mapParam.put("schCurDtE", formatter.format(edDate));
		}
		
		logger.debug("mapParamAfter=>"+mapParam.toString());			
		return salesPerformanceByCustDAO.selectList(mapParam);
	}	
}
