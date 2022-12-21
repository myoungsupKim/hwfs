package com.hwfs.rc.rcg.service;

import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcg.dao.CouponDiscardPopDAO;

 /**
 * 쿠폰 폐기 처리하는 CouponDiscardPop Service Implementation
 * 
 * @ClassName CouponDiscardPopServiceImpl.java
 * @Description CouponDiscardPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.15    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.06.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcg/couponDiscardPopService")
public class CouponDiscardPopServiceImpl extends DefaultServiceImpl implements CouponDiscardPopService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CouponDiscardPopDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponDiscardPopDAO")
	private CouponDiscardPopDAO couponDiscardPopDAO;
	
	/**
	 * 쿠폰 폐기 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int updRowCnt			= 0;
		String sChk				= "";

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData2 = list.get(i);
			
			sChk = rowData2.get("chk").toString();
			
			if(!"0".equals(sChk)){
				updRowCnt = couponDiscardPopDAO.update(rowData2);
			}
		}
		return updRowCnt;
	}
	
	/**
	 * 쿠폰 폐기 취소 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int cancel(DataSetMap list) throws Exception {
		int updRowCnt			= 0;
		String sChk				= "";

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData2 = list.get(i);
			
			sChk = rowData2.get("chk").toString();
			
			if(!"0".equals(sChk)){
				updRowCnt = couponDiscardPopDAO.cancel(rowData2);
			}
		}
		return updRowCnt;
	}
}
