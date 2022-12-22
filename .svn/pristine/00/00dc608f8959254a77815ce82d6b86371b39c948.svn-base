package com.hwfs.rc.bms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.EventEndMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * EventEndMgmtServiceImpl에 대한 설명 작성
 * @ClassName EventEndMgmtServiceImpl.java
 * @Description EventEndMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 21.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 7. 21.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/eventEndMgmtService")
public class EventEndMgmtServiceImpl extends DefaultServiceImpl implements EventEndMgmtService {
	@Resource(name="/rc/bms/eventEndMgmtDAO")
	private EventEndMgmtDAO eventEndMgmt;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.EventEndMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return eventEndMgmt.selectList(parameter);
	}
	
	@Override
	public RecordSet selectListMst(Map<String, Object> parameter) throws Exception {
		return eventEndMgmt.selectListMst(parameter);
	}
	
	@Override
	public RecordSet selectListEndEvent(Map<String, Object> parameter) throws Exception {
		return eventEndMgmt.selectListEndEvent(parameter);
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap  reservMst) {
		int procCnt = 0;
		 
		
		for (int i = 0 ; i < reservMst.size() ; i++) {
			Map<String, Object> parameter = reservMst.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			 
			if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += eventEndMgmt.updateDataMst(parameter);
				
				procCnt += eventEndMgmt.updateDataResStatus(parameter);
				
			}
		}
 
		return  procCnt;
	}
}
