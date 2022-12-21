package com.hwfs.fm.fmf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 이익율 실적집계하는 GainRateSummary DAO
 * 
 * @ClassName GainRateSummaryDAO.java
 * @Description GainRateSummaryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.01.05   CSY        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 CSY
 * @since 2016.01.05
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmf/gainRateSummaryDAO")
public class GainRateSummaryDAO extends DefaultDAO {
	
	/**
	 * 매입매출집계 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.gainRateSummaryDAO.selectListTab"+mapParam.get("tabIndex"), mapParam);
	}

	
}
