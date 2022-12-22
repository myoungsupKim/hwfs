package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.ScSearchDAO;

/**
 * 본부정보를 조회한다.
 *
 * @ClassName ScSearchServiceImpl.java
 * @Description ScSearchServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 10.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 3. 10.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/scSearchService")
public class ScSearchServiceImpl extends DefaultServiceImpl implements
		ScSearchService {
	@Resource(name = "/sc/cmn/scSearchDAO")
	private ScSearchDAO scSearch;

	/**
	 * 예외적인 SC코드를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.ScSearchService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectScControl() throws Exception {
		Map<String, Object> parameter = new HashMap<String, Object>();
		return scSearch.selectScControl(parameter);
	}

	/**
	 * 조회 조건에 맞는 팀정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.ScSearchService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return scSearch.selectList(parameter);
	}

	/**
	 * 조회 조건에 맞는 본부정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.ScSearchService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectListAll(Map<String, Object> parameter) throws Exception {
		return scSearch.selectListAll(parameter);
	}
}
