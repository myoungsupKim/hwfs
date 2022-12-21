package com.hwfs.sc.scc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 시스템 사용 통계를 관리하는 SysUseStatistics DAO
 * 
 * @ClassName SysUseStatisticsDAO.java
 * @Description SysUseStatisticsDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scc/sysUseStatisticsDAO")
public class SysUseStatisticsDAO extends DefaultDAO {
	
	/**
	 * 시스템 사용 통계 목록을 조회한다.
	 * <pre>
	 * - 통계형태에 따라 일별/시간별/프로그램별/사용자별 통계를 조회한다.
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		if (mapParam.containsKey("stcsType")) {
			if (mapParam.get("stcsType").toString().equalsIgnoreCase("day"))
				return super.queryForRecordSet("sc.scc.sysUseStatisticsDAO.selectPerDayList", mapParam);
			else if (mapParam.containsKey("stcsType") && mapParam.get("stcsType").toString().equalsIgnoreCase("prg"))
				return super.queryForRecordSet("sc.scc.sysUseStatisticsDAO.selectPerPrgList", mapParam);
			else if (mapParam.containsKey("stcsType") && mapParam.get("stcsType").toString().equalsIgnoreCase("user"))
				return super.queryForRecordSet("sc.scc.sysUseStatisticsDAO.selectPerUserList", mapParam);
		}

		return super.queryForRecordSet("sc.scc.sysUseStatisticsDAO.selectPerHourList", mapParam);
	}

	/**
	 * 최근 자주 사용한 TOP 10 메뉴 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectRecentTopList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scc.sysUseStatisticsDAO.selectRecentTopList", mapParam);
	}

	/**
	 * 시스템 사용 통계 정보를 처리한다.
	 *
	 * @param mapParam
	 *            통계정보 Map
	 * @return 처리건수
	*/
	public int saveStatistics(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.sysUseStatisticsDAO.saveStatistics", mapParam);
	}
}
