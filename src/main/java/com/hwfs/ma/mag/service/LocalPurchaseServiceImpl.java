package com.hwfs.ma.mag.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ma.mag.dao.LocalPurchaseDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 현지구매내역 LocalPurchase Service Implementation
 * 
 * @ClassName LocalPurchaseServiceImpl.java
 * @Description LocalPurchaseServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.02.24	kihoon			[CH201703_00046] 최초작성
 * </pre>
 * @since 2017.02.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ma/mag/localPurchaseService")
public class LocalPurchaseServiceImpl extends DefaultServiceImpl implements LocalPurchaseService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** LocalPurchaseDAO Bean 생성 */
	@Resource(name = "/ma/mag/localPurchaseDAO")
	private LocalPurchaseDAO localPurchaseDAO;
	

	/**
	 * selectDltCdList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ma.mag.service.LocalPurchaseService#selectDltCdList(java.util.Map)
	*/
	@Override
	public RecordSet selectDltCdList(Map<String, Object> mapParam) throws Exception {
		return localPurchaseDAO.selectDltCdList(mapParam);
	}

	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ma.mag.service.LocalPurchaseService#selectList(java.util.Map)
	*/
	@Override
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return localPurchaseDAO.selectList(mapParam);
	}
}
