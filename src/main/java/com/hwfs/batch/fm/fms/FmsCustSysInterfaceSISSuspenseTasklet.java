package com.hwfs.batch.fm.fms;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.fm.fms.dao.FmsCustSysInterfaceSISDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * @ClassName FmsCustSysInterfaceSISTasklet.java
 * @Description FmsCustSysInterfaceSISTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2020.07.06.   kihoon        쓰레기생성
 * </pre>
 * @author kihoon
 * @since 2020. 07. 06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2020 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class FmsCustSysInterfaceSISSuspenseTasklet implements Tasklet {

    @Resource(name = "/batch/fm/fms/fmsCustSysInterfaceSISDAO")
    private FmsCustSysInterfaceSISDAO fmsCustSysInterfaceSISDAO;

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        
    	long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

    	int procCount=-1;
        Map<String, Object> param = new HashMap<String, Object>();
        
        procCount = fmsCustSysInterfaceSISDAO.batchJobSuspense(param);
        
        String strRtnMsg = "";
        	   strRtnMsg = "[" + procCount + "] 건이 처리 되었습니다..";
        
        if (  procCount == -1 ) {
            batchStepLogService.insertNewTx(stepExecutionId, "FmsCustSysInterfaceSISuspenseStep", "FAILED", strRtnMsg);
            
            step.setExitStatus(ExitStatus.FAILED);
            throw new BizException (strRtnMsg);
        }

        batchStepLogService.insertNewTx(stepExecutionId, "FmsCustSysInterfaceSISuspenseStep", "OK", strRtnMsg);
        return RepeatStatus.FINISHED;
    }

}
