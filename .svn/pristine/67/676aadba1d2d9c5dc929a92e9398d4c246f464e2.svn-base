package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * MuSearchDAO에 대한 설명 작성
 * @ClassName MuSearchDAO.java
 * @Description MuSearchDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 22.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 4. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/muSearchDAO")
public class MuSearchDAO extends DefaultDAO {

	public RecordSet selectList() throws Exception {
		Map<String, Object> parameter = new HashMap<String, Object>();
		return super.queryForRecordSet("sc.cmn.muSearchDAO.selectList", parameter);
	}

	public RecordSet selectAllList() throws Exception {
		Map<String, Object> parameter = new HashMap<String, Object>();
		return super.queryForRecordSet("sc.cmn.muSearchDAO.selectAllList", parameter);
	}
}
