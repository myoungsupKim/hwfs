package com.hwfs.batch.sc.scp;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.sc.scp.dao.CardExpirationDeleteProDAO;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * 카드유효기간을 초과한정보를 파기처리한다.
 * - Service없이 DAO를 이용하여 처리한다. 
 * @ClassName CardExpirationDeleteTasklet.java
 * @Description CardExpirationDeleteTasklet Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.07.15.   kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2016. 07. 15.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2016 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class CardExpirationDeleteTasklet implements Tasklet {

	@Resource(name = "/batch/sc/scp/cardExpirationDeleteProDAO")
	private CardExpirationDeleteProDAO cardExpirationDeleteProDAO;

	/** Batch Step Log Service Bean 생성 */
	@Resource(name = "/sc/scb/batchStepLogService")
	private BatchStepLogService batchStepLogService;
	
	/**
	 * 카드유효기간 초과한 카드정보를 삭제한다.
	 * <pre>
	 * - 처리건수는 로그에 기록한다.
	 * </pre>
	 *
	 * @param arg0
	 * @param arg1
	 * @return
	 * @throws Exception
	 * @see org.springframework.batch.core.step.tasklet.Tasklet#execute(org.springframework.batch.core.StepContribution, org.springframework.batch.core.scope.context.ChunkContext)
	 */
	public RepeatStatus execute(StepContribution arg0, ChunkContext chunkContext) throws Exception {
		long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId() ;

		Map<String, Object> retProcVal = new HashMap<String, Object>();
		Map<String, Object> parameter = new HashMap<String, Object>();
		
		retProcVal = cardExpirationDeleteProDAO.cardExpirationDeletePro(parameter);		//DAO를 호출하는 경우
		
		//로그를 쌓는다.
		batchStepLogService.insertNewTx(stepExecutionId, "cardExpirationDeleteTaskletStep", "OK", retProcVal.get("O_CNT") + "건이 처리되었습니다.");
		
		return RepeatStatus.FINISHED;			//정상 처리 : 이 경우 처리 건 전체 commit
	}
}
