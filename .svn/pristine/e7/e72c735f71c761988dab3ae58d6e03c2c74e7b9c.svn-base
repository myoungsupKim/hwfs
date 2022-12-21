package com.hwfs.rc.rcm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcm.dao.CloseStatusDAO;

 /**
 * 마감현황을 조회하는 CloseStatus Service Implementation
 * 
 * @ClassName CloseStatusServiceImpl.java
 * @Description CloseStatusServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.03    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.08.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcm/closeStatusService")
public class CloseStatusServiceImpl extends DefaultServiceImpl implements CloseStatusService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CloseStatusDAO Bean 생성 */
	@Resource(name = "/rc/rcm/closeStatusDAO")
	private CloseStatusDAO closeStatusDAO;
	
	/**
	 * 마감현황 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return closeStatusDAO.selectList(mapParam);
	}

	/**
	 * 마감현황 상세목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectDtlList(Map<String, Object> mapParam) throws Exception {
		return closeStatusDAO.selectDtlList(mapParam);
	}
	
}
