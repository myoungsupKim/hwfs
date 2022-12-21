package com.hwfs.fm.fmf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmf.dao.GainRateSummaryDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 실적율집계하는 GainRateSummary Service Implementation
 * 
 * @ClassName GainRateSummaryServiceImpl.java
 * @Description GainRateSummaryServiceImpl Class
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
@Service("/fm/fmf/gainRateSummaryService")
public class GainRateSummaryServiceImpl extends DefaultServiceImpl implements GainRateSummaryService {
	
	/** GainRateSummaryDAO Bean 생성 */
	@Resource(name = "/fm/fmf/gainRateSummaryDAO")
	private GainRateSummaryDAO gainRateSummaryDAO;
	

	/**
	 * 이익율 실적집계 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return gainRateSummaryDAO.selectList(mapParam);
	}

}
