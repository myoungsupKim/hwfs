package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.FindUpjangDAO;

 /**
 * 사업장을 조회하는 FindUpjang Service Implementation
 * 
 * @ClassName FindUpjangServiceImpl.java
 * @Description FindUpjangServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.16    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.06.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/findUpjangService")
public class FindUpjangServiceImpl extends DefaultServiceImpl implements FindUpjangService {
	
	/** FindUpjangDAO Bean 생성 */
	@Resource(name = "/sc/cmn/findUpjangDAO")
	private FindUpjangDAO findUpjangDAO;
	

	/**
	 * 사업장 목록을 조회한다.
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
		return findUpjangDAO.selectList(mapParam);
	}

}
