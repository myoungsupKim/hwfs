package com.hwfs.sm.spm.service;

import hone.core.util.record.RecordSet;
//import hone.online.xplatform.XplatformConstants;
//import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.spm.dao.AdvanceAlterDAO;

//import com.tobesoft.xplatform.data.DataSet;

 /**
 * 선수금대체를하는 AdvanceAlter Service Implementation
 * 
 * @ClassName AdvanceAlterServiceImpl.java
 * @Description AdvanceAlterServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.30    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.03.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/spm/advanceAlterService")
public class AdvanceAlterServiceImpl extends DefaultServiceImpl implements AdvanceAlterService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AdvanceAlterDAO Bean 생성 */
	@Resource(name = "/sm/spm/advanceAlterDAO")
	private AdvanceAlterDAO advanceAlterDAO;

	/**
	 * 선수금대체 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return advanceAlterDAO.selectList(mapParam);
	}
}
