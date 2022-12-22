package com.hwfs.batch.sm.sar;

import hone.core.util.record.RecordSet;

import java.math.BigDecimal;
import java.sql.Date;
import java.text.SimpleDateFormat;
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

import com.hwfs.batch.sm.sar.dao.SarSuspenseSapSendParamDAO;
import com.hwfs.batch.sm.sar.service.SarSuspenseSapSendParamService;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.sap.request.SuspenseReceiveRequest;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * SarSuspenseSapSendParamTasklet에 대한 설명 작성
 * @ClassName SarSuspenseSapSendParamTasklet.java
 * @Description SarSuspenseSapSendParamTasklet Class
 * @Modification-Information
 * <pre>
 *    수정일              수정자                 수정내용
 *  ----------   ----------   -------------------------------
 *  2021. 05. 13.   박소영           최초생성
 * </pre>
 * @author 박소영
 * @since 2021. 05. 13.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class SarSuspenseSapSendParamTasklet implements Tasklet {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** Batch Step Log Service Bean 생성 */
    @Resource(name = "/sc/scb/batchStepLogService")
    private BatchStepLogService batchStepLogService;
    
    @Resource(name = "/batch/sm/sar/sarSuspenseSapSendParamService")
	private SarSuspenseSapSendParamService sarSuspenseSapSendParamService;
    
    /** SarSuspenseSapSendDAO Bean 생성 */
	@Resource(name = "/batch/sm/sar/sarSuspenseSapSendParamDAO")
	private SarSuspenseSapSendParamDAO sarSuspenseSapSendParamDAO;	
	
	@Resource(name = "EAIService")
	EAIService eaiService;	

    /**
	 * 가수금 자동 대체 배치 처리
	 * <pre>
	 * 가수금 자동 대체 배치 처리
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
		
		long time = System.currentTimeMillis();
		
		SimpleDateFormat sTime = new SimpleDateFormat("HHmmss", java.util.Locale.getDefault());
		
		String strTime = sTime.format(new Date(time));
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		RecordSet getSapSuspenseAltDetail = sarSuspenseSapSendParamDAO.selectListSapSuspenseAltDetail(param);
		
		/************************************************************************************************
		 * SAP IFC 가수금 입금 반제 Start
		************************************************************************************************/
		for (int i = 0 ; i < getSapSuspenseAltDetail.size() ; i++) {
			Map<String, Object> rowData = getSapSuspenseAltDetail.get(i);
			
			SuspenseReceiveRequest dto = new SuspenseReceiveRequest();
			
			dto.setBuCd(LimsUtil.checkNull(rowData.get("buCd")).toString().trim());
			dto.setSapSuspenseNum(LimsUtil.checkNull(rowData.get("sapSuspenseNum")).toString().trim());
			dto.setSeq(Integer.parseInt(LimsUtil.checkNull(rowData.get("altSeq")).toString()));
			dto.setAltProcUser(LimsUtil.checkNull(rowData.get("cuser")).toString().trim());
			dto.setAmt((BigDecimal) rowData.get("altAmt"));
			dto.setCcCd(LimsUtil.checkNull(rowData.get("ccCd")).toString().trim());
			dto.setAltDate(LimsUtil.checkNull(rowData.get("altDate")).toString().trim());
			dto.setSapCustCd(LimsUtil.checkNull(rowData.get("sapCustCd")).toString().trim());
			dto.setAltProcDate(LimsUtil.checkNull(rowData.get("altDate")).toString().trim());
			
			dto.setAltProcTime(strTime);
			dto.setCurrency("KRW");
			dto.setAltSlipNum(" ");
			if("L".equals(LimsUtil.checkNull(rowData.get("recdStatus")))){
				dto.setReqType("1");				
			}else{
				dto.setReqType("2");				
			}
			
			eaiService.call(dto);
		}
		
		if (getSapSuspenseAltDetail.size() > 0) {
			//정상적으로  EAI호출시 가수금 대체 정보테이블에 업데이트 처리 Service 호출
			sarSuspenseSapSendParamService.updateSapSuspenseAltDetail(param);
			
	        batchStepLogService.insertNewTx(stepExecutionId, "SarSuspenseSapSendParamTaskletStep", "OK", getSapSuspenseAltDetail.size() + "건 처리 완료");
	    }else if (getSapSuspenseAltDetail.size() == 0) {
			//전송대상 데이터 0건
	        batchStepLogService.insertNewTx(stepExecutionId, "SarSuspenseSapSendParamTaskletStep", "OK", "전송대상 없음. 0건 처리 완료");
	    }
		else {
			batchStepLogService.insertNewTx(stepExecutionId, "SarSuspenseSapSendParamTaskletStep", "FAILED", "생성실패");
			step.setExitStatus(ExitStatus.FAILED);

			throw new BizException("생성실패");
		}		

		return RepeatStatus.FINISHED;
	}

}
