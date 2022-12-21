package com.hwfs.rc.bms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * ProList에 대한 설명 작성
 * @ClassName ProList.java
 * @Description ProList Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 9.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 3. 9.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/bms/proListDAO")
public class ProListDAO extends DefaultDAO {
	/**
	 * selectList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.proListDAO.selectList", parameter);
	}
	public RecordSet selectMask(Map<String, Object> parameter) {
		 
		return super.queryForRecordSet("rc.bms.proListDAO.selectList", parameter);
	}

}
