package com.hwfs.batch.ft.ftr;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.ft.ftr.dao.FtrNonarrivInventoryDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * FtrNonarrivInventoryTasklet에 대한 설명 작성
 * @ClassName FtrNonarrivInventoryTasklet.java
 * @Description FtrNonarrivInventoryTasklet Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.10.29.   김명섭        최초생성
 * </pre>
 * @author FC정보기획팀 : 한화시스템ICT 김명섭
 * @since 2019.10.29.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class FtrNonarrivInventoryTasklet implements Tasklet {

    @Resource(name = "/batch/sc/ftr/ftrNonarrivInventoryDao")
    private FtrNonarrivInventoryDAO ftrNonarrivInventoryDAO;

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
        
        retProcVal = ftrNonarrivInventoryDAO.ftrNonarrivInventoryPro(procParam);
        
        //System.out.println("lngRtn:" + retProcVal.get("lngRtn"));
        //System.out.println("lngCount:" + retProcVal.get("lngCount"));
        //System.out.println("strDesc:" + retProcVal.get("strDesc"));

        // 로그를 쌓는다.
        String strRtnMsg = "";
        int iRtn = (Integer)retProcVal.get("lngRtn");
        
        if (iRtn != 0) {
            strRtnMsg = LimsUtil.checkNull(retProcVal.get("strDesc"));
            batchStepLogService.insertNewTx(stepExecutionId, "FtrNonarrivInventoryProStep", "FAILED", strRtnMsg);

            step.setExitStatus(ExitStatus.FAILED);		//FAILED로 상태 설정
            // Rollback 처리 위해서 Exception 발생
            throw new BizException (strRtnMsg);
        }

        strRtnMsg = LimsUtil.checkNull(retProcVal.get("lngCount"), 0) + "건이 처리 되었습니다.";
        batchStepLogService.insertNewTx(stepExecutionId, "FtrNonarrivInventoryProStep", "OK", strRtnMsg);
        return RepeatStatus.FINISHED; 	//Step 종료
    }

}