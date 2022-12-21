package com.hwfs.batch.sc.scp.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

/**
 * 미접속계정 잠김주기 건에 대한 처리한다.
 * @ClassName NonConnLockDAO.java
 * @Description NonConnLockDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 28.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 5. 27.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/scp/nonConnLockDAO")
public class NonConnLockDAO extends DefaultBatchDAO {

	/**
	 * 사용자정보에 계정상태를 잠김상태로 기록한다.
	 * 
	 * @param map 
	 * @return int 처리건수
	 * @exception Exception
	 */
	public int updateUserAcctStatusToLock(Map<String, Object> map) throws Exception {
		return update("batch.sc.scp.nonConnLockDAO.updateUserAcctStatusToLock", map);
	}

}
