package com.hwfs.sc.cmn.service;

import java.util.Map;

import hone.core.jdbc.search.SearchParameters;
import hone.core.util.record.RecordSet;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.SystemCommonDAO;

 /**
 * SystemCommonServiceImpl에 대한 설명 작성
 * @ClassName SystemCommonServiceImpl.java
 * @Description SystemCommonServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 31.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2014. 12. 31.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/systemCommonService")
public class SystemCommonServiceImpl extends DefaultServiceImpl implements SystemCommonService {

	@Resource(name="/sc/cmn/systemCommonDAO")
	SystemCommonDAO dao;
	
	/**
	 * select 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.SystemCommonService#select(hone.core.jdbc.search.SearchParameters)
	*/
	@Override
	public RecordSet select(SearchParameters parameter) {
		return dao.select(parameter);
	}

	/**
	 * selectColInfo 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.SystemCommonService#selectColInfo(java.util.Map)
	*/
	@Override
	public RecordSet selectColInfo(Map<String, Object> parameter) {
		return dao.selectColInfo(parameter);
	}

	/**
	 * selectColPkInfo 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.SystemCommonService#selectColPkInfo(java.util.Map)
	*/
	@Override
	public RecordSet selectColPkInfo(Map<String, Object> parameter) {
		return dao.selectColPkInfo(parameter);
	}

}
