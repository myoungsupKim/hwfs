package com.hwfs.rc.sle.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.ReservMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * ReservMgmtServiceImpl에 대한 설명 작성
 * @ClassName ReservMgmtServiceImpl.java
 * @Description ReservMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 29.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 4. 29.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/reservMgmtService")
public class ReservMgmtServiceImpl extends DefaultServiceImpl implements ReservMgmtService {
	@Resource(name="/rc/sle/reservMgmtDAO")
	private ReservMgmtDAO reservMgmt;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.ReservMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return reservMgmt.selectList(parameter);
	}
	
	@Override
	public RecordSet selectListGoods(Map<String, Object> parameter) throws Exception {
		return reservMgmt.selectListGoods(parameter);
	}
	/**
	 * selectListTable 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.ReservMgmtService#selectListTable(java.util.Map)
	 */
	@Override
	public RecordSet selectListTable(Map<String, Object> parameter) throws Exception {
		return reservMgmt.selectListTable(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param sleReservMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.ReservMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap sleReservMgmt,DataSetMap sleReservMgmtGoods) throws Exception {
		int procCnt = 0;
		int maxSeq = 0;
		String maxCode = "";  
		
		for (int i = 0 ; i < sleReservMgmt.size() ; i++) {
			Map<String, Object> parameter = sleReservMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				//Code 값이 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("reservNum") || "".equals(parameter.get("reservNum")))
				{					
					Record chkRs = reservMgmt.maxCodeCreate(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						maxCode = chkRs.getString("maxCode");
						if(!"".equals(maxCode)){
							parameter.put("reservNum", maxCode);
						}
					}
				}
				
				procCnt += reservMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += reservMgmt.updateData(parameter);
			}
		}
		
		//
		for (int i = 0 ; i < sleReservMgmtGoods.size() ; i++) {
			Map<String, Object> parameter = sleReservMgmtGoods.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				//Code 값이 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("reservNum") || "".equals(parameter.get("reservNum")))
				{					
					parameter.put("reservNum", maxCode);
				}
				
				//seq 값이 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("seq") || "".equals(parameter.get("seq")))
				{					
					Record chkRs = reservMgmt.maxCodeCreateGoods(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						maxSeq = chkRs.getInt("maxSeq");
						if(!"".equals(maxSeq)){
							parameter.put("seq", maxSeq);
						}
					}
				}
				
				procCnt += reservMgmt.insertDataGoods(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += reservMgmt.updateDataGoods(parameter);
			}
		}
		
		return  procCnt;
	}

}
