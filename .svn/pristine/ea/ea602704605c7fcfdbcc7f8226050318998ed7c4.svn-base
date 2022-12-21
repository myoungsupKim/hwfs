package com.hwfs.batch.sc.scp;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.annotation.BeforeStep;
import org.springframework.batch.item.ItemWriter;

import com.hwfs.batch.sc.scp.dao.DstryProcessDAO;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scb.service.BatchStepLogService;

 /**
 * 접속사용자 개인정보 파기 처리 건에 대한 ItemWriter
 * @ClassName DstryProcessWriter.java
 * @Description DstryProcessWriter Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 05. 28.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class DstryProcessWriter extends DefaultServiceImpl implements ItemWriter<Map<String,Object>>{
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "/batch/sc/scp/dstryProcessDAO")
	private DstryProcessDAO dstryProcessDAO;

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
			//사용자정보에 개인정보를 파기하여 기록
			int cnt = dstryProcessDAO.updateDstryUserInfo(map);
			if (cnt > 0) {
				//개인정보파기이력에 파기상태로 기록
				dstryProcessDAO.updateDstryLog(map);
				
				String strMsg = String.format("사용자계정[SABUN=%s]이 파기되었습니다.", map.get("sabun").toString());
				logger.info(strMsg);
				
				//처리로그 기록
				batchStepLogService.insertNewTx(stepExecutionId, "dstryProcessStep", "OK", strMsg);
			}
		}
	}
	

}
