package com.hwfs.fm.fmf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 월별매출집계 SaleSumYear DAO
 * 
 * @ClassName SaleSumYearDAO.java
 * @Description SaleSumYearDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.10.19     유선미	  최초생성
 * </pre>
 * @author 유선미
 * @since 2017.10.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmf/saleSumYearDAO")
public class SaleSumYearDAO extends DefaultDAO {
	
	/**
	 * 월별매출집계 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.saleSumYearDAO.selectList", mapParam);
	}
}
