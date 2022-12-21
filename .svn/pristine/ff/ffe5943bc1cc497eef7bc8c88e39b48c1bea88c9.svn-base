package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * MenuEngineeringTool을 관리하는 MenuEngineeringTool DAO
 * 
 * @ClassName MenuEngineeringToolDAO.java
 * @Description MenuEngineeringToolDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.08   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.07.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/menuEngineeringToolDAO")
public class MenuEngineeringToolDAO extends DefaultDAO {
	
	/**
	 * MenuEngineeringTool 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.menuEngineeringToolDAO.selectList", mapParam);
	}

}
