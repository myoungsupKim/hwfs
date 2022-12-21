package com.hwfs.ft.ftr.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SAP 전표 생성 현황(도매유통)을 조회하는 SapSlipCreateStatus DAO
 * @ClassName SapSlipCreateStatusDAO.java
 * @Description SapSlipCreateStatusDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 1. 20.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2016. 2. 3.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/ftr/sapSlipCreateStatusDAO")
public class SapSlipCreateStatusDAO extends DefaultDAO
{
	/**
	 * SAP 전표 생성 현황(도매유통) 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("ft.ftr.sapSlipCreateStatusDAO.selectList", mapParam);
	}

}
