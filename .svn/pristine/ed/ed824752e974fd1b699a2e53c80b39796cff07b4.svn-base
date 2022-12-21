package com.hwfs.batch.fs.fsm;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.fs.fsm.dao.FsmEsimgSumDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * FsmEsimgSumTasklet에 대한 설명 작성
 * @ClassName FsmEsimgSumTasklet.java
 * @Description FsmEsimgSumTasklet Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018. 7. 18.   김명섭        최초생성
 * </pre>
 * @author FC정보기획팀 : 한화S&C 김명섭
 * @since 2018. 7. 18.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class FsmEsimgSumTasklet implements Tasklet {

    @Resource(name = "/batch/sc/fsm/fsmEsimgSumDao")
    private FsmEsimgSumDAO fsmEsimgSumDAO;

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        //long jobExecutionId = chunkContext.getStepContext().getStepExecution().getJobExecutionId();
        long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

        Map<String, Object> retProcVal = new HashMap<String, Object>();

        Map<String, Object> procParam = new HashMap<String, Object>();
        String strStartDate = LimsUtil.getDateAdd("yyyyMMdd", "date", 0).substring(0,6)+"01";
        String strEndDate = LimsUtil.getDateAdd("yyyyMMdd", "date", 0);

        procParam.put("strInParams", strStartDate+"#"+strEndDate);
        procParam.put("strUserID", "BatchJob");
        procParam.put("strUserIP", "");
        procParam.put("strHPtr", "");
        
        retProcVal = fsmEsimgSumDAO.fsmEsimgSumPro(procParam);
        
        //System.out.println("lngRtn:" + retProcVal.get("lngRtn"));
        //System.out.println("lngCount:" + retProcVal.get("lngCount"));
        //System.out.println("strDesc:" + retProcVal.get("strDesc"));

        // 로그를 쌓는다.
        String strRtnMsg = "";
        int iRtn = (Integer)retProcVal.get("lngRtn");
        
        if (iRtn != 0) {
            strRtnMsg = LimsUtil.checkNull(retProcVal.get("strDesc"));
            batchStepLogService.insertNewTx(stepExecutionId, "FsmEsimgSumProStep", "FAILED", strRtnMsg);

            step.setExitStatus(ExitStatus.FAILED);		//FAILED로 상태 설정
            // Rollback 처리 위해서 Exception 발생
            throw new BizException (strRtnMsg);
        }

        strRtnMsg = LimsUtil.checkNull(retProcVal.get("lngCount"), 0) + "건이 처리 되었습니다.";
        batchStepLogService.insertNewTx(stepExecutionId, "FsmEsimgSumProStep", "OK", strRtnMsg);
        return RepeatStatus.FINISHED; 	//Step 종료
    }

}