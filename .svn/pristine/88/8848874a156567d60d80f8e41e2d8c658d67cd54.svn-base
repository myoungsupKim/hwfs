package com.hwfs.ma.map.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.service.PropertiesService;
import com.hwfs.cmn.util.RequestContextUtil;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ma.map.dao.MasStAccountDAO;
import com.tobesoft.xplatform.data.DataSet;

@Service("/ma/map/masStAccountService")
public class MasStAccountServiceImpl extends DefaultServiceImpl implements MasStAccountService {

    @Resource(name = "/ma/map/masStAccountDAO")
    private MasStAccountDAO masStAccountDAO;
 
    @Override
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return masStAccountDAO.selectList(mapParam);
    }

	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
        System.out.println("savelist start");

        for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += masStAccountDAO.insert(rowData);
				
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += masStAccountDAO.update(rowData);
				
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += masStAccountDAO.delete(rowData);

			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}

}