package com.hwfs.ft.ftr.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 미착 재고 조회하는 NonArrivinventory DAO
 * 
 * @ClassName NonArrivinventoryDAO.java
 * @Description NonArrivinventoryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.10.24   	김명섭        최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2019.10.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/ftr/nonArrivinventoryDAO")
public class NonArrivinventoryDAO extends DefaultDAO {
	
	/**
	 * 미착 재고를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ft.ftr.nonArrivinventoryDAO.selectList", mapParam);
	}
	
	public RecordSet selectHist(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ft.ftr.nonArrivinventoryDAO.selectHist", mapParam);
	}
}
