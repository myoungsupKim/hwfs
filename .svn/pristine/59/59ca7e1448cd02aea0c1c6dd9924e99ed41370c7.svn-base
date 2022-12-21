package com.hwfs.batch.guide.sample;

import java.math.BigDecimal;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.BatchStatus;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.hwfs.batch.guide.sample.dao.CustomerDAO;
import com.hwfs.batch.guide.sample.dto.CustomerCreditDTO;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.scb.service.BatchStepLogService;

/**
 * ItemReader와 ItemWriter를 사용하지 않고 단순히 메소드 하나로 기능을 구현하는 SimpleTasklet 예
 * - RepeatStatus.FINISHED를 반환하거나 에러가 발생하기 전까지 계속 실행하는 execute() 하나의 메소드를 갖는 간단한 인터페이스로
 * - 저장 프로시저, 스크립트, 또는 간단한 SQL 업데이트 문을 호출 할 수 있다. 
 * @ClassName SimpleTasklet.java
 * @Description SimpleTasklet Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 23.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 23.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class SimpleTasklet extends DefaultServiceImpl implements Tasklet {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** Batch Step Log Service Bean 생성 */
	@Resource(name = "/sc/scb/batchStepLogService")
	private BatchStepLogService batchStepLogService;
	
	@Resource(name = "/batch/guide/sample/customerDAO")
	private CustomerDAO customerDAO;
	
	/** Job Xml 선언된 value */
	private String value;
	
	//오류 테스트용
	private static int count=0;
	
	/** Job Xml에 정의된 파라미터를 받기 위한 setter */
	public void setValue(String value) {
		this.value = value;
	}

	/**
	 * DAO를 통해 데이터가 처리되도록 한다.
	 * <pre>
	 * - 테스트를 위해 첫번째 호출은 commit, 그 다음부터는 rollback되도록 했음
	 * - RepeatStatus.FINISHED를 반환되어야 처리된 전체가 commit 됨.
	 * - 그렇지 않거나 Exception 발생하면 rollback 됨
	 * </pre>
	 *
	 * @param arg0
	 * @param arg1
	 * @return
	 * @throws Exception
	 * @see org.springframework.batch.core.step.tasklet.Tasklet#execute(org.springframework.batch.core.StepContribution, org.springframework.batch.core.scope.context.ChunkContext)
	 */
	public RepeatStatus execute(StepContribution step, ChunkContext chunkContext) throws Exception {
		logger.debug("***************Job Xml value={} , call arg1={}", value, chunkContext.getStepContext().getJobParameters().get("value"));
		//long jobExecutionId = chunkContext.getStepContext().getStepExecution().getJobExecutionId();
		long stepExecutionId = chunkContext.getStepContext().getStepExecution().getId() ;

		CustomerCreditDTO customerCredit = new CustomerCreditDTO ();
		count += 1;
		for (int i=1; i<=5; i++) {
			customerCredit.setId(i);
			customerCredit.setCredit(BigDecimal.valueOf(10));	//증가시킬 값
			customerDAO.incrementCredit(customerCredit);		//DAO를 호출하는 경우
		}
		
		//오류 처리를 하는 경우 : Exception을 Catch않으면 BatchFramework에서 처리
		//                        단,  Tasklet에서 오류를 처리하는 경우는 다음과 같이 처리
		if (count!=1) {
			//로그를 쌓는다.
			batchStepLogService.insertNewTx(stepExecutionId, "simpleTaskletStep1", "FAILED", "오류메시지....");

			step.setExitStatus(ExitStatus.FAILED);		//FAILED로 상태 설정
			
			//Rollback 처리 위해서 Exception 발생
			throw new BizException ("오류메시지...");	 
			//또는
			//throw processException ("fail.common.msg");	//메시지 ID는 업무에 맞게 등록하여 사용
		}
		
		return RepeatStatus.FINISHED;					//Step 종료
	}
}
