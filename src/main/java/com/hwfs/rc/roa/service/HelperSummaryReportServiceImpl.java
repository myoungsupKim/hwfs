package com.hwfs.rc.roa.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.roa.dao.HelperSummaryReportDAO;

 /**
 * Helper 지원현황 집계를 관리하는 HelperSummaryReport Service Implementation
 * 
 * @ClassName HelperSummaryReportServiceImpl.java
 * @Description HelperSummaryReportServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.28    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/roa/helperSummaryReportService")
public class HelperSummaryReportServiceImpl extends DefaultServiceImpl implements HelperSummaryReportService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** HelperSummaryReportDAO Bean 생성 */
	@Resource(name = "/rc/roa/helperSummaryReportDAO")
	private HelperSummaryReportDAO helperSummaryReportDAO;
	

	/**
	 * Helper 지원현황 집계 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return helperSummaryReportDAO.selectList(mapParam);
	}

}
