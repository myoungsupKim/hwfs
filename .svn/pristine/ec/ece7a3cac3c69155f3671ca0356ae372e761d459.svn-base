package com.hwfs.batch.guide.sample.service;

import com.hwfs.batch.guide.sample.dto.CustomerCreditDTO;


public interface CustomerService {
	
	/**
	 * Customer Credit를 증가시킨다.
	 * - Online Service를 이용하여 분리된 Tx 처리하는 예
	 * @param customerCredit
	 *            - 수정할 정보가 담긴 CustomerCredit
	 * @return int 1=성공, 0=실패
	 * @exception Exception
	 */
	public int incrementCreditNewTx(CustomerCreditDTO customerCredit) throws Exception;

	/**
	 * Customer Credit를 증가시킨다.
	 * - Online Service를 이용하여 Tx 처리하는 예
	 * @param customerCredit
	 *            - 수정할 정보가 담긴 CustomerCredit
	 * @return int 1=성공, 0=실패
	 * @exception Exception
	 */
	public int incrementCredit(CustomerCreditDTO customerCredit) throws Exception;

}
