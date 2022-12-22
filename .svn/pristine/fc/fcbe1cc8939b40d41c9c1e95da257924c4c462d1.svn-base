package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 팀정보를 검색한다.
 *
 * @ClassName TmSearchDAO.java
 * @Description TmSearchDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 10.   김재섭       최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 3. 10.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/tmSearchDAO")
public class TmSearchDAO extends DefaultDAO {

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
	public RecordSet selectTeamControl(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.cmn.tmSearchDAO.selectTeamControl", parameter);
	}

	/**
	 * 조건에 맞는 팀 정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.cmn.tmSearchDAO.selectList",
				parameter);
	}


	public RecordSet selectListAll(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.cmn.tmSearchDAO.selectListAll",
				parameter);
	}
	
	public RecordSet selectListBonbu(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.cmn.tmSearchDAO.selectListBonbu",
				parameter);
	}	
	
	public RecordSet selectAccobjList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.cmn.tmSearchDAO.selectAccobjList",
				parameter);
	}

}
