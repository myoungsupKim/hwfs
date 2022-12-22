package com.hwfs.batch.sc.scp.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.batch.defaults.DefaultBatchDAO;

/**
 * 접속사용자 개인정보를 파기 처리한다.
 * @ClassName DstryProcessDAO.java
 * @Description DstryProcessDAO Class 
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
@Repository("/batch/sc/scp/dstryProcessDAO")
public class DstryProcessDAO extends DefaultBatchDAO {

	/**
	 * 사용자정보에 개인정보를 파기하여 기록한다.
	 * 
	 * @param map 
	 * @return int 처리건수
	 * @exception Exception
	 */
	public int updateDstryUserInfo(Map<String, Object> map) throws Exception {
		return update("batch.sc.scp.dstryProcessDAO.updateDstryUserInfo", map);
	}

	/**
	 * 개인정보파기이력에 파기상태로 기록한다.
	 * 
	 * @param map 
	 * @return int 처리건수
	 * @exception Exception
	 */
	public int updateDstryLog(Map<String, Object> map) throws Exception {
		return update("batch.sc.scp.dstryProcessDAO.updateDstryLog", map);
	}

}
