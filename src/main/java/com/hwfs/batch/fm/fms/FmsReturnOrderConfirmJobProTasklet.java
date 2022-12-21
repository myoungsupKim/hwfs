package com.hwfs.batch.fm.fms;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.fm.fms.dao.FmsReturnOrderConfirmJobProDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.util.DateUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * 반환/교환/증정 주문 확정 / 검증 Scheduler Job Class
 * @ClassName FmsReturnOrderConfirmJobProTasklet.java
 * @Description FmsReturnOrderConfirmJobProTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.09.14   DEV02        최초생성
 * </pre>
 * @author FC종합전산구축 : [PJT]주문채널통합
 * @since 2021.09.14
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class FmsReturnOrderConfirmJobProTasklet implements Tasklet {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
    @Resource(name = "/batch/sc/fms/fmsReturnOrderConfirmJobProDAO")
    private FmsReturnOrderConfirmJobProDAO fmsReturnOrderConfirmJobProDAO;

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        //long jobExecutionId = chunkContext.getStepContext().getStepExecution().getJobExecutionId();
        long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();
        String batchHHmm = DateUtil.getDate(chunkContext.getStepContext().getStepExecution().getStartTime(), "HHmm");
        
        Map<String, Object> procParam = new HashMap<String, Object>();
        procParam.put("P_HHMM", batchHHmm); //WAS, DB SERVER 시간차 방지를 위해 WAS 시간으로 처리하기위해 설정
        
        Map<String, Object> retProcVal = fmsReturnOrderConfirmJobProDAO.fmsReturnOrderConfirmJobPro(procParam);

        // 로그를 쌓는다.
        String strRtnMsg = "";
        if (!LimsUtil.checkNull(retProcVal.get("O_RTN")).equals("TRUE")) {
            strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_RTNMSG"));
            batchStepLogService.insertNewTx(stepExecutionId, "FmsReturnOrderConfirmJobProStep", "FAILED", strRtnMsg);

            step.setExitStatus(ExitStatus.FAILED);		//FAILED로 상태 설정
            // Rollback 처리 위해서 Exception 발생
            throw new BizException (strRtnMsg);
        }

        strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_CNT"), 0) + "건이 처리 되었습니다.";
        batchStepLogService.insertNewTx(stepExecutionId, "FmsReturnOrderConfirmJobProStep", "OK", strRtnMsg);
        return RepeatStatus.FINISHED; 	//Step 종료
    }

}
