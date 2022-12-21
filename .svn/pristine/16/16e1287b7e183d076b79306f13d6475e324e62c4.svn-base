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
import com.hwfs.ft.ftr.dao.NonArrivinventoryDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 미착 재고 조회하는 NonArrivinventory Service Implementation
 * 
 * @ClassName NonArrivinventoryServiceImpl.java
 * @Description NonArrivinventoryServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.10.24    김명섭        최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2019.10.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/ftr/nonArrivinventoryService")
public class NonArrivinventoryServiceImpl extends DefaultServiceImpl implements NonArrivinventoryService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** WholesaleSubulRptDAO Bean 생성 */
	@Resource(name = "/ft/ftr/nonArrivinventoryDAO")
	private NonArrivinventoryDAO nonArrivinventoryDAO;
	

	/**
	 * 미착 재고를 조회한다.
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
		return nonArrivinventoryDAO.selectList(mapParam);
	}
	
	public RecordSet selectHist(Map<String, Object> mapParam) throws Exception {
		return nonArrivinventoryDAO.selectHist(mapParam);
	}
}
