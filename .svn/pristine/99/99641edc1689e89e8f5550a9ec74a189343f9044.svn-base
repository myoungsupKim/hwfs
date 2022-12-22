package com.hwfs.ms.msc.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ms.msc.dao.SaniCheckResultDetailDAO;

 /**
 * 위생점검결과조회 SaniCheckResultDetail Service Implementation
 * 
 * @ClassName FoodReservesReportServiceImpl.java
 * @Description FoodReservesReportServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.29                최초생성
 * </pre>
 * @author 
 * @since 2022.07.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/msc/saniCheckResultDetailService")
public class SaniCheckResultDetailServiceImpl extends DefaultServiceImpl implements SaniCheckResultDetailService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** FoodReservesReportDAO Bean 생성 */
	@Resource(name = "/ms/msc/saniCheckResultDetailDAO")
	private SaniCheckResultDetailDAO saniCheckResultDetailDAO;		
	
	/**
	 * 위생점검결과 목록을 조회한다.
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		if(mapParam.get("upjang").equals("undefined")) {
			mapParam.put("upjang", "");
		}
		return saniCheckResultDetailDAO.selectList(mapParam);
	}
}
