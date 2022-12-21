package com.hwfs.batch.fm.fmo;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.fm.fmo.dao.MoadamSysInterfaceDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * @ClassName MoadamSysInterfaceTasklet.java
 * @Description MoadamSysInterfaceTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------

 * </pre>
 * @author hye.jin94
 * @since 2021. 09. 21.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2020 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class MoadamSysInterfaceTasklet implements Tasklet {

    @Resource(name = "/batch/fm/fmo/moadamSysInterfaceDAO")
    private MoadamSysInterfaceDAO moadamSysInterfaceDAO;

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        
    	long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

    	int procCount=-1;
        Map<String, Object> param = new HashMap<String, Object>();
        
        procCount = moadamSysInterfaceDAO.batchJobSuspense(param);
        
        String strRtnMsg = "";
        	   strRtnMsg = "[" + procCount + "] 건이 처리 되었습니다..";
        
        if (  procCount == -1 ) {
            batchStepLogService.insertNewTx(stepExecutionId, "moadamSysInterfaceTaskletStep", "FAILED", "HTTP error");
            
            step.setExitStatus(ExitStatus.FAILED);
            throw new BizException ("HTTP error! 인터페이스실패!");
        }

        batchStepLogService.insertNewTx(stepExecutionId, "moadamSysInterfaceTaskletStep", "OK", strRtnMsg);
        
        return RepeatStatus.FINISHED;
    }

}
