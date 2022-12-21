package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 할인 전 후 재료비율비교를 관리하는 MenuMgntInq DAO
 * 
 * @ClassName MenuMgntInqDAO.java
 * @Description MenuMgntInqDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.07.11    백승현        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 백승현
 * @since 2016.08.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Repository("/rc/rrm/menuMgntInqDAO")
public class MenuMgntInqDAO extends DefaultDAO
{
	/**
	 * 할인 전 후 재료비율비교 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.menuMgntInqDAO.selectList", mapParam);
	}
}