package com.hwfs.rc.rcm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcm.dao.NonCloseListDAO;

 /**
 * 미마감현황을 조회하는 NonCloseList Service Implementation
 * 
 * @ClassName NonCloseListServiceImpl.java
 * @Description NonCloseListServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.08    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.09.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcm/nonCloseListService")
public class NonCloseListServiceImpl extends DefaultServiceImpl implements NonCloseListService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** NonCloseListDAO Bean 생성 */
	@Resource(name = "/rc/rcm/nonCloseListDAO")
	private NonCloseListDAO nonCloseListDAO;
	

	/**
	 * 미마감현황 목록을 조회한다.
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
		return nonCloseListDAO.selectList(mapParam);
	}

}
