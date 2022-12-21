package com.hwfs.rc.bms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.WeddingReportDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * WeddingReportServiceImpl에 대한 설명 작성
 * @ClassName WeddingReportServiceImpl.java
 * @Description WeddingReportServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 25.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 8. 25.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/weddingReportService")
public class WeddingReportServiceImpl extends DefaultServiceImpl implements WeddingReportService {
	@Resource(name="/rc/bms/weddingReportDAO")
	private WeddingReportDAO weddingReport;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.WeddingReportService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return weddingReport.selectList(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param weddingReportData
	 * @param sabun
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.WeddingReportService#saveData(hone.online.xplatform.map.DataSetMap, java.lang.String)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap weddingReportData, String sabun) throws Exception {

		int procCnt = 0;
		
		for (int i = 0 ; i < weddingReportData.size() ; i++) {
			Map<String, Object> parameter = weddingReportData.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += weddingReport.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += weddingReport.updateData(parameter);
			}
		}
 
		return  procCnt;
	}

}
