package com.hwfs.sc.scp.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scp.dao.PersDstryStatisticsDAO;

 /**
 * 개인정보 파기이력통계를 조회하는 PersDstryStatistics Service Implementation
 * 
 * @ClassName PersDstryStatisticsServiceImpl.java
 * @Description PersDstryStatisticsServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.22    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.22
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scp/persDstryStatisticsService")
public class PersDstryStatisticsServiceImpl extends DefaultServiceImpl implements PersDstryStatisticsService {
	
	/** PersDstryStatisticsDAO Bean 생성 */
	@Resource(name = "/sc/scp/persDstryStatisticsDAO")
	private PersDstryStatisticsDAO persDstryStatisticsDAO;
	

	/**
	 * 파기상태별 개인정보 파기이력통계 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectListPerDstryStatus(Map<String, Object> mapParam) throws Exception {
		return persDstryStatisticsDAO.selectListPerDstryStatus(mapParam);
	}

	/**
	 * 파기구분별 개인정보 파기이력통계 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectListPerDstryClass(Map<String, Object> mapParam) throws Exception {
		return persDstryStatisticsDAO.selectListPerDstryClass(mapParam);
	}

}
