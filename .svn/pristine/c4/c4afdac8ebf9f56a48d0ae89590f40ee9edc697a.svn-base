package com.hwfs.ms.mef.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * E-FOODIST웹 매거진 조회하는 EfoodistWebzine DAO
 * 
 * @ClassName EfoodistWebzineDAO.java
 * @Description EfoodistWebzineDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 모바일(E-FOODIST웹 매거진) 강대성
 * @since 2015.03.18
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/mef/efoodistWebzineDAO")
public class EfoodistWebzineDAO extends DefaultDAO {
	
	/**
	 * E-FOODIST웹 매거진 조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mef.efoodistWebzineDAO.selectList", mapParam);
	}	
	
}
