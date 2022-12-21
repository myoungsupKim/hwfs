package com.hwfs.batch.fm.fms;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.fm.fms.dao.FmsPydTempDao;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * 용대배치테스트
 * @ClassName FmpUpjangOpRateUpdateProTasklet.java
 * @Description FmpUpjangOpRateUpdateProTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.05.17.   박용대        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재 
 * @since 2016.05.17
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class FmsPydTempProTasklet implements Tasklet {

    @Resource(name = "/batch/fm/fms/fmsPydTempDao")
    private FmsPydTempDao fmsPydTempDao;

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        //long jobExecutionId = chunkContext.getStepContext().getStepExecution().getJobExecutionId();
        long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

        Map<String, Object> retProcVal = new HashMap<String, Object>();

        Map<String, Object> procParam = new HashMap<String, Object>();
        retProcVal = fmsPydTempDao.fmsPydTestPro(procParam);

        // 로그를 쌓는다.
        String strRtnMsg = "";
        if (!LimsUtil.checkNull(retProcVal.get("PO_RTN")).equals("TRUE")) {
            strRtnMsg = LimsUtil.checkNull(retProcVal.get("PO_RTNMSG"));
            batchStepLogService.insertNewTx(stepExecutionId, "FmsPydTestProStep", "FAILED", strRtnMsg);

            step.setExitStatus(ExitStatus.FAILED); //FAILED로 상태 설정
            // Rollback 처리 위해서 Exception 발생
            throw new BizException(strRtnMsg);
        }

        //strRtnMsg = LimsUtil.checkNull(retProcVal.get("PO_CNT"), 0) + "건이 처리 되었습니다.";
        strRtnMsg = LimsUtil.checkNull(retProcVal.get("PO_RTNMSG"));
        batchStepLogService.insertNewTx(stepExecutionId, "FmsPydTempProStep", "OK", strRtnMsg);
        return RepeatStatus.FINISHED; //Step 종료
    }

}
