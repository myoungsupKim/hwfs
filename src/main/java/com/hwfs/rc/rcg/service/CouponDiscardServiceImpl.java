package com.hwfs.rc.rcg.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcg.dao.CouponDiscardDAO;

 /**
 * 쿠폰폐기 관리하는 CouponDiscard Service Implementation
 * 
 * @ClassName CouponDiscardServiceImpl.java
 * @Description CouponDiscardServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.12    유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.06.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcg/couponDiscardService")
public class CouponDiscardServiceImpl extends DefaultServiceImpl implements CouponDiscardService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CouponDiscardDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponDiscardDAO")
	private CouponDiscardDAO couponDiscardDAO;
	

	/**
	 * 쿠폰폐기 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return couponDiscardDAO.selectList(mapParam);
	}
	
	/**
	 * 쿠폰폐기 상세 목록을 조회한다. - 사용안함
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectDetailList(Map<String, Object> mapParam) throws Exception {
		return couponDiscardDAO.selectDetailList(mapParam);
	}

}
