package com.hwfs.rc.bms.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.AmBlEventListDAO;

 /**
 * AmBlEventListServiceImpl에 대한 설명 작성
 * @ClassName AmBlEventListServiceImpl.java
 * @Description AmBlEventListServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 24.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 7. 24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/amBlEventListService")
public class AmBlEventListServiceImpl extends DefaultServiceImpl implements AmBlEventListService {
	@Resource(name="/rc/bms/amBlEventListDAO")
	private AmBlEventListDAO amBlEventList;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.AmBlEventListService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return amBlEventList.selectList(parameter);
	}

}
