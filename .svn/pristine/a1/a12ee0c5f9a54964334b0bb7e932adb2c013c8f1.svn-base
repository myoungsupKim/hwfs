package com.hwfs.batch.sc.scp;

import javax.annotation.Resource;

import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.sc.scp.dao.AcesLogDeleteDAO;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * 개인정보접근로그 보유기간이 지난 로그를 삭제 처리한다.
 * - Service없이 DAO를 이용하여 처리한다. 
 * @ClassName AcesLogDeleteTasklet.java
 * @Description AcesLogDeleteTasklet Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.07.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 07. 07.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class AcesLogDeleteTasklet implements Tasklet {

	@Resource(name = "/batch/sc/scp/acesLogDeleteDAO")
	private AcesLogDeleteDAO acesLogDeleteDAO;

	/** Batch Step Log Service Bean 생성 */
	@Resource(name = "/sc/scb/batchStepLogService")
	private BatchStepLogService batchStepLogService;
	
	/**
	 * 개인정보접근로그 보유기간이 지난 로그를 삭제 처리한다.
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

		//개인정보접근로그 보유기간이 지난 로그를 삭제
		int acesCnt = acesLogDeleteDAO.deleteAcesLog();
		
		//사용자 액션로그 보유기간이 지난 로그를 삭제
		int actionCnt = acesLogDeleteDAO.deleteActionLog();

		//오류로그 보유기간이 지난 로그를 삭제
		int errorCnt = acesLogDeleteDAO.deleteErrorLog();
		
		//로그를 쌓는다.
		batchStepLogService.insertNewTx(stepExecutionId, "acesLogDeleteTaskletStep", "OK", acesCnt + "건의 개인정보접근로그가 삭제되었습니다.");
		batchStepLogService.insertNewTx(stepExecutionId, "acesLogDeleteTaskletStep", "OK", actionCnt + "건의 사용자액션로그가 삭제되었습니다.");
		batchStepLogService.insertNewTx(stepExecutionId, "acesLogDeleteTaskletStep", "OK", errorCnt + "건의 오류로그가 삭제되었습니다.");
		
		return RepeatStatus.FINISHED;			//정상 처리 : 이 경우 처리 건 전체 commit
	}
}
