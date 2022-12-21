package com.hwfs.batch.sc.scp;

import javax.annotation.Resource;

import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.sc.scp.dao.ConnLogDeleteDAO;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * 접속이력보유기간을 초과한 접속이력을 파기처리한다.
 * - Service없이 DAO를 이용하여 처리한다. 
 * @ClassName ConnLogDeleteTasklet.java
 * @Description ConnLogDeleteTasklet Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.26.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 05. 26.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class ConnLogDeleteTasklet implements Tasklet {

	@Resource(name = "/batch/sc/scp/connLogDeleteDAO")
	private ConnLogDeleteDAO connLogDeleteDAO;

	/** Batch Step Log Service Bean 생성 */
	@Resource(name = "/sc/scb/batchStepLogService")
	private BatchStepLogService batchStepLogService;
	
	/**
	 * 접속이력보유기간을 초과한 접속이력을 삭제한다.
	 * <pre>
	 * - 삭제건수는 로그에 기록한다.
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

		int delCnt = connLogDeleteDAO.delete();		//DAO를 호출하는 경우		
		//노무수령 거부의사 동의 로그
		int delCnt2 = connLogDeleteDAO.delete_hr();		//DAO를 호출하는 경우
		
		//로그를 쌓는다.
		batchStepLogService.insertNewTx(stepExecutionId, "connLogDeleteTaskletStep", "OK", delCnt + "건이 삭제되었습니다.");
		batchStepLogService.insertNewTx(stepExecutionId, "ehrLogDeleteTaskletStep", "OK", delCnt2 + "건이 삭제되었습니다.");
		
		return RepeatStatus.FINISHED;			//정상 처리 : 이 경우 처리 건 전체 commit
	}
}
