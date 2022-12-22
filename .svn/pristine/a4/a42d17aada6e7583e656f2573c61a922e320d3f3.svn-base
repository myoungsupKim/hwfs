package com.hwfs.batch.sc.cmn;

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

import com.hwfs.batch.sc.cmn.dao.HwfcHrIFDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * CmmHwfcHrIFTasklet에 대한 설명 작성
 * @ClassName CmmHwfcHrIFTasklet.java
 * @Description CmmHwfcHrIFTasklet Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.04.11.  김명섭        최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2019.04.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class CmmHwfcHrIFTasklet implements Tasklet {

    @Resource(name = "/batch/sc/cmn/dao/HwfcHrIFDAO")
    private HwfcHrIFDAO hwfcHrIFDAO;

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        //long jobExecutionId = chunkContext.getStepContext().getStepExecution().getJobExecutionId();
        long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

        Map<String, Object> retProcVal = new HashMap<String, Object>();

        Map<String, Object> procParam = new HashMap<String, Object>();

        procParam.put("strInParams", "");
        procParam.put("strUserID", "BatchJob");
        procParam.put("strUserIP", "");
        procParam.put("strHPtr", "");
        
        retProcVal = hwfcHrIFDAO.hwfcHrIFPro(procParam);
        
        //System.out.println("lngRtn:" + retProcVal.get("lngRtn"));
        //System.out.println("lngCount:" + retProcVal.get("lngCount"));
        //System.out.println("strDesc:" + retProcVal.get("strDesc"));

        // 로그를 쌓는다.
        String strRtnMsg = "";
        int iRtn = (Integer)retProcVal.get("lngRtn");
        
        if (iRtn != 0) {
            strRtnMsg = LimsUtil.checkNull(retProcVal.get("strDesc"));
            batchStepLogService.insertNewTx(stepExecutionId, "HwfcHrIFProStep", "FAILED", strRtnMsg);

            step.setExitStatus(ExitStatus.FAILED);		//FAILED로 상태 설정
            // Rollback 처리 위해서 Exception 발생
            throw new BizException (strRtnMsg);
        }

        strRtnMsg = LimsUtil.checkNull(retProcVal.get("lngCount"), 0) + "건이 처리 되었습니다.";
        batchStepLogService.insertNewTx(stepExecutionId, "HwfcHrIFProStep", "OK", strRtnMsg);
        return RepeatStatus.FINISHED; 	//Step 종료
    }

}
