package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 프로그램 권한, 권한에 맞는 메뉴목록을 조회하는 DAO
 * @ClassName AuthorityDAO.java
 * @Description AuthorityDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2.10.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 2.10.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/loadCacheDAO")
public class LoadCacheDAO extends DefaultDAO {

	/**
	 * 동적으로 로깅을 처리하기 위해 등록된 사용자 ID를 캐싱한다.
	 *
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectUserIdLog() throws Exception {
		Map<String, Object> parameter = new HashMap<String, Object>();
		return super.queryForRecordSet("sc.cmn.loadCacheDAO.selectUserIdLog", parameter);
	}
}
