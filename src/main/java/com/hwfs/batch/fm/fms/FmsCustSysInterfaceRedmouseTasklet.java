package com.hwfs.batch.fm.fms;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.fm.fms.dao.FmsCustSysInterfaceRedmouseDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * 레드마우스 고객인터페이스 자료 전송 배치Scheduler Job Class
 * @ClassName FmsCrtCrdInfoProTasklet.java
 * @Description FmsCrtCrdInfoProTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.12.23.   JHKim        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS lionfrnd
 * @since 2016.01.21.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class FmsCustSysInterfaceRedmouseTasklet implements Tasklet {

    @Resource(name = "/batch/fm/fms/fmsCustSysInterfaceRedmouseDAO")
    private FmsCustSysInterfaceRedmouseDAO fmsCustSysInterfaceRedmouseDAO;

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        
    	long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

        Map<String, Object> retProcVal = new HashMap<String, Object>();
        int insertCount=0;

        Map<String, Object> param = new HashMap<String, Object>();
        
        param.put("pi_date", LimsUtil.getDate("yyyyMMdd"));		//오늘날짜
        param.put("schDate1", LimsUtil.getDate("yyyyMMdd"));	//오늘날짜
        param.put("schDate2", LimsUtil.getDate("yyyyMMdd"));	//오늘날짜
        param.put("schCust", "179999");							//레드마우스 화성로컬푸드

        //param.put("pi_date", "20151001");		//오늘날짜
        //param.put("schDate1", "20151001");	//오늘날짜
        //param.put("schDate2", "20151001");	//오늘날짜
        //param.put("schCust", "418579");							//이연에프엔씨 음성공장
        
        insertCount = fmsCustSysInterfaceRedmouseDAO.batchJob(param);
        
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
            batchStepLogService.insertNewTx(stepExecutionId, "FmsCustSysInterfaceRedmouseStep", "FAILED", strRtnMsg);
            
            step.setExitStatus(ExitStatus.FAILED);		//FAILED로 상태 설정
            // Rollback 처리 위해서 Exception 발생
            throw new BizException (strRtnMsg);
        }

        strRtnMsg = LimsUtil.checkNull(retProcVal.get("PO_CNT"), 0) + "건이 처리 되었습니다.";
        batchStepLogService.insertNewTx(stepExecutionId, "FmsCustSysInterfaceRedmouseStep", "OK", strRtnMsg);
        return RepeatStatus.FINISHED; 	//Step 종료
    }

}
