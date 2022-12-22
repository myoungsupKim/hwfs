package com.hwfs.ft.ftr.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ft.ftr.dao.WholesaleSubulRptDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 도매유통수불현황 조회하는 WholesaleSubulRpt Service Implementation
 * 
 * @ClassName WholesaleSubulRptServiceImpl.java
 * @Description WholesaleSubulRptServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.11    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 도매유통 강대성
 * @since 2015.12.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/ftr/wholesaleSubulRptService")
public class WholesaleSubulRptServiceImpl extends DefaultServiceImpl implements WholesaleSubulRptService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** WholesaleSubulRptDAO Bean 생성 */
	@Resource(name = "/ft/ftr/wholesaleSubulRptDAO")
	private WholesaleSubulRptDAO wholesaleSubulRptDAO;
	

	/**
	 * 도매유통수불현황 조회 목록을 조회한다.
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
		return wholesaleSubulRptDAO.selectList(mapParam);
	}
	
}
