package com.hwfs.batch.sc.sap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.sc.sap.dao.SapBW90601ClaimDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * sapBW90601ClaimTasklet에 대한 설명 작성
 * @ClassName sapBW90601ClaimTasklet.java
 * @Description sapBW90601ClaimTasklet Class
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
public class SapBW90601ClaimTasklet implements Tasklet {

	/** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    @Resource(name = "/batch/sc/sap/sapBW90601ClaimDAO")
    private SapBW90601ClaimDAO sapBW90601ClaimDAO;

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

		Map<String, Object> rtn = sapBW90601ClaimDAO.create();

		if ("S".equals(rtn.get("O_RTN_CD").toString())) {
	        batchStepLogService.insertNewTx(stepExecutionId, "SapBW90601ClaimTaskletStep", "OK", "식자재클레임을 생성하였습니다.");
		}
		else {
			batchStepLogService.insertNewTx(stepExecutionId, "SapBW90601ClaimTaskletStep", "FAILED", rtn.get("O_RTN_NM").toString());
			step.setExitStatus(ExitStatus.FAILED);

			throw new BizException(rtn.get("O_RTN_NM").toString());
		}

		return RepeatStatus.FINISHED;
	}

}
