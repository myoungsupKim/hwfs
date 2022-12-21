package com.hwfs.batch.ma.map;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import com.hwfs.batch.ma.map.dao.MapMarginRatejobProDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * 매출데이터 강제생성 Scheduler Job Class
 * @ClassName MapMarginRatejobProJobTasklet.java
 * @Description MapMarginRatejobProJobTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 1. 29.   맹수영       최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 맹수영
 * @since 2015. 9. 17.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class MapMarginRatejobProJobTasklet implements Tasklet {

    /** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;
	
    @Resource(name = "/batch/sc/map/MapMarginRatejobProDAO")
    private MapMarginRatejobProDAO MapMarginRatejobProDAO;


    public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
        //long jobExecutionId = chunkContext.getStepContext().getStepExecution().getJobExecutionId();
        long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

        Map<String, Object> retProcVal = new HashMap<String, Object>();

        Map<String, Object> procParam = new HashMap<String, Object>();
        //procParam.put("pi_date_f", LimsUtil.getDateAdd("yyyyMMdd", "date", -1));
        //procParam.put("pi_date_t", LimsUtil.getDateAdd("yyyyMMdd", "date", -1));
        //procParam.put("pi_part_code", "");
        //procParam.put("pi_sabun", "900101004");
        retProcVal = MapMarginRatejobProDAO.MapMarginRatejobPro(procParam);

        // 로그를 쌓는다.
        String strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_RTNMSG"));
        if (!LimsUtil.checkNull(retProcVal.get("O_RTN")).equals("TRUE")) {
        	//MapMarginRatejobProJobTaskletStep 로 변경 , 배치 실행안되서 수정 처리자 : 맹수영 20160617 (SR201606_11062)
            batchStepLogService.insertNewTx(stepExecutionId, "MapMarginRatejobProJobTaskletStep", "FAILED", strRtnMsg);
        }
        else
        {
            batchStepLogService.insertNewTx(stepExecutionId, "MapMarginRatejobProJobTaskletStep", "OK", strRtnMsg);
        }

        return RepeatStatus.FINISHED; 	//Step 종료
    }

}
