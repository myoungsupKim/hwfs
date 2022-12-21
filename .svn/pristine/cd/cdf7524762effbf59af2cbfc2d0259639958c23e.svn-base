package com.hwfs.rc.rcg.service;

import hone.online.xplatform.map.DataSetMap;

 /**
 * 쿠폰 폐기 처리하는 CouponDiscardPop Service Interface
 * 
 * @ClassName CouponDiscardPopService.java
 * @Description CouponDiscardPopService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.15    JUN        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.06.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface CouponDiscardPopService {

	/**
	 * 쿠폰 폐기 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;
	
	/**
	 * 쿠폰 폐기 취소처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int cancel(DataSetMap list) throws Exception;
}
