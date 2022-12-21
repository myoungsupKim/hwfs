package com.hwfs.batch.sc.scp;

import java.util.Map;

import org.springframework.batch.item.ItemProcessor;

/**
 * 업무별 개인정보 보유기간 초과 파기 처리 ItemProcessor
 * 
 * @ClassName DstryProcessEtcProcessor.java
 * @Description DstryProcessEtcProcessor Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 01.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 5. 28.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class DstryProcessEtcProcessor implements ItemProcessor<Map<String, Object>, Map<String, Object>> {
	
	/**
	 * Processor 처리
	 */
	public Map<String, Object> process(Map<String, Object> item) throws Exception {
		//ItemProcessor에서는 별도 작업이 없고 ItemWriter로 넘긴다.
		return item;
	}

}
