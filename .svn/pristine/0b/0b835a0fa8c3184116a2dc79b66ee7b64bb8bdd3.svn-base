package com.hwfs.sm.stm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.stm.dao.SubinvPopDAO;

 /**
 * 창고를 관리하는 SubinvPop Service Implementation
 * 
 * @ClassName SubinvPopServiceImpl.java
 * @Description SubinvPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.27    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.07.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/stm/subinvPopService")
public class SubinvPopServiceImpl extends DefaultServiceImpl implements SubinvPopService {
	
//	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SubinvPopDAO Bean 생성 */
	@Resource(name = "/sm/stm/subinvPopDAO")
	private SubinvPopDAO subinvPopDAO;
	

	/**
	 * 창고 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return subinvPopDAO.selectList(mapParam);
	}

}
