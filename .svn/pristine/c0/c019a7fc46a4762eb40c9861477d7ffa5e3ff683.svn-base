package com.hwfs.batch.guide.sample.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.batch.guide.sample.dao.Customer2DAO;
import com.hwfs.batch.guide.sample.dto.CustomerCreditDTO;
import com.hwfs.cmn.defaults.DefaultServiceImpl;

@Service("/batch/guide/sample/customerService")
public class CustomerServiceImpl extends DefaultServiceImpl implements CustomerService {

	@Resource(name = "/batch/guide/sample/customer2DAO")
	private Customer2DAO customer2DAO;	//ONLINE용 데이터소스를 이용한 DAO
	
	/**
	 * Customer Credit를 증가시킨다.
	 * - Online Service를 이용하여 분리된 Tx 처리하는 예
	 * @param customerCredit
	 *            - 수정할 정보가 담긴 CustomerCredit
	 * @return int 1=성공, 0=실패
	 * @exception Exception
	 */
	public int incrementCreditNewTx(CustomerCreditDTO customerCredit) throws Exception {
		return customer2DAO.incrementCredit(customerCredit);
	}

	/**
	 * Customer Credit를 증가시킨다.
	 * - Online Service를 이용하여 Tx 처리하는 예
	 * @param customerCredit
	 *            - 수정할 정보가 담긴 CustomerCredit
	 * @return int 1=성공, 0=실패
	 * @exception Exception
	 */
	public int incrementCredit(CustomerCreditDTO customerCredit) throws Exception {
		return customer2DAO.incrementCredit(customerCredit);
	}

}
