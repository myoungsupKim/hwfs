package com.hwfs.sc.scb.service;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.scb.dto.SchdInfoDTO;

 /**
 * Batch Job Repository에 등록된 Batch Job Scheduler 정보를 관리하는 BatchSchdMngt Service Interface
 * -CronTrigger 정보만 관리한다.
 * 
 * @ClassName BatchSchdMngtService.java
 * @Description BatchSchdMngtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09    kksoo        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface BatchSchdMngtService {

	/**
	 * Batch Job Scheduler 정보 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return List<SchdInfoDTO> 
	 *            조회결과
	 * @throws Exception
	*/
	List<SchdInfoDTO> selectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * Job Repository 등록된 NonBatch Schedule 정보를 얻는다.
	 * <pre>
	 * - NonBatch Scheduler Configuration 파일 정보를 이용하여 생성한다.
	 * - WEB-INF/config/framework/service/hone_scheduler.xml
	 * </pre>
	 * 
	 * @return List<SchdInfoDTO> 
	 *            조회결과
	 * @throws Exception
	 */
	List<SchdInfoDTO> selectNonBatchSchedulerList() throws Exception;

//	/**
//	 * Batch Job Scheduler 정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
//	 * <pre>
//	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
//	 * </pre>
//	 *
//	 * @param list
//	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
//	 * @return 처리건수
//	 * @throws Exception
//	*/
//	int saveList(DataSetMap list) throws Exception;
//	
//	/**
//	 * 배치 스케쥴 Job을 DB로 관리하는 경우 초기 스케쥴 정보를 DB로 부터 읽어 초기 설정한다.
//	 * <pre>
//	 * - LoadCacheServiceImpl.initApplication에서 호출
//	 * </pre>
//	 *
//	 * @throws Exception
//	*/
//	void initBatchScheduleInfo() throws Exception;

}
