package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
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
import com.hwfs.fm.fms.dao.SalesPerformanceByItemDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.util.DateUtil;
import com.ifis.sc.scc.CommonUtil;
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
@Service("/fm/fms/salesPerformanceByItemService")
public class SalesPerformanceByItemServiceImpl extends DefaultServiceImpl implements SalesPerformanceByItemService {
	
	/** SalesPerformanceByItemDAO Bean 생성 */
	@Resource(name = "/fm/fms/salesPerformanceByItemDAO")
	private SalesPerformanceByItemDAO salesPerformanceByItemDAO;
	
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
		
		logger.debug("mapParam=>"+mapParam.toString());
		
		RecordSet rsCndDt = salesPerformanceByItemDAO.selectCondDt(mapParam);
		
		Map<String, Object> condDate = new HashMap<String, Object>();
		
		condDate.put("schMainUpjangCd", LimsUtil.checkNull(mapParam.get("schMainUpjangCd"), ""));
		condDate.put("schUpjangCd", LimsUtil.checkNull(mapParam.get("schUpjangCd"), ""));
		condDate.put("schTeamCd", LimsUtil.checkNull(mapParam.get("schTeamCd"), ""));
		condDate.put("schPartSalesSabun", LimsUtil.checkNull(mapParam.get("schPartSalesSabun"), ""));
		condDate.put("schCenterCd", LimsUtil.checkNull(mapParam.get("schCenterCd"), ""));
		condDate.put("schPriceGnb", LimsUtil.checkNull(mapParam.get("schPriceGnb"), ""));
		condDate.put("schChk1", mapParam.get("schChk1").toString());
		condDate.put("schChk2", mapParam.get("schChk2").toString());
		condDate.put("schChk3", mapParam.get("schChk3").toString());
		
		
		for ( int i=0; i<rsCndDt.size(); i++ ) {
			Integer SumYn = rsCndDt.get(i).getInt("sumYn");
			switch ( SumYn ) {
				case 0 :	// live
					condDate.put("liveFr",  rsCndDt.get(i).getString("strdd"));
					condDate.put("liveTo",  rsCndDt.get(i).getString("enddd"));
					
					if ( 0 < rsCndDt.get(i).getInt("sumYn") && i != 0 ) {
						condDate.put("liveFr1",  rsCndDt.get(i).getString("strdd"));
						condDate.put("liveTo1",  rsCndDt.get(i).getString("enddd"));
					}
					break;
					
				case 1 :	// sum
					condDate.put("sumFr",  rsCndDt.get(i).getString("strdd"));
					condDate.put("sumTo",  rsCndDt.get(i).getString("enddd"));
					break;
				
				default :
					break;
			}
		}
		
		//String lstDt = rsMxDt.get(0).getString("lstDt").toString();
		/*
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
		
		int dayGap = DateUtil.getGapForDay(mapParam.get("schTransDtFr").toString(), mapParam.get("schTransDtTo").toString());
		
		// 시작일이 1일 여부
		if ( "01".equals(mapParam.get("schTrnasDtFr").toString().substring(6, 8)) ) {
			// 시작일 기준 당월 기간내 포함여부
			if ( edDate.compareTo(
						formatter.parse(
								DateUtil.getLastDay(
										mapParam.get("schTransDtFr").toString()
										)
								)
						) <=0 ) {
				
			}
		} else {
			
		}
		
		
		
		
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
		*/
		logger.debug("condDate=>"+condDate.toString());			
		return salesPerformanceByItemDAO.selectList(condDate);
	}	
}
