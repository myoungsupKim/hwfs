package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 조직정보를 조회한다.
 * 
 * @ClassName OrgChoiceDAO.java
 * @Description OrgChoiceDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 11.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 3. 11.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/orgChoiceDAO")
public class OrgChoiceDAO extends DefaultDAO {

	/**
	 * 조직 정보를 조회한다.
	 * 
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 * 
	 * @param parameter
	 * @return
	 */
	public RecordSet selectList() throws Exception {
		Map<String, Object> parameter = new HashMap<String, Object>();

		return super.queryForRecordSet("sc.cmn.orgChoiceDAO.selectList",
				parameter);
	}
}
