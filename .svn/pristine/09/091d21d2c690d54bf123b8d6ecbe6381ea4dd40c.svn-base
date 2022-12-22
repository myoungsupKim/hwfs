package com.hwfs.batch.sc.scp.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

/**
 * 미접속계정 파기주기 건에 대한 파기예정 통보를 처리한다.
 * @ClassName NonConnDstryNotiDAO.java
 * @Description NonConnDstryNotiDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 27.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 5. 27.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/scp/nonConnDstryNotiDAO")
public class NonConnDstryNotiDAO extends DefaultBatchDAO {

	/**
	 * 접속이력보유기간을 초과한 파기예정 통보건을 개인정보파기이력에 기록한다.
	 * <pre>
	 * - 중복 처리될 수 있으므로 이미 존재한 경우는 제외한다.
	 * </pre>
	 * 
	 * @param map 
	 * @return int 처리건수
	 * @exception Exception
	 */
	public int insertDstryLog(Map<String, Object> map) throws Exception {
		return update("batch.sc.scp.nonConnDstryNotiDAO.insertDstryLog", map);
	}

	/**
	 * 사용자정보에 계정상태를 파기요청상태로 기록한다.
	 * 
	 * @param map 
	 * @return int 처리건수
	 * @exception Exception
	 */
	public int updateUserAcctStatus(Map<String, Object> map) throws Exception {
		return update("batch.sc.scp.nonConnDstryNotiDAO.updateUserAcctStatus", map);
	}
	
	public String selectReqDate() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		return (String)queryForObject("batch.sc.scp.nonConnDstryNotiDAO.selectReqDate", map, String.class);
	}
}
