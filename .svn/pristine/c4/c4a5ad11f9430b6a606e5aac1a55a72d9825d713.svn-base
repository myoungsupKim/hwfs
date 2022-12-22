package com.hwfs.batch.fm.fmb;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.fm.fmb.dao.FmbSetsaledatajobProDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * 매출데이터 강제생성 Scheduler Job Class
 * @ClassName FmbSetsaledatajobProJobTasklet.java
 * @Description FmbSetsaledatajobProJobTasklet Class
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
public class FmbSetsaledatajobProJobTasklet implements Tasklet {

    @Resource(name = "/batch/sc/fmb/fmbSetsaledatajobProDAO")
    private FmbSetsaledatajobProDAO fmbSetsaledatajobProDAO;

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        //long jobExecutionId = chunkContext.getStepContext().getStepExecution().getJobExecutionId();
        long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

        Map<String, Object> retProcVal = new HashMap<String, Object>();

        Map<String, Object> procParam = new HashMap<String, Object>();
        procParam.put("pi_date_f", LimsUtil.getDateAdd("yyyyMMdd", "date", -1));
        procParam.put("pi_date_t", LimsUtil.getDateAdd("yyyyMMdd", "date", -1));
        procParam.put("pi_part_code", "");
        procParam.put("pi_sabun", "900101004");
        retProcVal = fmbSetsaledatajobProDAO.fmbSetsaledatajobPro(procParam);

        // 로그를 쌓는다.
        String strRtnMsg = LimsUtil.checkNull(retProcVal.get("PO_RTNMSG"));
        if (!LimsUtil.checkNull(retProcVal.get("PO_RTN")).equals("TRUE")) {
            batchStepLogService.insertNewTx(stepExecutionId, "FmbSetsaledatajobProStep", "FAILED", strRtnMsg);
        }
        else
        {
            batchStepLogService.insertNewTx(stepExecutionId, "FmbSetsaledatajobProStep", "OK", strRtnMsg);
        }

        return RepeatStatus.FINISHED; 	//Step 종료
    }

}
