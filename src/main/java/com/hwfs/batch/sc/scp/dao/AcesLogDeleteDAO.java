package com.hwfs.batch.sc.scp.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

/**
 * 개인정보접근로그 보유기간이 지난 로그를 삭제 처리한다.
 * @ClassName AcesLogDeleteDAO.java
 * @Description AcesLogDeleteDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 7.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 7. 7.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/scp/acesLogDeleteDAO")
public class AcesLogDeleteDAO extends DefaultBatchDAO {

	/**
	 * 개인정보접근로그 보유기간이 지난 로그를 삭제 처리한다.
	 * 
	 * @return int 삭제건수
	 * @exception Exception
	 */
	public int deleteAcesLog() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		return update("batch.sc.scp.acesLogDeleteDAO.deleteAcesLog", map);
	}

	/**
	 * 사용자 액션로그 보유기간이 지난 로그를 삭제 처리한다.
	 * 
	 * @return int 삭제건수
	 * @exception Exception
	 */
	public int deleteActionLog() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		return update("batch.sc.scp.acesLogDeleteDAO.deleteActionLog", map);
	}

	/**
	 * 오류로그 보유기간이 지난 로그를 삭제 처리한다.
	 * 
	 * @return int 삭제건수
	 * @exception Exception
	 */
	public int deleteErrorLog() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		return update("batch.sc.scp.acesLogDeleteDAO.deleteErrorLog", map);
	}
}
