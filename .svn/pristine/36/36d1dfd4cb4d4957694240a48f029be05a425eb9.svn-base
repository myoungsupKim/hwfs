package com.hwfs.batch.rc.rrm;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.batch.rc.rrm.service.RrmUseSumJobService;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.scb.service.BatchStepLogService;
import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;

 /**
 * RrmUseSumJobTasklet에 대한 설명 작성
 * @ClassName RrmUseSumJobTasklet.java
 * @Description RrmUseSumJobTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 08. 12.   김호석        최초생성
 * </pre>
 * @author FC종합전산구축 : 김동표
 * @since 2016. 02. 12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class RrmUseSumJobTasklet implements Tasklet {

	/** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    @Resource(name = "/batch/rc/rrm/rrmUseSumJobService")
    private RrmUseSumJobService rrmUseSumJobService;

	/**
	 * execute 설명
	 * <pre>
	 * 외식레시피 목표사용량 배치 작업
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
		
		int processCnt  = 0;
		
		processCnt = rrmUseSumJobService.saveList();
		
		
	
			if (processCnt > 0) {
		        batchStepLogService.insertNewTx(stepExecutionId, "RrmUseSumProTaskletStep", "OK", "외식레시피 목표사용량 : " + processCnt + "건, 생성 : " + processCnt + "건을 처리하였습니다.");
			}
			else {
				batchStepLogService.insertNewTx(stepExecutionId, "RrmUseSumProTaskletStep", "FAILED", "외식레시피 목표사용량 저장 시 문제가 발행하였습니다.");
				step.setExitStatus(ExitStatus.FAILED);
	
				throw new BizException("FC 외식레시피 목표사용량 배치작업 시 문제가 발행하였습니다.");
			}
	
		

		return RepeatStatus.FINISHED;
	}

}
