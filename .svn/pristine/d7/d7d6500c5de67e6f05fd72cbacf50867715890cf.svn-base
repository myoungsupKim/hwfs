package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 *
 * @ClassName ResizeImageDAO.java
 * @Description ResizeImageDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.08.10   	kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : kihoon
 * @since 2017.08.10
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/resizeImageDAO")
public class ResizeImageDAO extends DefaultDAO {

	/**
	 * 대상 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet select() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		return super.queryForRecordSet("sc.cmn.resizeImageDAO.select", mapParam);
	}
}
