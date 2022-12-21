package com.hwfs.rc.roa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장별 용역 발생 내역을 관리하는 PartTimebyUpjang DAO
 * 
 * @ClassName PartTimebyUpjangDAO.java
 * @Description PartTimebyUpjangDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.23   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/roa/partTimebyUpjangDAO")
public class PartTimebyUpjangDAO extends DefaultDAO {
	
	/**
	 * 업장별 용역 발생 내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.roa.partTimebyUpjangDAO.selectList", mapParam);
	}
	
}
