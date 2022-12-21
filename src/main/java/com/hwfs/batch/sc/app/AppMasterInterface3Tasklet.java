package com.hwfs.batch.sc.app;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.sc.app.dao.AppMasterInterfaceDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * 식재앱 운영단가율 송신 배치Scheduler Job Class
 * @ClassName AppMasterInterface3Tasklet.java
 * @Description AppMasterInterface3Tasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.10.18.   김명섭        최초생성
 * </pre>
 */
public class AppMasterInterface3Tasklet implements Tasklet {

    @Resource(name = "/batch/sc/app/appMasterInterfaceDAO")
    private AppMasterInterfaceDAO appMasterInterfaceDAO;

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();
        
        //System.out.println("AppMasterInterface3Tasklet stepExecutionId : " + stepExecutionId);
        
        Map<String, Object> retProcVal = new HashMap<String, Object>();
        int procCnt=0;

        Map<String, Object> param = new HashMap<String, Object>();

        procCnt = appMasterInterfaceDAO.batchJob3(param);
        
        if(procCnt > -1)
        {
        	retProcVal.put("PO_RTN","TRUE");
            //인서트 건수 기록
            retProcVal.put("PO_CNT",procCnt);
        }else{
        	retProcVal.put("PO_RTN","FALSE");
        	//인서트 건수 기록
            retProcVal.put("PO_CNT",0);
        }

        // 로그를 쌓는다.
        String strRtnMsg = "";
        
        if (!LimsUtil.checkNull(retProcVal.get("PO_RTN")).equals("TRUE")) {
            strRtnMsg = LimsUtil.checkNull(retProcVal.get("PO_RTNMSG"));
            batchStepLogService.insertNewTx(stepExecutionId, "AppMasterInterface3Step", "FAILED", strRtnMsg);
            
            step.setExitStatus(ExitStatus.FAILED);		//FAILED로 상태 설정
            // Rollback 처리 위해서 Exception 발생
            throw new BizException (strRtnMsg);
        }

        strRtnMsg = LimsUtil.checkNull(retProcVal.get("PO_CNT"), 0) + "건이 처리 되었습니다.";
        batchStepLogService.insertNewTx(stepExecutionId, "AppMasterInterface3Step", "OK", strRtnMsg);
        return RepeatStatus.FINISHED; 	//Step 종료
    }

}
