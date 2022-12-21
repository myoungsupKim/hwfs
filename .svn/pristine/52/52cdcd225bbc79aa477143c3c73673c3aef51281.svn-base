package com.hwfs.sc.scb.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scb.dao.BatchStepLogDAO;

 /**
 * 배치 Step 로그를 처리하는 BatchStepLog Service Implementation
 * 
 * @ClassName BatchStepLogServiceImpl.java
 * @Description BatchStepLogServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.26    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scb/batchStepLogService")
public class BatchStepLogServiceImpl extends DefaultServiceImpl implements BatchStepLogService {
	
	/** BatchStepLogDAO Bean 생성 */
	@Resource(name = "/sc/scb/batchStepLogDAO")
	private BatchStepLogDAO batchStepLogDAO;
	

//	/**
//	 * 배치 Step 로그 목록을 조회한다.
//	 * <pre>
//	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
//	 * </pre>
//	 * 
//	 * @param mapParam
//	 *            조회조건 Map
//	 * @return RecordSet 
//	 *            조회결과
//	 * @throws Exception
//	 */
//	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
//		return batchStepLogDAO.selectList(mapParam);
//	}

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
	public int insertNewTx(long stepExecutionId, String stepName, String exitCode, String exitMessage) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stepExecutionId", stepExecutionId);
		map.put("spName", stepName);
		map.put("exitCode", exitCode);
		map.put("exitMessage", exitMessage);
		
		return batchStepLogDAO.insert(map);
	}
}
