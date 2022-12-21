package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * UserSearchDAO에 대한 설명 작성
 * @ClassName UserSearchDAO.java
 * @Description UserSearchDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 30.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 1. 30.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/userSearchDAO")
public class UserSearchDAO extends DefaultDAO {

	/**
	 * 조건에 해당하는 사용자정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) {

		if (parameter.containsKey("forcedUserGroup") && !"".equals(parameter.get("forcedUserGroup"))) {
			List<String> forcedUserGroup = new ArrayList<String>();
			forcedUserGroup = Arrays.asList(parameter.get("forcedUserGroup").toString().split(","));
			
			/*String[] forced = ;
			for (int i = 0 ; i < forced.length ; i++) {
				forcedUserGroup.add(forced[i]);
			}*/

			parameter.put("forcedUserGroup", forcedUserGroup);
		}

		return super.queryForRecordSet("sc.cmn.userSearchDAO.selectList", parameter);
	}
}
