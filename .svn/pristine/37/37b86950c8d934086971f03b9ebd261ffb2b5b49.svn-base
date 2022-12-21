package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.MenuMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * MenuMgmtServiceImpl에 대한 설명 작성
 * @ClassName MenuMgmtServiceImpl.java
 * @Description MenuMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 27.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 3. 27.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/menuMgmtService")
public class MenuMgmtServiceImpl extends DefaultServiceImpl implements MenuMgmtService {
	@Resource(name="/rc/sle/menuMgmtDAO")
	private MenuMgmtDAO menuMgmt;
	/**
	 * selectListItemPool 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MenuMgmtService#selectListItemPool(java.util.Map)
	 */
	
	public RecordSet selectListItemPool(Map<String, Object> parameter) throws Exception {
		return menuMgmt.selectListItemPool(parameter);
	}

	/**
	 * selectFsItemPool 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MenuMgmtService#selectFsItemPool(java.util.Map)
	 */
	
	public RecordSet selectFsItemPool(Map<String, Object> parameter) throws Exception {
		return menuMgmt.selectFsItemPool(parameter);
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
	 * @see com.hwfs.rc.sle.service.MenuMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return menuMgmt.selectList(parameter);
	}

	//barcode data set
	@Override
	public RecordSet selectListBarCd(Map<String, Object> parameter) throws Exception {
		return menuMgmt.selectListBarCd(parameter);
	}
	
	@Override
	public RecordSet searchBarCd(Map<String, Object> parameter) throws Exception {
		return menuMgmt.searchBarCd(parameter);
	}
		 
	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param sleMenuMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MenuMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	public int saveData(DataSetMap sleMenuMgmt,DataSetMap sleMenuMgmtBarCd) throws Exception {
		int procCnt = 0;
		int barSaveYn = 0;	//2015.12.07 추가
	
		for (int i = 0 ; i < sleMenuMgmt.size() ; i++) {
			Map<String, Object> parameter = sleMenuMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += menuMgmt.insertData(parameter);
				//신규 추가 시 바코드 마스터 테이블에 insert 처리 추가 20180523 김호석(염병문차장 요청)
				procCnt += menuMgmt.insertDataBarCd(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += menuMgmt.updateData(parameter);		// 메뉴정보
				//서로다른 업장에서 아이템을 미사용/사용으로 변경하면 문제 발생해서 아이템풀업데이트는 삭제함 2017.04.18 김호석 CH201704_00523
				//procCnt += menuMgmt.updateItemData(parameter);	// 아이템풀
			}
			else if (rowType == DataSet.ROW_TYPE_DELETED){
				procCnt += menuMgmt.deleteDataBarCd(parameter);	// 바코드
				procCnt += menuMgmt.deleteData(parameter);		// 메뉴정보
				//procCnt += menuMgmt.deleteItemData(parameter);	// 아이템풀
			}
		}

		int barCnt = 0;
		Map<String, Object> parameter = null;
		for (int i = 0 ; i < sleMenuMgmtBarCd.size() ; i++) {
			parameter = sleMenuMgmtBarCd.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += menuMgmt.insertDataBarCd(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				//2016.01.21 추가 바코드가 다른 메뉴에서 사용 안함을 하는 경우 신규 메뉴에 매칭을 못하느문제로 삭제 처리 한다.
				//수정시 바로 삭제 한다.
				if ("1".equals(parameter.get("useYn"))) {
				procCnt += menuMgmt.updateDataBarCd(parameter);
				}else {
				procCnt += menuMgmt.deleteDataBarCd(parameter);
				}
				//procCnt += menuMgmt.updateDataBarCd(parameter);
			}
			
			/*
		 * 2015.12.07 추가
		 */
			 
		   if  ("1".equals(parameter.get("useYn")) && barSaveYn == 0 ) {
			   barSaveYn = menuMgmt.updateDataMenuBar(parameter);
			}
		   
		   if ("1".equals(parameter.get("useYn"))) {
			   barCnt += 1;
		   }
		   		
		}
		
		/*
	    * 2016.3.7 추가 바코드 팝업에서 체크된게 없는 경우 sle_outlet_menu bar_cd도 null로 업데이트
	    */		
		/*
 	    if (procCnt > 0 && barCnt == 0) {
 		    //Map parameter = null;
 	 	    parameter.put("barCd","");
	  	    barSaveYn = menuMgmt.updateDataMenuBar(parameter);
	    }
	    */
		
		
		

		return  procCnt;
	}
	
	/**
	 * selectSaleBarList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MenuMgmtService#selectSaleBarList(java.util.Map)
	 */
	@Override
	public RecordSet selectSaleBarList(Map<String, Object> parameter) throws Exception {
		return menuMgmt.selectSaleBarList(parameter);
	}
	
	/**
	 * deleteSaleBarList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param sleMenuMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MenuMgmtService#deleteSaleBarList(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	public int deleteSaleBarList(Map<String, Object> parameter) throws Exception {
		int delCnt = 0;
		return delCnt += menuMgmt.deleteSaleBarList(parameter);
	}
	
	/**
	 * saveSaleBarList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param sleMenuMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MenuMgmtService#saveSaleBarList(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	public int saveSaleBarList(DataSetMap sleMenuList) throws Exception {
		int insCnt = 0;
		for (int i = 0 ; i < sleMenuList.size() ; i++) {
			Map<String, Object> parameter = sleMenuList.get(i);
			insCnt += menuMgmt.saveSaleBarList(parameter);
		}
		return insCnt;
	}
	
}
