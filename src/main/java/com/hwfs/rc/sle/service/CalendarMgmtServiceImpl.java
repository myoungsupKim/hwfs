package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.CalendarMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * CalendarMgmtServiceImpl에 대한 설명 작성
 * @ClassName CalendarMgmtServiceImpl.java
 * @Description CalendarMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 15.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 4. 15.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/calendarMgmtService")
public class CalendarMgmtServiceImpl extends DefaultServiceImpl implements CalendarMgmtService {
	@Resource(name="/rc/sle/calendarMgmtDAO")
	private CalendarMgmtDAO calendarMgmt;
	/**
	 * selectListYear 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.CalendarMgmtService#selectListYear(java.util.Map)
	 */
	@Override
	public RecordSet selectListYear(Map<String, Object> parameter) throws Exception {
		return calendarMgmt.selectListYear(parameter);
	}

	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.CalendarMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return calendarMgmt.selectList(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param sleCalendarMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.CalendarMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap sleCalendarMgmt) throws Exception {
		int procCnt = 0;
		 
		
		for (int i = 0 ; i < sleCalendarMgmt.size() ; i++) {
			Map<String, Object> parameter = sleCalendarMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += calendarMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += calendarMgmt.updateData(parameter);
			}
		}
 
		return  procCnt;
	}

}
