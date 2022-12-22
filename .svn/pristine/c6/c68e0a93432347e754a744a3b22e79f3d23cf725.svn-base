package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.UserSearchDAO;

 /**
 * UserSearchServiceImpl에 대한 설명 작성
 * @ClassName UserSearchServiceImpl.java
 * @Description UserSearchServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 30.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 1. 30.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/userSearchService")
public class UserSearchServiceImpl extends DefaultServiceImpl implements UserSearchService {
	@Resource(name="/sc/cmn/userSearchDAO")
	private UserSearchDAO userSearch;
	
	/**
	 * 조건에 해당하는 사용자정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.UserSearchService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) {
		return userSearch.selectList(parameter);
	}

}
