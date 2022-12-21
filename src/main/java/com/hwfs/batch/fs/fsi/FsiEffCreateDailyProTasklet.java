package com.hwfs.batch.fs.fsi;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.fs.fsi.dao.FsiEffCreateDailyProDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * 효율화식재 집계 일배치 Scheduler Job Class
 * @ClassName fsiEffCreateDailyProTasklet.java
 * @Description fsiEffCreateDailyProTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.06.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015.08.06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class FsiEffCreateDailyProTasklet implements Tasklet {

    @Resource(name = "/batch/sc/fsi/fsiEffCreateDailyProDAO")
    private FsiEffCreateDailyProDAO fsiEffCreateDailyProDAO;

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        //long jobExecutionId = chunkContext.getStepContext().getStepExecution().getJobExecutionId();
        long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

        Map<String, Object> retProcVal = new HashMap<String, Object>();

        // FSUS.FMS_SUBULCREATE_JOB_PRO(TO_CHAR(SYSDATE-1,'YYYYMMDD'), '900101004');
        Map<String, Object> procParam = new HashMap<String, Object>();
        procParam.put("p_base_dd", LimsUtil.getDate("yyyyMMdd"));
        procParam.put("p_cuser", "SYSTEM");
        retProcVal = fsiEffCreateDailyProDAO.fsiDutyCreateDailyPro(procParam); 

        // 로그를 쌓는다.
        String strRtnMsg = "";
        if (!LimsUtil.checkNull(retProcVal.get("O_RTN")).equals("TRUE")) {
            strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_RTNMSG"));
            batchStepLogService.insertNewTx(stepExecutionId, "fsiEffCreateDailyProStep", "FAILED", strRtnMsg);

            step.setExitStatus(ExitStatus.FAILED);		//FAILED로 상태 설정
            // Rollback 처리 위해서 Exception 발생
            throw new BizException (strRtnMsg);
        }

        strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_CNT"), 0) + "건이 처리 되었습니다.";
        batchStepLogService.insertNewTx(stepExecutionId, "fsiEffCreateDailyProStep", "OK", strRtnMsg);
        return RepeatStatus.FINISHED; 	//Step 종료
    }

}
