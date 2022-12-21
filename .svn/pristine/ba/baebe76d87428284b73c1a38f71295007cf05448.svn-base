package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 운영로그 내역을 관리하는 OpLog Service Interface
 * 
 * @ClassName OpLogService.java
 * @Description OpLogService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.13    kksoo        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface OpLogService {

	/**
	 * 운영로그 내역 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 운영로그 내역 DataSetMap의 데이터를 rowType에 따라 Delete 처리한다.
	 * <pre>
	 * - (참고)스케쥴러에 의해 주기적으로 삭제된다.
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;
	
	/**
	 * 사용자별 운용로그 데이터를 주기적으로 삭제한다.
	 * <pre>
	 * - DeleteOpLogSchdJob에서 주기적으로 호출한다.
	 * - 전일 로그 데이터를 모두 삭제한다.
	 * </pre>
	 *
	 * @return 처리건수
	 * @throws Exception
	 */
	int deleteOpLog() throws Exception;
}
