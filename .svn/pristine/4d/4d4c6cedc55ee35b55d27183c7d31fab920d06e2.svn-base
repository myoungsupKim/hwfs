package com.hwfs.batch.fm.fmo;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.fm.fmo.dao.HubmekaPriceSysInterfaceDAO;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * @ClassName HubmekaPriceSysInterfaceTasklet.java
 * @Description HubmekaPriceSysInterfaceTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------

 * </pre>
 * @author hye.jin94
 * @since 2022. 07. 20.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2020 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class HubmekaPriceSysInterfaceTasklet implements Tasklet {

    @Resource(name = "/batch/fm/fmo/hubmekaPriceSysInterfaceDAO")
    private HubmekaPriceSysInterfaceDAO hubmekaPriceSysInterfaceDAO;

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;

    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        
    	long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

    	int procCount=-1;
        Map<String, Object> param = new HashMap<String, Object>();
        
        RecordSet getParamDetail = hubmekaPriceSysInterfaceDAO.selectParamList2(param);
       
        Record r = getParamDetail.get(0);
		
		
		String in_url = r.getString("serviceGubun");
		String in_userId = r.getString("userid");
		String in_startDay = r.getString("piPriceDate");
		String in_gubun = r.getString("piPriceGubun");

        
        param.put("in_url", in_url); // 서비스구분
        param.put("in_userId", in_userId); // user id
        param.put("in_startDay", in_startDay); // 단가시작일자
        param.put("in_gubun", in_gubun); // 단가구분

        
        procCount = hubmekaPriceSysInterfaceDAO.batchJobSuspense(param);
        
        String strRtnMsg = "";
        	   strRtnMsg = "[" + procCount + "] 건이 처리 되었습니다..";
        
        if (  procCount == -1 ) {
            batchStepLogService.insertNewTx(stepExecutionId, "hubmekaPriceSysInterfaceTaskletStep", "FAILED", "HTTP error");
            
            step.setExitStatus(ExitStatus.FAILED);
            throw new BizException ("HTTP error! 인터페이스실패!");
        }

        batchStepLogService.insertNewTx(stepExecutionId, "hubmekaPriceSysInterfaceTaskletStep", "OK", strRtnMsg);
        
        return RepeatStatus.FINISHED;
    }

}
