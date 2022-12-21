package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 업장검색하는 UpjangSearch DAO
 *
 * @ClassName UpjangSearchDAO.java
 * @Description UpjangSearchDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.19   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.19
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/upjangSearchDAO")
public class UpjangSearchDAO extends DefaultDAO {

	/**
	 * 업장검색 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.upjangSearchDAO.select"
				+ mapParam.get("roleSetId"), mapParam);
	}
	
	public RecordSet selectPartList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.upjangSearchDAO.selectPart", mapParam);
	}

	public RecordSet selectAccobjList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.upjangSearchDAO.selectAccobjList", mapParam);
	}
}
