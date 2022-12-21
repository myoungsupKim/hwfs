package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.ArPayCustMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * ArPayCustMgmtServiceImpl에 대한 설명 작성
 * @ClassName ArPayCustMgmtServiceImpl.java
 * @Description ArPayCustMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10. 14.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 5. 15.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/arPayCustMgmtService")
public class ArPayCustMgmtServiceImpl extends DefaultServiceImpl implements ArPayCustMgmtService {
	@Resource(name="/rc/sle/arPayCustMgmtDAO")
	private ArPayCustMgmtDAO arPayCustMgmt;

	 
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return arPayCustMgmt.selectList(parameter);
	}

	 
	 
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap arPayCustData) throws Exception {
		int procCnt = 0; 
		for (int i = 0 ; i < arPayCustData.size() ; i++) {
			Map<String, Object> parameter = arPayCustData.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += arPayCustMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += arPayCustMgmt.updateData(parameter);
			}
		}
 
		return  procCnt;
	}

}
