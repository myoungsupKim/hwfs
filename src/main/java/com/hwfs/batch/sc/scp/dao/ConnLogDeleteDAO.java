package com.hwfs.batch.sc.scp.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

/**
 * 접속이력보유기간을 초과한 접속이력을 파기처리한다.
 * @ClassName ConnLogDeleteDAO.java
 * @Description ConnLogDeleteDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 26.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 5. 26.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sc/scp/connLogDeleteDAO")
public class ConnLogDeleteDAO extends DefaultBatchDAO {

	/**
	 * 접속이력보유기간을 초과한 접속이력을 삭제한다.
	 * 
	 * @return int 삭제건수
	 * @exception Exception
	 */
	public int delete() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		return update("batch.sc.scp.connLogDeleteDAO.delete", map);
	}
	
	/**
	 * 접속이력보유기간을 초과한 접속이력을 삭제한다.
	 * 
	 * @return int 삭제건수
	 * @exception Exception
	 */
	public int delete_hr() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		return update("batch.sc.scp.connLogDeleteDAO.delete_hr", map);
	}
}
