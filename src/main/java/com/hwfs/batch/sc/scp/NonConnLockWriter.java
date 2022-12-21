package com.hwfs.batch.sc.scp;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.annotation.BeforeStep;
import org.springframework.batch.item.ItemWriter;

import com.hwfs.batch.sc.scp.dao.NonConnLockDAO;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * 미접속계정 잠김주기 건에 대한 ItemWriter
 * @ClassName CustomerCreditWriter.java
 * @Description CustomerCreditWriter Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 05. 28.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class NonConnLockWriter extends DefaultServiceImpl implements ItemWriter<Map<String,Object>>{
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "/batch/sc/scp/nonConnLockDAO")
	private NonConnLockDAO nonConnLockDAO;

	/** Batch Step Log Service Bean 생성 */
	@Resource(name = "/sc/scb/batchStepLogService")
	private BatchStepLogService batchStepLogService;

	private long stepExecutionId;

	/**
	 * stepExecutioId를 얻는다.
	 *
	 * @param stepExecution
	 */
	@BeforeStep
	public void beforeStep(StepExecution stepExecution) {
	    stepExecutionId = stepExecution.getId();
	}
	
	/**
	 * DB로 Item을 Write
	 * <pre>
	 * - Service 보다는 DAO를 호출하여 DB 처리
	 * </pre>
	 *
	 * @param list
	 * @throws Exception
	 * @see org.springframework.batch.item.ItemWriter#write(java.util.List)
	*/
	@Override
	public void write(List<? extends Map<String,Object>> list) throws Exception {
		
		for (Map<String, Object> map:list) {
			//잠김상태 설정
			int cnt = nonConnLockDAO.updateUserAcctStatusToLock(map);
			if (cnt > 0) {
				String strMsg = String.format("사용자계정[SABUN=%s]이 일정기간 미접속으로 잠겼습니다.", map.get("sabun").toString());
				logger.info(strMsg);
				
				//처리로그 기록
				batchStepLogService.insertNewTx(stepExecutionId, "nonConnLockStep", "OK", strMsg);
			}
		}
	}
	

}
