package com.hwfs.batch.fm.fms;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.fm.fms.dao.FmsSpFmSaleBatchProcDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * 식재영업 일마감 Scheduler Job Class
 * @ClassName FmsSubulcreateJobProTasklet.java
 * @Description FmsSubulcreateJobProTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 11.   최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015. 7. 11.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class FmsSpFmSaleBatchProcJobTasklet implements Tasklet {

    @Resource(name = "/batch/sc/fms/fmsSpFmSaleBatchProcDAO")
    private FmsSpFmSaleBatchProcDAO fmsSpFmSaleBatchProcDAO;

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        //long jobExecutionId = chunkContext.getStepContext().getStepExecution().getJobExecutionId();
        long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

        Map<String, Object> retProcVal = new HashMap<String, Object>();

        // FSUS.FMS_SUBULCREATE_JOB_PRO(TO_CHAR(SYSDATE-1,'YYYYMMDD'), '900101004');
        Map<String, Object> procParam = new HashMap<String, Object>();
        procParam.put("p_sale_date", LimsUtil.getDateAdd("yyyyMMdd", "date", -1));
        procParam.put("p_upjang", "");
        procParam.put("p_subinv_code", "");
        procParam.put("p_user", "900101004");
        retProcVal = fmsSpFmSaleBatchProcDAO.fmsSpFmSaleBatchProc(procParam);

        // 로그를 쌓는다.
        String strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_RTNMSG"));
        if (!LimsUtil.checkNull(retProcVal.get("O_RTN")).equals("TRUE")) {
            batchStepLogService.insertNewTx(stepExecutionId, "FmsSpFmSaleBatchProcStep", "FAILED", strRtnMsg);
        }
        else
        {
            batchStepLogService.insertNewTx(stepExecutionId, "FmsSpFmSaleBatchProcStep", "OK", strRtnMsg);
        }

        return RepeatStatus.FINISHED; 	//Step 종료
    }

}
