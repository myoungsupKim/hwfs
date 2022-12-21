package com.hwfs.batch.sc.scp;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.annotation.BeforeStep;
import org.springframework.batch.item.ItemWriter;

import com.hwfs.batch.sc.scp.dao.DstryProcessEtcDAO;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * 시험의뢰자 보유기간 초과 파기 처리 건에 대한 ItemWriter
 * @ClassName DstryProcessTestReqWriter.java
 * @Description DstryProcessTestReqWriter Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 09. 01.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class DstryProcessTestReqWriter extends DefaultServiceImpl implements ItemWriter<Map<String,Object>>{
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "/batch/sc/scp/dstryProcessEtcDAO")
	private DstryProcessEtcDAO dstryProcessEtcDAO;

	/** Batch Step Log Service Bean 생성 */
	@Resource(name = "/sc/scb/batchStepLogService")
	private BatchStepLogService batchStepLogService;

	private long stepExecutionId;

	/**
	 * stepExecutioId를 얻는다.
	 *
	 * @param stepExecution
	 */
	@BeforeStep
	public void beforeStep(StepExecution stepExecution) {
	    stepExecutionId = stepExecution.getId();
	}
	
	/**
	 * DB로 Item을 Write
	 * <pre>
	 * - Service 보다는 DAO를 호출하여 DB 처리
	 * </pre>
	 *
	 * @param list
	 * @throws Exception
	 * @see org.springframework.batch.item.ItemWriter#write(java.util.List)
	*/
	@Override
	public void write(List<? extends Map<String,Object>> list) throws Exception {
		
		for (Map<String, Object> map:list) {
			//개인정보를 파기하여 기록
			int cnt = dstryProcessEtcDAO.updateDstryTestReq(map);
			if (cnt > 0) {
				//개인정보파기이력에 파기상태로 기록
				map.put("dstryModClass", "TESTREQ");
				dstryProcessEtcDAO.insertDstryLog(map);
				
				String strMsg = String.format("시험의뢰자[%s] 정보가 파기되었습니다.", map.get("dstryObjName").toString());
				logger.info(strMsg);
				
				//처리로그 기록
				batchStepLogService.insertNewTx(stepExecutionId, "dstryProcessTestReqStep", "OK", strMsg);
			}
		}
	}
	

}
