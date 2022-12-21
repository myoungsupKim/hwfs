package com.hwfs.batch.rc.sle;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.rc.sle.dao.SleEodMagamMgmtDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * SleMenuSumTasklet에 대한 설명 작성
 * @ClassName SleMenuSumTasklet.java
 * @Description SleMenuSumTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 02.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 포스 영업관리
 * @since 2015. 9. 02.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class SleEodMagamMgmtTasklet implements Tasklet {

	/** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    @Resource(name = "/batch/rc/sle/sleEodMagamMgmtDAO")
    private SleEodMagamMgmtDAO sleEodMagamMgmtDAO;

	 
	@Override
	public RepeatStatus execute(StepContribution step, ChunkContext chunkContext)
			throws Exception {

		long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

		Map<String, Object> rtn = sleEodMagamMgmtDAO.create();

		if ("TRUE".equals(rtn.get("O_RTN").toString())) {
	        batchStepLogService.insertNewTx(stepExecutionId, "SleEodMagamMgmtTaskletStep", "OK", rtn.get("O_RTNMSG").toString());
		}
		else {
			batchStepLogService.insertNewTx(stepExecutionId, "SleEodMagamMgmtTaskletStep", "FAILED", rtn.get("O_RTNMSG").toString());
			step.setExitStatus(ExitStatus.FAILED);

			throw new BizException(rtn.get("O_RTN_NM").toString());
		}

		return RepeatStatus.FINISHED;
	}

}
