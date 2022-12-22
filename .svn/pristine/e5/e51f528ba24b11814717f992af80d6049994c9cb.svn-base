package com.hwfs.rc.bms.service;

import java.util.Map;

import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.OutOrderMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * OutOrderMgmtServiceImpl에 대한 설명 작성
 * @ClassName OutOrderMgmtServiceImpl.java
 * @Description OutOrderMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 14.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 7. 14.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/outOrderMgmtService")
public class OutOrderMgmtServiceImpl extends DefaultServiceImpl implements OutOrderMgmtService {
	@Resource(name="/rc/bms/outOrderMgmtDAO")
	private OutOrderMgmtDAO outOrderMgmt;
	
	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param reservGoods
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.OutOrderMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap reservGoods) throws Exception {
		int mstProcCnt   = 0;
		// Save or Update
		for (int i = 0 ; i < reservGoods.size() ; i++) {
			Map<String, Object> parameter = reservGoods.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 

			if (rowType == DataSet.ROW_TYPE_UPDATED){
				mstProcCnt += outOrderMgmt.updateData(parameter);	 
			}
		}
		
		
		return mstProcCnt;
	}

}
