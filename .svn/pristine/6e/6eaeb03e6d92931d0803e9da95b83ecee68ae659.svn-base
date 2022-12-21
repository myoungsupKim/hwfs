package com.hwfs.rc.rcg.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 쿠폰 폐기 처리하는 CouponDiscardPop DAO
 * 
 * @ClassName CouponDiscardPopDAO.java
 * @Description CouponDiscardPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.15   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.06.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rcg/couponDiscardPopDAO")
public class CouponDiscardPopDAO extends DefaultDAO {
	
	/**
	 * 쿠폰 폐기 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponDiscardPopDAO.update", mapParam);
	}
	
	/**
	 * 쿠폰 폐기취소 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancel(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponDiscardPopDAO.cancel", mapParam);
	}
	
}
