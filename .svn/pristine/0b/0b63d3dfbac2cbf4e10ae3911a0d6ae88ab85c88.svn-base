package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.MenuEngineeringToolDAO;

 /**
 * MenuEngineeringTool을 관리하는 MenuEngineeringTool Service Implementation
 * 
 * @ClassName MenuEngineeringToolServiceImpl.java
 * @Description MenuEngineeringToolServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.08    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.07.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rrm/menuEngineeringToolService")
public class MenuEngineeringToolServiceImpl extends DefaultServiceImpl implements MenuEngineeringToolService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** MenuEngineeringToolDAO Bean 생성 */
	@Resource(name = "/rc/rrm/menuEngineeringToolDAO")
	private MenuEngineeringToolDAO menuEngineeringToolDAO;
	

	/**
	 * MenuEngineeringTool 목록을 조회한다.
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
		return menuEngineeringToolDAO.selectList(mapParam);
	}

}
