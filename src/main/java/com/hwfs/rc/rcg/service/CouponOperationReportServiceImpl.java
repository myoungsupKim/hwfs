package com.hwfs.rc.rcg.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcg.dao.CouponOperationReportDAO;

 /**
 * 쿠폰종류별 집계현황을 관리하는 CouponOperationReport Service Implementation
 * 
 * @ClassName CouponOperationReportServiceImpl.java
 * @Description CouponOperationReportServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.05    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.06.05
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcg/couponOperationReportService")
public class CouponOperationReportServiceImpl extends DefaultServiceImpl implements CouponOperationReportService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CouponOperationReportDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponOperationReportDAO")
	private CouponOperationReportDAO couponOperationReportDAO;
	

	/**
	 * 쿠폰종류별 집계현황 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return couponOperationReportDAO.selectList(mapParam);
	}

}
