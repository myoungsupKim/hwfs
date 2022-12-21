package com.hwfs.batch.sc.scp;

import javax.annotation.Resource;

import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.sc.scp.dao.AutoAfterApprovDAO;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * 개인정보열람 자동 사후승인을 처리한다.
 * - Service없이 DAO를 이용하여 처리한다. 
 * @ClassName AutoAfterApprovTasklet.java
 * @Description AutoAfterApprovTasklet Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.09.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 05. 26.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class AutoAfterApprovTasklet implements Tasklet {

	@Resource(name = "/batch/sc/scp/autoAfterApprovDAO")
	private AutoAfterApprovDAO autoAfterApprovDAO;

	/** Batch Step Log Service Bean 생성 */
	@Resource(name = "/sc/scb/batchStepLogService")
	private BatchStepLogService batchStepLogService;
	
	/**
	 * 개인정보열람 자동 사후승인을 처리한다.
	 * <pre>
	 * - 승인건수는 로그에 기록한다.
	 * </pre>
	 *
	 * @param arg0
	 * @param arg1
	 * @return
	 * @throws Exception
	 * @see org.springframework.batch.core.step.tasklet.Tasklet#execute(org.springframework.batch.core.StepContribution, org.springframework.batch.core.scope.context.ChunkContext)
	 */
	public RepeatStatus execute(StepContribution arg0, ChunkContext chunkContext) throws Exception {
		//long jobExecutionId = chunkContext.getStepContext().getStepExecution().getJobExecutionId();
		long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId() ;

		//사후승인자 조회
		String approvSabun = autoAfterApprovDAO.selectApproveSabun();
		
		//사후승인자가 등록된 경우만 처리
		int cnt = 0;
		if (approvSabun != null && !approvSabun.equalsIgnoreCase("none"))
			cnt = autoAfterApprovDAO.approve();		//DAO를 호출
		
		//로그를 쌓는다.
		batchStepLogService.insertNewTx(stepExecutionId, "autoAfterApprovTaskletStep", "OK", cnt + "건이 승인되었습니다.");
		
		return RepeatStatus.FINISHED;			//정상 처리 : 이 경우 처리 건 전체 commit
	}
}
