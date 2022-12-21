package com.hwfs.batch.sc.sap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.sc.sap.dao.SapFI02801WholeSaleMmSumDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * SapFI02801WholeSale에 대한 설명 작성
 * @ClassName SapFI02801WholeSaleMmSumTasklet.java
 * @Description SapFI02801WholeSaleMmSumTasklet Class
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
public class SapFI02801WholeSaleMmSumTasklet implements Tasklet {

	/** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    @Resource(name = "/batch/sc/sap/sapFI02801WholeSaleMmSumDAO")
    private SapFI02801WholeSaleMmSumDAO sapFI02801WholeSaleMmSumDAO;

	/**
	 * execute 설명
	 * <pre>
	 * 계정별 월합계 집계내역
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
		
		Map<String, Object> rtn = new HashMap<String, Object>();
		
		Map<String, Object> procParam = new HashMap<String, Object>();
		rtn = sapFI02801WholeSaleMmSumDAO.sapFI02801WholeSaleMmSumPro(procParam);
		
		if ("S".equals(rtn.get("O_RTN_CD").toString())) {
	        batchStepLogService.insertNewTx(stepExecutionId, "SapFI02801WholeSaleMmSumTaskletStep", "OK", "도매유통 수불내역을 " +rtn.get("O_RTN_NM").toString()+ "건 생성하였습니다.");
		}
		else {
			batchStepLogService.insertNewTx(stepExecutionId, "SapFI02801WholeSaleMmSumTaskletStep", "FAILED", rtn.get("O_RTN_NM").toString());
			step.setExitStatus(ExitStatus.FAILED);

			throw new BizException(rtn.get("O_RTN_NM").toString());
		}

		return RepeatStatus.FINISHED;
	}

}
