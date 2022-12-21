package com.hwfs.batch.fm.fms;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.fm.fms.dao.FmsCustSysInterfaceSubinvDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * 식재영업 고객인터페이스 창고자료 전송 배치Scheduler Job Class
 * @ClassName FmsCrtCrdInfoProTasklet.java
 * @Description FmsCrtCrdInfoProTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.01.21.   lionfrnd        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS lionfrnd
 * @since 2016.01.21.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class FmsCustSysInterfaceSubinvTasklet implements Tasklet {

    @Resource(name = "/batch/fm/fms/fmsCustSysInterfaceSubinvDAO")
    private FmsCustSysInterfaceSubinvDAO fmsCustSysInterfaceSubinvDAO;

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        //long jobExecutionId = chunkContext.getStepContext().getStepExecution().getJobExecutionId();
        long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

        Map<String, Object> retProcVal = new HashMap<String, Object>();
        int insertCount=0;

        // FSUS.FMS_SUBULCREATE_JOB_PRO(TO_CHAR(SYSDATE-1,'YYYYMMDD'), '900101004');
        Map<String, Object> param = new HashMap<String, Object>();
        //procParam.put("p_upjang", "");
        //procParam.put("p_subinv_code", "");
        //procParam.put("pi_date", LimsUtil.getDateAdd("yyyyMMdd", "date", 1));
        //procParam.put("pi_date", LimsUtil.getDate("yyyyMMdd"));
        //procParam.put("pi_date", "");
        //procParam.put("p_cuser", "900101004");
        param.put("pi_date", LimsUtil.getDate("yyyyMMdd"));		//오늘날짜
        param.put("schDate1", LimsUtil.getDate("yyyyMMdd"));	//오늘날짜
        param.put("schDate2", LimsUtil.getDate("yyyyMMdd"));	//오늘날짜
        param.put("schCust", "418579");							//이연에프엔씨 음성공장

        insertCount = fmsCustSysInterfaceSubinvDAO.batchJob(param);
        
        if(insertCount > -1)
        {
        	retProcVal.put("PO_RTN","TRUE");
            //인서트 건수 기록
            retProcVal.put("PO_CNT",insertCount);
        }else{
        	retProcVal.put("PO_RTN","FALSE");
        	//인서트 건수 기록
            retProcVal.put("PO_CNT",0);
        }

        // 로그를 쌓는다.
        String strRtnMsg = "";
        
        if (!LimsUtil.checkNull(retProcVal.get("PO_RTN")).equals("TRUE")) {
            strRtnMsg = LimsUtil.checkNull(retProcVal.get("PO_RTNMSG"));
            batchStepLogService.insertNewTx(stepExecutionId, "FmsCustSysInterfaceSubinvStep", "FAILED", strRtnMsg);
            
            step.setExitStatus(ExitStatus.FAILED);		//FAILED로 상태 설정
            // Rollback 처리 위해서 Exception 발생
            throw new BizException (strRtnMsg);
        }

        strRtnMsg = LimsUtil.checkNull(retProcVal.get("PO_CNT"), 0) + "건이 처리 되었습니다.";
        batchStepLogService.insertNewTx(stepExecutionId, "FmsCustSysInterfaceSubinvStep", "OK", strRtnMsg);
        return RepeatStatus.FINISHED; 	//Step 종료
    }

}
