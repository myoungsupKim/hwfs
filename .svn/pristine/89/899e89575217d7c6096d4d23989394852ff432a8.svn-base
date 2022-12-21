package com.hwfs.sc.scz.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scz.dao.MarketingPopupDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 마케팅용 팝업을 호출하는 MarketingPopup Service Implementation
 * 
 * @ClassName MarketingPopupServiceImpl.java
 * @Description MarketingPopupServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.01    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.10.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scz/marketingPopupService")
public class MarketingPopupServiceImpl extends DefaultServiceImpl implements MarketingPopupService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** MarketingPopupDAO Bean 생성 */
	@Resource(name = "/sc/scz/marketingPopupDAO")
	private MarketingPopupDAO marketingPopupDAO;
	

	/**
	 * 마케팅용 팝업 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		return marketingPopupDAO.selectList(mapParam);
	}

}
