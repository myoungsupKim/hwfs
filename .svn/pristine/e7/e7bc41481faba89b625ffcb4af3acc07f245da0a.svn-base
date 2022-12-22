package com.hwfs.batch.sc.sap;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.sc.sap.service.SapSlipAutoSendService;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * SapSlipAutoSendTasklet에 대한 설명 작성
 * @ClassName SapSlipAutoSendTasklet.java
 * @Description SapSlipAutoSendTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 02. 12.   김동표        최초생성
 * </pre>
 * @author FC종합전산구축 : 김동표
 * @since 2016. 02. 12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class SapSlipAutoSendTasklet implements Tasklet {

	/** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    @Resource(name = "/batch/sc/sap/sapSlipAutoSendService")
    private SapSlipAutoSendService sapSlipAutoSendService;

	/**
	 * execute 설명
	 * <pre>
	 * FC영업전표를 실시간으로 SAP로 전송
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
		
		//중복실행방지 JobDetailBean
		//int insRowCnt  = 0;
		//RecordSet list = sapSlipAutoSendService.selectBatchList();  //동일 배치가 수행 중인지 체크함 
		
		//insRowCnt = list.size();
		
		//if(insRowCnt == 0)  // 수행 중인 동일 배치가 없을 경우
		//{
			int[] cnt = sapSlipAutoSendService.sapSlipAutoSend();
			
			if (cnt[0] >= 0) {
		        batchStepLogService.insertNewTx(stepExecutionId, "SapSlipAutoSendTaskletStep", "OK", "FC 영업전표 전송대상 : " + cnt[0] + "건, SAP전송 : " + cnt[1] + "건을 처리하였습니다.");
			}
			else {
				batchStepLogService.insertNewTx(stepExecutionId, "SapSlipAutoSendTaskletStep", "FAILED", "FC 영업전표 전송시 문제가 발행하였습니다.");
				step.setExitStatus(ExitStatus.FAILED);
	
				throw new BizException("FC 영업전표 전송시 문제가 발행하였습니다.");
			}
		//}
		//else
		//{
		//	batchStepLogService.insertNewTx(stepExecutionId, "SapSlipAutoSendTaskletStep", "FAILED", "이전 배치 작업이 완료되지 않아 작업을 중단합니다.");
		//	step.setExitStatus(ExitStatus.FAILED);

		//	throw new BizException("이전 배치 작업이 완료되지 않아 작업을 중단합니다.");
		//}
		

		return RepeatStatus.FINISHED;
	}

}
