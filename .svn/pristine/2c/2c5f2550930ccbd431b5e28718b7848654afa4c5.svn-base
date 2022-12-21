package com.hwfs.rc.sle.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.ItemPoolMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * ItemPoolMgmtServiceImpl에 대한 설명 작성
 * @ClassName ItemPoolMgmtServiceImpl.java
 * @Description ItemPoolMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 17.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 3. 17.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/itemPoolMgmtService")
public class ItemPoolMgmtServiceImpl extends DefaultServiceImpl implements ItemPoolMgmtService {
	@Resource(name="/rc/sle/itemPoolMgmtDAO")
	private ItemPoolMgmtDAO itemPoolMgmt;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.ItemPoolMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return itemPoolMgmt.selectList(parameter);
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
	 * @see com.hwfs.rc.sle.service.ItemPoolMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectNewFmItem(Map<String, Object> parameter) throws Exception {
		return itemPoolMgmt.selectNewFmItem(parameter);
	}
	
	/**
	 * saveData 설명
	 * <pre>
	 * 아이템풀 저장하기전에 같은 아이템명 검색
	 * </pre>
	 *
	 * @param sleitemGrpMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.ItemPoolMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public String saveSearch(DataSetMap sleitemPoolMgmt) throws Exception {
		String itemNm = "";
		RecordSet chk;
		
		//아이템명 중복 체크
		for (int i = 0 ; i < sleitemPoolMgmt.size() ; i++) {
			Map<String, Object> parameter = sleitemPoolMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			//삭제가 아닌 경우만 체크			
			if(rowType != DataSet.ROW_TYPE_DELETED){
			//if(rowType == DataSet.ROW_TYPE_INSERTED){
				chk = itemPoolMgmt.selectSameList(parameter);
				if (chk.getRowCount() > 0) {
					itemNm = (String) parameter.get("menuNm");
					break;
				}		
			}
		}
		return itemNm;
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param sleitemGrpMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.ItemPoolMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap sleitemPoolMgmt) throws Exception {
		int procCnt = 0;
		String maxCode = "";
					
		for (int i = 0 ; i < sleitemPoolMgmt.size() ; i++) {
			Map<String, Object> parameter = sleitemPoolMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				//Code 값이 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("menuCd") || "".equals(parameter.get("menuCd")))
				{					
					Record chkRs = itemPoolMgmt.maxCodeCreate(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						maxCode = chkRs.getString("maxCode");
						if(!"".equals(maxCode)){
							parameter.put("menuCd", maxCode);
						}
					}
				}			
				procCnt += itemPoolMgmt.insertData(parameter);
				
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){

					procCnt += itemPoolMgmt.updateData(parameter);
					//서로다른 업장에서 아이템을 미사용/사용으로 변경하면 문제 발생해서 삭제함 2017.04.18 김호석 CH201704_00523
					//procCnt += itemPoolMgmt.updateMenuData(parameter);
				
			}
			else if(rowType == DataSet.ROW_TYPE_DELETED){
				
				    //서로다른 업장에서 아이템을 미사용/사용으로 변경하면 문제 발생해서 삭제함 2017.04.18 김호석 CH201704_00523
					//procCnt += itemPoolMgmt.deleteDataBarCd(parameter);
					//procCnt += itemPoolMgmt.deleteMenuData(parameter);
   				    //사용구분 미사용으로 변경
					procCnt += itemPoolMgmt.deleteData(parameter);	
			}
		}
	
 
		return  procCnt;
	}

}
