package com.hwfs.rc.rcm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * NonCloseMgntDAO에 대한 설명 작성
 * @ClassName NonCloseMgntDAO.java
 * @Description NonCloseMgntDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 4. 01.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2016. 4. 01.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rcm/nonCloseMgntDAO")
public class NonCloseMgntDAO extends DefaultDAO
{
	/**
	 * 미마감현황 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcm.nonCloseMgntDAO.selectList", mapParam);
	}
}
