package com.hwfs.rc.rcm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcm.dao.NonCloseListPopDAO;

 /**
 * 미마감상세를 조회하는 NonCloseListPop Service Implementation
 * 
 * @ClassName NonCloseListPopServiceImpl.java
 * @Description NonCloseListPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.09    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.09.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcm/nonCloseListPopService")
public class NonCloseListPopServiceImpl extends DefaultServiceImpl implements NonCloseListPopService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** NonCloseListPopDAO Bean 생성 */
	@Resource(name = "/rc/rcm/nonCloseListPopDAO")
	private NonCloseListPopDAO nonCloseListPopDAO;
	

	/**
	 * 미마감상세 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return nonCloseListPopDAO.selectList(mapParam);
	}

}
