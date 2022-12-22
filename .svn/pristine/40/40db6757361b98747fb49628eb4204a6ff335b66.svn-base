package com.hwfs.sm.saa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사고 거래선 현황하는 AccdClientList DAO
 * 
 * @ClassName AccdClientListDAO.java
 * @Description AccdClientListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.29   	김미경        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김미경
 * @since 2015.05.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/saa/accdClientListDAO")
public class AccdClientListDAO extends DefaultDAO {
	
	/**
	 * 기간별 사고거래선에 대한 채권현황을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.saa.accdClientListDAO.selectList", mapParam);
	}
	
}
