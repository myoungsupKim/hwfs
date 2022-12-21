package com.hwfs.batch.guide.sample.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.batch.guide.sample.dto.CustomerCreditDTO;
import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 
 * Customer2 DAO (online용 데이터소스 사용)
 * @ClassName Customer2DAO.java
 * @Description Customer2DAO Class 
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
@Repository("/batch/guide/sample/customer2DAO")
public class Customer2DAO extends DefaultDAO {

	/**
	 * Customer를 등록한다.
	 * 
	 * @param map
	 *            - 등록할 정보가 담긴 Map
	 * @return int 등록 결과 (건수)
	 * @exception Exception
	 */
	public int insertCustomer(Map<String, Object> map) throws Exception {
		return update("batch.guide.sample.customerDAO.insertCustomer", map);
	}

	/**
	 * Customer를 등록한다.
	 * 
	 * @param customerCredit
	 *            - 등록할 정보가 담긴 CustomerCredit
	 * @return int 등록 결과 (건수)
	 * @exception Exception
	 */
	public int insertCustomer(CustomerCreditDTO customerCredit) throws Exception {
		return update("batch.guide.sample.customerDAO.insertCustomer", customerCredit);
	}

	/**
	 * Customer를 수정한다.
	 * 
	 * @param map
	 *            - 수정할 정보가 담긴 Map
	 * @return int 1=성공, 0=실패
	 * @exception Exception
	 */
	public int updateCustomer(Map<String, Object> map) throws Exception {
		return update("batch.guide.sample.customerDAO.updateCustomer", map);
	}

	/**
	 * Customer Credit를 증가시킨다.
	 * 
	 * @param customerCredit
	 *            - 수정할 정보가 담긴 CustomerCredit
	 * @return int 1=성공, 0=실패
	 * @exception Exception
	 */
	public int incrementCredit(CustomerCreditDTO customerCredit) throws Exception {
		return update("batch.guide.sample.customerDAO.incrementCustomerCredits", customerCredit);
	}

	/**
	 * Customer를 삭제한다.
	 * 
	 * @param vo
	 *            - 삭제할 정보가 담긴 Map
	 * @return int 삭제건수
	 * @exception Exception
	 */
	public int deleteCustomer(Map<String, Object> map) throws Exception {
		return update("batch.guide.sample.customerDAO.deleteCustomer", map);
	}
}
