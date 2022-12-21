package com.hwfs.sc.scb.service;


 /**
 * 배치 Step 로그를 처리하는 BatchStepLog Service Interface
 * 
 * @ClassName BatchStepLogService.java
 * @Description BatchStepLogService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.26    kksoo        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface BatchStepLogService {

//	/**
//	 * 배치 Step 로그 목록을 조회한다.
//	 *
//	 * @param mapParam
//	 *            조회조건 Map
//	 * @return RecordSet 
//	 *            조회결과
//	 * @throws Exception
//	*/
//	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 배치 Step 로그 데이터를 Insert 처리한다.
	 *
	 * @param stepExecutionId
	 * @param stepName
	 * @param exitCode
	 * @param exitMessage
	 * @return 처리건수
	 * @throws Exception
	 */
	int insertNewTx(long stepExecutionId, String stepName, String exitCode, String exitMessage) throws Exception;
}
