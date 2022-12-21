package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.MuSearchDAO;

 /**
 * MuSearchServiceImpl에 대한 설명 작성
 * @ClassName MuSearchServiceImpl.java
 * @Description MuSearchServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 22.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 4. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/muSearchService")
public class MuSearchServiceImpl extends DefaultServiceImpl implements MuSearchService {
	@Resource(name = "/sc/cmn/muSearchDAO")
	private MuSearchDAO muSearch;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.service.MuSearchService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList() throws Exception {
		return muSearch.selectList();
	}

	/**
	 * 전체 MU
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.service.MuSearchService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectAllList() throws Exception {
		return muSearch.selectAllList();
	}

}
