package com.hwfs.batch.sc.scp.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

/**
 * 개인정보열람 자동 사후승인을 처리한다.
 * @ClassName AutoAfterApprovDAO.java
 * @Description AutoAfterApprovDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 09.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 5. 26.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/scp/autoAfterApprovDAO")
public class AutoAfterApprovDAO extends DefaultBatchDAO {

	/**
	 * 개인정보열람 자동 사후승인을 처리한다.
	 * 
	 * @return int 승인건수
	 * @exception Exception
	 */
	public int approve() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		return update("batch.sc.scp.autoAfterApprovDAO.approve", map);
	}

	/**
	 * 자동 사후승인자를 조회한다.
	 *
	 * @return 사후승인자
	 * @throws Exception
	 */
	public String selectApproveSabun() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		return (String)queryForObject("batch.sc.scp.autoAfterApprovDAO.selectApproveSabun", map, String.class);
	}

}
