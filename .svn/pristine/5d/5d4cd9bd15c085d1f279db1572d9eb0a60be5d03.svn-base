package com.hwfs.sc.scc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 테스트 결과를 조회한다.
 * @ClassName Scc99999pDAO.java
 * @Description Scc99999pDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 13.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 3. 13.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scc/scc99999pDAO")
public class Scc99999pDAO extends DefaultDAO {

	/**
	 * PL 테스트 결과 조회
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public RecordSet selectPlTestList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.scc.scc99999pDAO.selectPlTestList", parameter);
	}

	/**
	 * PI 테스트 결과 조회
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public RecordSet selectPiTestList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.scc.scc99999pDAO.selectPiTestList", parameter);
	}
}
