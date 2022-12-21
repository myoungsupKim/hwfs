package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.TmSearchDAO;

/**
 * 팀정보를 조회한다.
 *
 * @ClassName TmSearchServiceImpl.java
 * @Description TmSearchServiceImpl Class
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
@Service("/sc/cmn/tmSearchService")
public class TmSearchServiceImpl extends DefaultServiceImpl implements
		TmSearchService {
	@Resource(name = "/sc/cmn/tmSearchDAO")
	private TmSearchDAO tmSearch;

	/**
	 * 예외적인 TM코드를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.TmSearchService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectTeamControl() throws Exception {
		Map<String, Object> parameter = new HashMap<String, Object>();
		return tmSearch.selectTeamControl(parameter);
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
	 * @see com.hwfs.sc.cmn.service.TmSearchService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return tmSearch.selectList(parameter);
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
	 * @see com.hwfs.sc.cmn.service.TmSearchService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectListAll(Map<String, Object> parameter) throws Exception {
		return tmSearch.selectListAll(parameter);
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
	 * @see com.hwfs.sc.cmn.service.TmSearchService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectListBonbu(Map<String, Object> parameter) throws Exception {
		return tmSearch.selectListBonbu(parameter);
	}	
	
	/**
	 * 2020.06.11 김명섭 월별손익보고서(수주) 팀 조회
	 * 수주물건 등록 담당부서(팀) 정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.cmn.service.TmSearchService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectAccobjList(Map<String, Object> parameter) throws Exception {
		return tmSearch.selectAccobjList(parameter);
	}

}
