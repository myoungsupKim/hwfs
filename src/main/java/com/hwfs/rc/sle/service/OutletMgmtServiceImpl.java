package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.OutletMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * OutletMgmtServiceImpl에 대한 설명 작성
 * @ClassName OutletMgmtServiceImpl.java
 * @Description OutletMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 19.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 3. 19.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/outletMgmtService")
public class OutletMgmtServiceImpl extends DefaultServiceImpl implements OutletMgmtService {
	@Resource(name="/rc/sle/outletMgmtDAO")
	private OutletMgmtDAO outletMgmt;
	
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.OutletMgmtService#selectList(java.util.Map)
	 */
	
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return outletMgmt.selectList(parameter);
	}

	 
	/**
	 * selectListOrg 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.OutletMgmtService#selectListOrg(java.util.Map)
	*/
	@Override
	public RecordSet selectListOrg(Map<String, Object> parameter) throws Exception {
		return outletMgmt.selectListOrg(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param sleOutletMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.OutletMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap sleOutletMgmt) throws Exception {
		int procCnt = 0;
		
		for (int i = 0 ; i < sleOutletMgmt.size() ; i++) {
			Map<String, Object> parameter = sleOutletMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += outletMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += outletMgmt.updateData(parameter);
			}
		}
 
		return  procCnt;
	}

}
