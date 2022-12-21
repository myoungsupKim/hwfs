package com.hwfs.sc.scz.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 마케팅용 팝업을 호출하는 MarketingPopup DAO
 * 
 * @ClassName MarketingPopupDAO.java
 * @Description MarketingPopupDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.01   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.10.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scz/marketingPopupDAO")
public class MarketingPopupDAO extends DefaultDAO {
	
	/**
	 * 마케팅용 팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.marketingPopupDAO.selectList", mapParam);
	}

}
