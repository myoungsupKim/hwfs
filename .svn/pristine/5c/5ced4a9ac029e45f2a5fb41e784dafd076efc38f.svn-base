package com.hwfs.batch.ma.mag;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.ma.mag.dao.MagDayCloseJobProDAO;
import com.hwfs.batch.ma.mag.dao.SpSlaSalsPosMagamProcOutDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * 매출데이터 강제생성 Scheduler Job Class
 * @ClassName MapDayactjobProJobTasklet.java
 * @Description MapDayactjobProJobTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 12. 09.   손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업  손형민
 * @since 2015. 12. 09.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class SpSlaSalsPosMagamProcOutTasklet implements Tasklet {

	@Resource(name = "/batch/ma/mag/spSlaSalsPosMagamProcOutDAO")
	private SpSlaSalsPosMagamProcOutDAO spSlaSalsPosMagamProcOutDAO;

	/** Batch Step Log Service Bean 생성 */
	@Resource(name = "/sc/scb/batchStepLogService")
	private BatchStepLogService batchStepLogService;
	

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

	public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
		//long jobExecutionId = chunkContext.getStepContext().getStepExecution().getJobExecutionId();
		long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

		Map<String, Object> retProcVal = new HashMap<String, Object>();

		Map<String, Object> procParam = new HashMap<String, Object>();
		retProcVal = spSlaSalsPosMagamProcOutDAO.spSlaSalsPosMagamProcOut(procParam);
		// 로그를 쌓는다.
		String strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_RTNMSG"));
		if (!LimsUtil.checkNull(retProcVal.get("O_RTN")).equals("TRUE")) {
			batchStepLogService.insertNewTx(stepExecutionId, "SpSlaSalsPosMagamProcOutStep", "FAILED", strRtnMsg);
		}
		else
		{
			batchStepLogService.insertNewTx(stepExecutionId, "SpSlaSalsPosMagamProcOutStep", "OK", strRtnMsg);
		}
		return RepeatStatus.FINISHED;

	}

}
