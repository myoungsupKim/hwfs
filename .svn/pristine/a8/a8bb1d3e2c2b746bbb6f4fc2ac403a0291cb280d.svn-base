package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.service.ComCacheService;
import com.hwfs.sc.cmn.dao.LoadCacheDAO;

 /**
 * JVM 로드 시 초기에 캐시를 로딩하는 Service Implementation
 * <pre>
 * - 다양한 데이터 타입으로 인해 프레임워크로 구성할 수 없어 공통 서비스로 구현 함
 * - 시스템 또는 업무에 필요한 정보를 캐시로 로딩
 * - 배치 스케쥴 Job을 DB로 관리하는 경우 초기 스케쥴 정보를 DB로 부터 읽어 초기 설정한다. 
 * </pre>
 * @ClassName LoadCacheServiceImpl.java
 * @Description LoadCacheServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 2.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 2.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class LoadCacheServiceImpl extends DefaultServiceImpl implements LoadCacheService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	@Autowired
	private ComCacheService comCacheService;

	@Resource(name="/sc/cmn/loadCacheDAO")
	private LoadCacheDAO loadCacheDAO;

//	/** BatchSchdMngtService Bean 생성 */
//	@Resource(name = "/sc/scb/batchSchdMngtService")
//	private BatchSchdMngtService batchSchdMngtService;

	/**
	 * 시스템 또는 업무에 필요한 정보를 캐시로 로딩한다.
	 *
	 * @see com.hwfs.cmn.listener.InitApplicationService#initApplication()
	*/
	@Override
	public void initApplication() {
		//사용자별 동적 로깅 설정
		cacheUserIdLog ();
		
		//배치 스케쥴 Job을 DB로 관리하는 경우 초기 스케쥴 정보를 DB로 부터 읽어 초기 설정한다.
		//initBatchScheduleInfo ();
		
		//TODO 그 외 프로젝트 별 추가 설정
	}
	
	/**
	 * 동적으로 로깅을 처리하기 위해 등록된 사용자 ID를 캐싱한다.
	 */
	public void cacheUserIdLog () {
		try {
			RecordSet rs = loadCacheDAO.selectUserIdLog();
			if (comCacheService.contains(DefaultConsts.CACHE_KEY_USERID_LOG)) {
				comCacheService.removeCacheItem(DefaultConsts.CACHE_KEY_USERID_LOG);
			}
			comCacheService.put(DefaultConsts.CACHE_KEY_USERID_LOG, rs);
			logger.info("A user for operation logging is cached!");
		}catch (Exception e){
			logger.error("cacheUserIdLog", e);
		}
	}
	
//	/**
//	 * 배치 스케쥴 Job을 DB로 관리하는 경우 초기 스케쥴 정보를 DB로 부터 읽어 초기 설정한다.
//	 */
//	private void initBatchScheduleInfo () {
//		try {
//			batchSchdMngtService.initBatchScheduleInfo ();
//		}catch (Exception e){
//			logger.error("cacheUserIdLog", e);
//		}
//	}

}
