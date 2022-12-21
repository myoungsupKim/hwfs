package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.SmallOrderCtrlMgntDAO;
import com.tobesoft.xplatform.data.DataSet;

@Service("/fm/fms/smallOrderCtrlMgntService")
public class SmallOrderCtrlMgntServiceImpl extends DefaultServiceImpl implements SmallOrderCtrlMgntService {
	

	@Resource(name = "/fm/fms/smallOrderCtrlMgntDAO")
	private SmallOrderCtrlMgntDAO smallOrderCtrlMgntDAO;

	
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return smallOrderCtrlMgntDAO.selectList(mapParam);
	}
	
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if ( "1".equals(rowData.get("chk").toString()) ) {
				updRowCnt += smallOrderCtrlMgntDAO.update(rowData);
			}
		}
		
		return updRowCnt;
	}
	
	public RecordSet selectCtrlList(Map<String, Object> mapParam) throws Exception {
		return smallOrderCtrlMgntDAO.selectCtrlList(mapParam);
	}
}
