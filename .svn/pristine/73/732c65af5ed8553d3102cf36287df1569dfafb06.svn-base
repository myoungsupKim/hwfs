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

import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.cmn.service.CardItfcService;
import com.hwfs.sc.cmn.util.DateUtil;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * CmnCardItfcTasklet에 대한 설명 작성
 * @ClassName CmnCardItfcTasklet.java
 * @Description CmnCardItfcTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 12. 29.   강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 강대성
 * @since 2015. 12. 29.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class CmnCardItfcTasklet implements Tasklet {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;
    
    /** CardItfcService Bean 생성 */
	@Resource(name = "/sc/cmn/cardItfcService")
	private CardItfcService cardItfcService;

    /**
	 * 신용카드 거래내역 정보 파일을 읽어 DB에 저장하고 이력을 기록한다
	 * <pre>
	 * 신용카드 거래내역 정보 파일을 읽어 DB에 저장하고 이력을 기록한다
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
		
		Map<String, Object> param = new HashMap<String, Object>();

		String occrDtFr =  DateUtil.addDay(-1, "yyyyMMdd");
		String occrDtTo =  DateUtil.addDay(0, "yyyyMMdd");
		//String occrDtFr =  "20160423";
		//String occrDtTo =  "20160425";
		
		logger.debug("occrDtFr  >>>>>>" +occrDtFr);
		logger.debug("occrDtTo >>>>>" +occrDtTo);				
		
		param.put("compCd", "2000");
		param.put("sysTypeCd", "FC");
		param.put("brchCd", "0001");
		param.put("cardRecvType", "C01");
		param.put("occrDtFr", occrDtFr);
		param.put("occrDtTo", occrDtTo);
		param.put("isBatch", "Y");
		Map<String, Object> rtn = cardItfcService.processCardApInfo(param);
		
		if ("Y".equals(rtn.get("procCode").toString())) {
	        batchStepLogService.insertNewTx(stepExecutionId, "CmnCardItfcTaskletStep", "OK", rtn.get("procMsg").toString());
		}
		else {
			batchStepLogService.insertNewTx(stepExecutionId, "CmnCardItfcTaskletStep", "FAILED", "생성실패");
			step.setExitStatus(ExitStatus.FAILED);

			throw new BizException("생성실패");
		}
		
		
		/*
		Map<String, Object> param2 = new HashMap<String, Object>();
		
		String occrDtFr =  DateUtil.addDay(-1, "yyyyMMdd");
		String occrDtTo =  DateUtil.addDay(0, "yyyyMMdd");
		
		logger.debug("occrDtFr  >>>>>>" +occrDtFr);
		logger.debug("occrDtTo >>>>>" +occrDtTo);				
		
		param2.put("compCd", "2000");
		param2.put("sysTypeCd", "FC");
		param2.put("brchCd", "0001");
		param2.put("cardRecvType", "C03");
		param2.put("occrDtFr", occrDtFr);
		param2.put("occrDtTo", occrDtTo);
		param2.put("isBatch", "Y");
		Map<String, Object> rtn2 = cardItfcService.processCardReplyInfo(param2);
		
		logger.debug("procCode  >>>>>>" +rtn2.get("procCode").toString());
		logger.debug("procMsg >>>>>" +rtn2.get("procMsg").toString());
		
		if ("Y".equals(rtn2.get("procCode").toString())) {
	        batchStepLogService.insertNewTx(stepExecutionId, "CmnCardItfcTaskletStep", "OK", rtn2.get("procMsg").toString());
		}
		else {
			batchStepLogService.insertNewTx(stepExecutionId, "CmnCardItfcTaskletStep", "FAILED", "생성실패");
			step.setExitStatus(ExitStatus.FAILED);

			throw new BizException("생성실패");
		}
		*/
		
		return RepeatStatus.FINISHED;
	}

}
