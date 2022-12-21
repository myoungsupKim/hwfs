package com.hwfs.batch.sm.spm;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.sm.spm.dao.AdvanceTransDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * CmmMakeCreditExcelFileTasklet에 대한 설명 작성
 * @ClassName CmmMakeCreditExcelFileTasklet.java
 * @Description CmmMakeCreditExcelFileTasklet Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 12. 5.   901X5L        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 901X5L
 * @since 2016. 12. 5.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

public class AdvanceTransTasklet implements Tasklet  {

    @Resource(name = "/batch/sm/spm/dao/AdvanceTransDAO")
    private AdvanceTransDAO advanceTransDAO;

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        //long jobExecutionId = chunkContext.getStepContext().getStepExecution().getJobExecutionId();
        long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

        Map<String, Object> retProcVal = new HashMap<String, Object>();

        // FSUS.FMS_SUBULCREATE_JOB_PRO(TO_CHAR(SYSDATE-1,'YYYYMMDD'), '900101004');
        Map<String, Object> procParam = new HashMap<String, Object>();
        //logger.debug("P_OCCUR_DATE : " + LimsUtil.getDate("yyyyMMdd"));        
        procParam.put("PI_DATE", LimsUtil.getDate("yyyyMMdd"));
        procParam.put("PI_SABUN", "SYSTEM");
        //procParam.put("P_USER", "SYSTEM-BT");
        retProcVal = advanceTransDAO.advanceTransPro(procParam);

        // 로그를 쌓는다.
        String strRtnMsg = "";
        if (!LimsUtil.checkNull(retProcVal.get("O_RTN")).equals("TRUE")) {
            strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_RTNMSG"));
            batchStepLogService.insertNewTx(stepExecutionId, "advanceTransStep", "FAILED", strRtnMsg);
 
            step.setExitStatus(ExitStatus.FAILED);		//FAILED로 상태 설정
            // Rollback 처리 위해서 Exception 발생
            throw new BizException (strRtnMsg);
        }

        strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_CNT"), 0) + "건이 처리 되었습니다.";
        batchStepLogService.insertNewTx(stepExecutionId, "advanceTransStep", "OK", strRtnMsg);
        return RepeatStatus.FINISHED; 	//Step 종료
    }

}
