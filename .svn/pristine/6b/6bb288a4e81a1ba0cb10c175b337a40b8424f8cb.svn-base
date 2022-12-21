package com.hwfs.batch.sc.sap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.sc.sap.dao.SapTR00301CardBillingDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * sapTR00301CardBillingTasklet에 대한 설명 작성
 * @ClassName sapTR00301CardBillingTasklet.java
 * @Description sapTR00301CardBillingTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 22.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 6. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class SapTR00301CardBillingTasklet implements Tasklet {

	/** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    @Resource(name = "/batch/sc/sap/sapTR00301CardBillingDAO")
    private SapTR00301CardBillingDAO sapTR00301CardBillingDAO;

	/**
	 * execute 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param arg0
	 * @param arg1
	 * @return
	 * @throws Exception
	 * @see org.springframework.batch.core.step.tasklet.Tasklet#execute(org.springframework.batch.core.StepContribution, org.springframework.batch.core.scope.context.ChunkContext)
	*/
	@Override
	public RepeatStatus execute(StepContribution step, ChunkContext chunkContext)
			throws Exception {

		long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

		Map<String, Object> rtn = sapTR00301CardBillingDAO.create();

		if ("S".equals(rtn.get("O_RTN_CD").toString())) {
	        batchStepLogService.insertNewTx(stepExecutionId, "SapTR00301CardBillingTaskletStep", "OK", "카드청구내역을 생성하였습니다.");
		}
		else {
			batchStepLogService.insertNewTx(stepExecutionId, "SapTR00301CardBillingTaskletStep", "FAILED", rtn.get("O_RTN_NM").toString());
			step.setExitStatus(ExitStatus.FAILED);

			throw new BizException(rtn.get("O_RTN_NM").toString());
		}

		return RepeatStatus.FINISHED;
	}

}
