package com.hwfs.batch.ma.mag;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.ma.mag.dao.MagDayCloseJobProDAO;
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
 *  2015. 9. 24.   박준석        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업  박준석
 * @since 2015. 9. 24.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class MagDayCloseJobTasklet implements Tasklet {

	@Resource(name = "/batch/ma/mag/magDayCloseJobProDAO")
	private MagDayCloseJobProDAO magDayCloseJobProDAO;

	/** Batch Step Log Service Bean 생성 */
	@Resource(name = "/sc/scb/batchStepLogService")
	private BatchStepLogService batchStepLogService;

	public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
		//long jobExecutionId = chunkContext.getStepContext().getStepExecution().getJobExecutionId();
		long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

		Map<String, Object> retProcVal = new HashMap<String, Object>();

		Map<String, Object> procParam = new HashMap<String, Object>();

		Calendar calendar = Calendar.getInstance();

		//System.out.println(calendar.get(Calendar.DAY_OF_WEEK));
		if(calendar.get(Calendar.DAY_OF_WEEK) == 7 || calendar.get(Calendar.DAY_OF_WEEK) == 1){	// 토요일 일요일일때 일배치 실행되지 않음 : 2015.11.09
			//System.out.println("!!!!!!!!!  1   or   7 ");
			return RepeatStatus.FINISHED; 	//Step 종료
		}
		else if(calendar.get(Calendar.DAY_OF_WEEK) == 2)
		{	
			// 월요일에는 금, 토, 일 3일치 일배치가 실행 : 2015.11.09
			//System.out.println("!!!!!!!!!  2 ");
			for (int i = 3; i > 0; i--) {
				//System.out.println("#### " + i);	
				//procParam.put("P_SYS_CLASS", LimsUtil.getDateAdd("yyyyMMdd", "date", -1));
				//procParam.put("pi_part_code", "");
				//procParam.put("pi_sabun", "900101004");
				procParam.put("P_OCCUR_DATE", LimsUtil.getDateAdd("yyyyMMdd", "date", -i));
				retProcVal = magDayCloseJobProDAO.magDayCloseJobPro(procParam);

				// 로그를 쌓는다.
				String strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_RTNMSG"));
				if (!LimsUtil.checkNull(retProcVal.get("O_RTN")).equals("TRUE")) {
					batchStepLogService.insertNewTx(stepExecutionId, "MagDayCloseJobProStep", "FAILED", strRtnMsg);
				}
				else
				{
					batchStepLogService.insertNewTx(stepExecutionId, "MagDayCloseJobProStep", "OK", strRtnMsg);
				}
			}
			return RepeatStatus.FINISHED; 	//Step 종료
		}
		else
		{
			//System.out.println("!!!!!!!!!  3 4 5 6 ");
			//procParam.put("P_SYS_CLASS", LimsUtil.getDateAdd("yyyyMMdd", "date", -1));
			//procParam.put("pi_part_code", "");
			//procParam.put("pi_sabun", "900101004");
			procParam.put("P_OCCUR_DATE", LimsUtil.getDateAdd("yyyyMMdd", "date", -1));
			retProcVal = magDayCloseJobProDAO.magDayCloseJobPro(procParam);

			// 로그를 쌓는다.
			String strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_RTNMSG"));
			if (!LimsUtil.checkNull(retProcVal.get("O_RTN")).equals("TRUE")) {
				batchStepLogService.insertNewTx(stepExecutionId, "MagDayCloseJobProStep", "FAILED", strRtnMsg);
			}
			else
			{
				batchStepLogService.insertNewTx(stepExecutionId, "MagDayCloseJobProStep", "OK", strRtnMsg);
			}

			return RepeatStatus.FINISHED; 	//Step 종료

		}
	}

}
