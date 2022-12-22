package com.hwfs.rc.sle.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.OutletSalesDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * OutletSalesServiceImpl에 대한 설명 작성
 * @ClassName OutletSalesServiceImpl.java
 * @Description OutletSalesServiceImpl Class 
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
@Service("/rc/sle/outletSalesService")
public class OutletSalesServiceImpl extends DefaultServiceImpl implements OutletSalesService {
	@Resource(name="/rc/sle/outletSalesDAO")
	private OutletSalesDAO outletSales;
	
	/**
	 * selectSalesInqList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.OutletSalesService#selectSalesInqList(java.util.Map)
	 */
	@Override
	public RecordSet selectSalesInqList(Map<String, Object> parameter) throws Exception {
		return outletSales.selectSalesInqList(parameter);
	}
	
	@Override
	public RecordSet selectSalesApprList(Map<String, Object> parameter) throws Exception {
		return outletSales.selectSalesApprList(parameter);
	}
	
	/**
	 * saveData1 설명
	 * <pre>
	 * 첨부파일, 파트장 승인 저장
	 * </pre>
	 *
	 * @param sleMenuMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MenuMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	public int saveData1(DataSetMap sleOutletSales) throws Exception {
		int procCnt = 0;
		RecordSet ins_yn;	
		
		for (int i = 0 ; i < sleOutletSales.size() ; i++) {
			Map<String, Object> parameter = sleOutletSales.get(i);			
			ins_yn = outletSales.selectYn(parameter);
			//System.out.println("ins_yn : " + ins_yn.getRowCount());
			if (ins_yn.getRowCount() == 0) {
				procCnt += outletSales.insertData(parameter);		//				
			} else {
				procCnt += outletSales.updateData1(parameter);	
			}	
		}
		
		return  procCnt;
	}
	
	/**
	 * saveData2 설명
	 * <pre>
	 * 팀장 승인 저장
	 * </pre>
	 *
	 * @param sleMenuMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MenuMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	public int saveData2(DataSetMap sleOutletSales) throws Exception {
		int procCnt = 0;
		RecordSet ins_yn;
	
		for (int i = 0 ; i < sleOutletSales.size() ; i++) {
			Map<String, Object> parameter = sleOutletSales.get(i);
			
			ins_yn = outletSales.selectYn(parameter);
			if (ins_yn.getRowCount() == 0) {
				procCnt += outletSales.insertData(parameter);		//				
			} else {
				procCnt += outletSales.updateData2(parameter);	
			}		
		}
		
		return  procCnt;
	}
	
	/**
	 * saveData3 설명
	 * <pre>
	 * 첨부파일 저장
	 * </pre>
	 *
	 * @param sleMenuMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MenuMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	public int saveData3(DataSetMap sleOutletSales) throws Exception {
		int procCnt = 0;
		RecordSet ins_yn;
	
		for (int i = 0 ; i < sleOutletSales.size() ; i++) {
			Map<String, Object> parameter = sleOutletSales.get(i);
			
			ins_yn = outletSales.selectYn(parameter);
			if (ins_yn.getRowCount() == 0) {
				procCnt += outletSales.insertData(parameter);		//				
			} else {
				procCnt += outletSales.updateData3(parameter);	
			}		
		}
		
		return  procCnt;
	}
}
