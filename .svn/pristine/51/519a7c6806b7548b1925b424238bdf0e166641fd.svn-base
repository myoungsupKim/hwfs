package com.hwfs.batch.guide.sample;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.batch.item.ItemWriter;

import com.hwfs.batch.guide.sample.dao.CustomerDAO;
import com.hwfs.batch.guide.sample.dto.CustomerCreditDTO;

 /**
 * ItemWriter 샘플
 * @ClassName CustomerCreditWriter.java
 * @Description CustomerCreditWriter Class 
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
public class CustomerCreditWriter implements ItemWriter<CustomerCreditDTO>{

	@Resource(name = "/batch/guide/sample/customerDAO")
	private CustomerDAO customerDAO;	//Batch용 데이터소스를 이용한 DAO

	/**
	 * DB로 Item을 Write하는 예
	 * <pre>
	 * - Service 보다는 DAO를 호출하여 DB 처리
	 * </pre>
	 *
	 * @param list
	 * @throws Exception
	 * @see org.springframework.batch.item.ItemWriter#write(java.util.List)
	*/
	@Override
	public void write(List<? extends CustomerCreditDTO> list) throws Exception {
		
		//TODO 업무에 따라 DAO를 이용하여 DB 처리
		for (CustomerCreditDTO customerCredit:list) {
			//업무에 따라 처리여부 검사하는 예 : --> ItemProcessor에서 처리하는 것이 맞으며 여기서 처리는 맞지 않음 (Write Count에 영향이 없음)
			//if ((customerCredit.getId()%2) == 0) continue;
			
			customerDAO.incrementCredit(customerCredit);
		}
	}
	

}
