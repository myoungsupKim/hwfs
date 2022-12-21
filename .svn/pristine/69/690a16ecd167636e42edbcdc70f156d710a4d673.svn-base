package com.hwfs.ms.mes.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 주변사업장보기하는 SurroundWorkplaceView DAO
 * 
 * @ClassName SurroundWorkplaceViewDAO.java
 * @Description SurroundWorkplaceViewDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.23   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 현장지원_모바일 강대성
 * @since 2015.04.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/mes/surroundWorkplaceViewDAO")
public class SurroundWorkplaceViewDAO extends DefaultDAO {
	
	/**
	 * 주변사업장보기(위도, 경도 불러오기) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mes.surroundWorkplaceViewDAO.selectList", mapParam);
	}	
	
}
