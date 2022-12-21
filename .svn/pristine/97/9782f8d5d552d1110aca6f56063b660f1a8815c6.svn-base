package com.hwfs.sm.stm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.stm.dao.FmsUpjangPopDAO;

 /**
 * 사업장을 검색하는하는 FmsUpjangPop Service Implementation
 * 
 * @ClassName FmsUpjangPopServiceImpl.java
 * @Description FmsUpjangPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.23    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.06.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/stm/fmsUpjangPopService")
public class FmsUpjangPopServiceImpl extends DefaultServiceImpl implements FmsUpjangPopService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** FmsUpjangPopDAO Bean 생성 */
	@Resource(name = "/sm/stm/fmsUpjangPopDAO")
	private FmsUpjangPopDAO fmsUpjangPopDAO;
	
	/**
	 * 사업장 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return fmsUpjangPopDAO.selectList(mapParam);
	}

}
