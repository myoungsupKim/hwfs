package com.hwfs.batch.sm.sar.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.batch.sm.sar.dao.SarSuspenseSapSendParamDAO;
import com.hwfs.cmn.defaults.DefaultServiceImpl;

@Service("/batch/sm/sar/sarSuspenseSapSendParamService")
public class SarSuspenseSapSendParamServiceImpl extends DefaultServiceImpl implements SarSuspenseSapSendParamService {

	@Resource(name = "/batch/sm/sar/sarSuspenseSapSendParamDAO")
	private SarSuspenseSapSendParamDAO sarSuspenseSapSendParamDAO;
	
	public int updateSapSuspenseAltDetail(Map<String, Object> mapParam) throws Exception {
		return sarSuspenseSapSendParamDAO.updateSapSuspenseAltDetail(mapParam);
	}

}
