package com.hwfs.batch.fm.fms;

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

import com.hwfs.cmn.exception.BizException;
import com.hwfs.batch.fm.fms.dao.FmsBuySaleSumDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * FmsBuySaleSumTasklet에 대한 설명 작성
 * @ClassName FmsBuySaleSumTasklet.java
 * @Description FmsBuySaleSumTasklet Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018. 05. 23.   kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : kihoon
 * @since 2018. 05. 23.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class FmsBuySaleSumTasklet implements Tasklet {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;
    
    /** BuySaleSumService Bean 생성 */
  	@Resource(name = "/batch/fm/fms/fmsBuySaleSumDAO")
  	private FmsBuySaleSumDAO fmsBuySaleSumDAO;

	/**
	 * execute 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param arg0
	 * @param arg1
	 * @return
	 * @throws Exception
	 * @see org.springframework.batch.core.step.tasklet.Tasklet#execute(org.springframework.batch.core.StepContribution, org.springframework.batch.core.scope.context.ChunkContext)
	*/
	@Override
	public RepeatStatus execute(StepContribution step, ChunkContext chunkContext)
			throws Exception {
		
		long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId();

        Map<String, Object> procParam = new HashMap<String, Object>();
        Map<String, Object> retProcVal = new HashMap<String, Object>();
        procParam.put("P_GUBUN", "");
        
        retProcVal = fmsBuySaleSumDAO.callCheckExcute(procParam);
        logger.debug("retProcVal="+retProcVal);
        // 로그를 쌓는다.
        String strRtnMsg = "";
        if (!LimsUtil.checkNull(retProcVal.get("O_RTN")).equals("TRUE")) {
            strRtnMsg = LimsUtil.checkNull(retProcVal.get("O_RTNMSG"));
            batchStepLogService.insertNewTx(stepExecutionId, "FmsBuySaleSumJobProStep", "FAILED", strRtnMsg);

            step.setExitStatus(ExitStatus.FAILED);		//FAILED로 상태 설정
            // Rollback 처리 위해서 Exception 발생
            throw new BizException (strRtnMsg);
        }

        strRtnMsg = "["+LimsUtil.getDate("yyyyMMddHHmmss")+"]기준영업일 Count="+LimsUtil.checkNull(retProcVal.get("O_RTNMSG"), 0);
        batchStepLogService.insertNewTx(stepExecutionId, "FmsBuySaleSumJobProStep", "OK", strRtnMsg);
        return RepeatStatus.FINISHED; 	//Step 종료
	}
}
