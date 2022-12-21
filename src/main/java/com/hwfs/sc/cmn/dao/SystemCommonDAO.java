package com.hwfs.sc.cmn.dao;

import java.util.Map;

import hone.core.jdbc.search.SearchParameters;
import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SystemCommonDao에 대한 설명 작성
 * @ClassName SystemCommonDao.java
 * @Description SystemCommonDao Class 
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
@Repository("/sc/cmn/systemCommonDAO")
public class SystemCommonDAO extends DefaultDAO {
	
	public RecordSet select(SearchParameters parameter) {
		return queryForRecordSet("sc.cmn.systemCommon.select"+parameter.getString("qid"), parameter);
	}
	
	public RecordSet selectColInfo(Map<String, Object> parameter) {
		return super.queryForRecordSet("sc.cmn.systemCommon.selectColInfo", parameter);
	}
	
	public RecordSet selectColPkInfo(Map<String, Object> parameter) {
		return super.queryForRecordSet("sc.cmn.systemCommon.selectColPkInfo", parameter);
	}
}
