package com.hwfs.batch.guide.sample;

import java.math.BigDecimal;

import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.annotation.BeforeStep;
import org.springframework.batch.item.ItemProcessor;

import com.hwfs.batch.guide.sample.dto.CustomerCreditDTO;

/**
 * 배치 ItemProcessor 샘플
 * @ClassName CustomerCreditProcessor.java
 * @Description CustomerCreditProcessor Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 24.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class CustomerCreditProcessor implements ItemProcessor<CustomerCreditDTO, CustomerCreditDTO> {
	
	// credit을 증가할 수
	public static final BigDecimal FIXED_AMOUNT = new BigDecimal("5");

	//private long jobExecutionId;

	/**
	 * JobExecutioId를 얻는다.
	 *
	 * @param stepExecution
	 */
	@BeforeStep
	public void beforeStep(StepExecution stepExecution) {
	    //jobExecutionId = stepExecution.getJobExecutionId();
	}

	/**
	 * FIXED_AMOUNT만큼 증가 시킨 후 return
	 */
	public CustomerCreditDTO process(CustomerCreditDTO item) throws Exception {
		//중지 테스트를 위해 sleep처리
		//Thread.sleep(3000);
		
		//업무에 따라 처리여부 검사하는 예 : 짝수만 처리 --> 실제 Write Count가 준다.
		if ((item.getId()%2) == 0) return null;
		
		return item.increaseCreditBy(FIXED_AMOUNT);
	}

}
