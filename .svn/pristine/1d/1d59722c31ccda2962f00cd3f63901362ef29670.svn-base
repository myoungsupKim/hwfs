package com.hwfs.sc.scp.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 개인정보 파기이력통계를 조회하는 PersDstryStatistics DAO
 * 
 * @ClassName PersDstryStatisticsDAO.java
 * @Description PersDstryStatisticsDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.22   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.22
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scp/persDstryStatisticsDAO")
public class PersDstryStatisticsDAO extends DefaultDAO {
	
	/**
	 * 파기상태별 개인정보 열람이력 통계 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListPerDstryStatus(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scp.persDstryStatisticsDAO.selectListPerDstryStatus", mapParam);
	}

	/**
	 * 파기구분별 개인정보 열람이력 통계 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListPerDstryClass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scp.persDstryStatisticsDAO.selectListPerDstryClass", mapParam);
	}

}
