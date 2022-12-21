package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scc.dao.SysUseStatisticsDAO;

 /**
 * 시스템 사용 통계를 관리하는 SysUseStatistics Service Implementation
 * 
 * @ClassName SysUseStatisticsServiceImpl.java
 * @Description SysUseStatisticsServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scc/sysUseStatisticsService")
public class SysUseStatisticsServiceImpl extends DefaultServiceImpl implements SysUseStatisticsService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SysUseStatisticsDAO Bean 생성 */
	@Resource(name = "/sc/scc/sysUseStatisticsDAO")
	private SysUseStatisticsDAO sysUseStatisticsDAO;
	

	/**
	 * 시스템 사용 통계 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return sysUseStatisticsDAO.selectList(mapParam);
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
		return sysUseStatisticsDAO.selectRecentTopList(mapParam);
	}

	/**
	 * 시스템 사용 통계 정보를 처리한다.
	 * <pre>
	 * - 트랜잭션을 분리시키다.
	 * - Exception은 발생시키지 않는다.
	 * </pre>
	 *
	 * @param mapParam
	 *            통계정보 Map
	 * @return 처리건수
	*/
	public int saveStatisticsNewTx(Map<String, Object> mapParam) {
		try {
			return sysUseStatisticsDAO.saveStatistics(mapParam);
		} catch (Exception e) {
			//Exception 무시
			logger.error("error at SysUseStatisticsServiceImpl.saveStatisticsNewTx : {}", e.getMessage());
		}
		return 0;
	}
}
