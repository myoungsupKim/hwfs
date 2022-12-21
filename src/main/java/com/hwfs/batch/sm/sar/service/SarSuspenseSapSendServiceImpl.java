package com.hwfs.batch.sm.sar.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.batch.sm.sar.dao.SarSuspenseSapSendDAO;
import com.hwfs.cmn.defaults.DefaultServiceImpl;

@Service("/batch/sm/sar/sarSuspenseSapSendService")
public class SarSuspenseSapSendServiceImpl extends DefaultServiceImpl implements SarSuspenseSapSendService {

	@Resource(name = "/batch/sm/sar/sarSuspenseSapSendDAO")
	private SarSuspenseSapSendDAO sarSuspenseSapSendDAO;	//ONLINE용 데이터소스를 이용한 DAO
	
	/**
	 * Customer Credit를 증가시킨다.
	 * - Online Service를 이용하여 분리된 Tx 처리하는 예
	 * @param customerCredit
	 *            - 수정할 정보가 담긴 CustomerCredit
	 * @return int 1=성공, 0=실패
	 * @exception Exception
	 */
	public int updateSapSuspenseAltDetail(Map<String, Object> mapParam) throws Exception {
		return sarSuspenseSapSendDAO.updateSapSuspenseAltDetail(mapParam);
	}

}
