package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.PosMenuKeyMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * PosMenuKeyMgmtServiceImpl에 대한 설명 작성
 * @ClassName PosMenuKeyMgmtServiceImpl.java
 * @Description PosMenuKeyMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 7.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 4. 7.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/posMenuKeyMgmtService")
public class PosMenuKeyMgmtServiceImpl extends DefaultServiceImpl implements PosMenuKeyMgmtService {
	@Resource(name="/rc/sle/posMenuKeyMgmtDAO")
	private PosMenuKeyMgmtDAO posMenuKeyMgmt;
	/**
	 * selectGrpList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PosMenuKeyMgmtService#selectGrpList(java.util.Map)
	 */
	@Override
	public RecordSet selectGrpList(Map<String, Object> parameter) throws Exception {
		return posMenuKeyMgmt.selectGrpList(parameter);
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
	 * @see com.hwfs.rc.sle.service.PosMenuKeyMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return posMenuKeyMgmt.selectList(parameter);
	}

	@Override
	public RecordSet selectListNew(Map<String, Object> parameter) throws Exception {
		return posMenuKeyMgmt.selectListNew(parameter);
	}
	
	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param slePosMenuKeyGrpMgmt
	 * @param slePosMenuKeyMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PosMenuKeyMgmtService#saveData(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap slePosMenuKeyGrpMgmt, DataSetMap slePosMenuKeyMgmt) throws Exception {
		int groupProcCnt = 0;
		int codeProcCnt = 0;
		
		
		for (int i = 0 ; i < slePosMenuKeyGrpMgmt.size() ; i++) {
			Map<String, Object> parameter = slePosMenuKeyGrpMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				groupProcCnt += posMenuKeyMgmt.insertGrpData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				groupProcCnt += posMenuKeyMgmt.updateGrpData(parameter);
				
				//특정 그룹코드의 사용여부의 값이 [사용안함] 상태인 경우에는 하위에 해당하는 공통코드의 사용상태도 [사용안함] 상태로 변경한다.
				if ("0".equals(parameter.get("useYn"))) {
					Map<String, Object> useAllCode = new HashMap<String, Object>();
					useAllCode.put("outletCd", parameter.get("outletCd"));
					useAllCode.put("posNum", parameter.get("posNum"));
					useAllCode.put("picPlaceGrp", parameter.get("picPlaceGrp"));
					useAllCode.put("picPlaceSubGrp", parameter.get("picPlaceSubGrp"));
					useAllCode.put("useYn", "1");
					posMenuKeyMgmt.updateUseAllData(useAllCode);
				}
			}
		}
		
		for (int i = 0 ; i < slePosMenuKeyMgmt.size() ; i++) {
			Map<String, Object> parameter = slePosMenuKeyMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				codeProcCnt += posMenuKeyMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				codeProcCnt += posMenuKeyMgmt.updateData(parameter);
			}
		}
		
		return groupProcCnt+codeProcCnt;
	}

	//지정키 그룹 저장
	@Override
	@SuppressWarnings("unchecked")
	public int saveDataGrp(DataSetMap slePosMenuKeyGrpMgmt) throws Exception {
		int groupProcCnt = 0;
		
		for (int i = 0 ; i < slePosMenuKeyGrpMgmt.size() ; i++) {
			Map<String, Object> parameter = slePosMenuKeyGrpMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				groupProcCnt += posMenuKeyMgmt.insertGrpData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				groupProcCnt += posMenuKeyMgmt.updateGrpData(parameter);
				
				//특정 그룹코드의 사용여부의 값이 [사용안함] 상태인 경우에는 하위에 해당하는 공통코드의 사용상태도 [사용안함] 상태로 변경한다.
				if ("0".equals(parameter.get("useYn"))) {
					Map<String, Object> useAllCode = new HashMap<String, Object>();
					useAllCode.put("outletCd", parameter.get("outletCd"));
					useAllCode.put("posNum", parameter.get("posNum"));
					useAllCode.put("picPlaceGrp", parameter.get("picPlaceGrp"));
					useAllCode.put("picPlaceSubGrp", parameter.get("picPlaceSubGrp"));
					useAllCode.put("useYn", "1");
					posMenuKeyMgmt.updateUseAllData(useAllCode);
				}
			}
		}
		 
		return groupProcCnt;
	}

	//지정키 메뉴 저장
	@Override
	@SuppressWarnings("unchecked")
	public int saveDataSub(DataSetMap slePosMenuKeyMgmt) throws Exception {
		int codeProcCnt = 0;
		
		for (int i = 0 ; i < slePosMenuKeyMgmt.size() ; i++) {
			Map<String, Object> parameter = slePosMenuKeyMgmt.get(i);
			
			codeProcCnt += posMenuKeyMgmt.insertData(parameter);
		
		}
		
		return codeProcCnt;
	}
	
	//그룹을 삭제 하면 하위 그룹도 모두 삭제 한다.
	@Override
	@SuppressWarnings("unchecked")
	public int deleteGrpData(DataSetMap slePosMenuKeyGrpMgmt) throws Exception {
		int groupProcCnt = 0;
		
		for (int i = 0 ; i < slePosMenuKeyGrpMgmt.size() ; i++) {
			Map<String, Object> parameter = slePosMenuKeyGrpMgmt.get(i);
			 
				groupProcCnt += posMenuKeyMgmt.deleteGrpData(parameter);
				posMenuKeyMgmt.deleteAllData(parameter);
		 
		}
		 
		return groupProcCnt;
	}

	//실제는 코드는 삭제 한지 않고 공백처리 한다. 
	@Override
	@SuppressWarnings("unchecked")
	public int deleteSubData(DataSetMap slePosMenuKeyMgmt) throws Exception {
		int codeProcCnt = 0;
		
		for (int i = 0 ; i < slePosMenuKeyMgmt.size() ; i++) {
			Map<String, Object> parameter = slePosMenuKeyMgmt.get(i);
 
				codeProcCnt += posMenuKeyMgmt.deleteSubData(parameter);
			 
		}
		
		return codeProcCnt;
	}
	
	
	@Override
	public RecordSet selectListMenu(Map<String, Object> parameter) throws Exception {
		return posMenuKeyMgmt.selectListMenu(parameter);
	}
	
	
	//지정키 그룹 이동처리
	@Override
	@SuppressWarnings("unchecked")
	public int saveDataMove(DataSetMap slePosMenuKeyGrpMgmt) throws Exception {
		int groupProcCnt = 0;
		
		for (int i = 0 ; i < slePosMenuKeyGrpMgmt.size() ; i++) {
			Map<String, Object> parameter = slePosMenuKeyGrpMgmt.get(i);
			
				//1.해당 자료를 신규 위치로 이동한다.
				//groupProcCnt += posMenuKeyMgmt.insertGrpData(parameter);
				//2.서브내역이 있는 경우 모두 신규 그룹 코드로 업데이트 한다.
				groupProcCnt += posMenuKeyMgmt.updateListDataGrp(parameter);
				//3.메뉴내역도 업데이트 한다.
				groupProcCnt += posMenuKeyMgmt.updateListData(parameter);
				//4. 이전 삭제처리
				groupProcCnt += posMenuKeyMgmt.deleteGrpDataMove(parameter);
				groupProcCnt += posMenuKeyMgmt.deleteSubDataMove(parameter);

		}
		 
		return groupProcCnt;
	}

	
	//지정키 메뉴및 소그룹 이동처리
	@Override
	@SuppressWarnings("unchecked")
	public int saveDataMoveList(DataSetMap slePosMenuKeyMgmt) throws Exception {
		int groupProcCnt = 0;
		
		for (int i = 0 ; i < slePosMenuKeyMgmt.size() ; i++) {
			Map<String, Object> parameter = slePosMenuKeyMgmt.get(i);
			
				
				
				//1.소분류 처리
				//  메뉴코드가 없거나 공백이고 소그룹 코드가 00이 아니면 저장 및 삭제 한다.
				if ((!parameter.containsKey("cdNum") || "".equals(parameter.get("cdNum"))) && !parameter.get("picPlaceSubGrp").equals("00"))   
				{
				    //1-1. 소소그룹 내역을 저장 한다.
					Map<String, Object> useClassKey = new HashMap<String, Object>();
					useClassKey.put("outletCd",       parameter.get("outletCd"));
					useClassKey.put("posNum",         parameter.get("posNum"));
					useClassKey.put("picPlaceGrp",    parameter.get("picPlaceGrp"));
					useClassKey.put("picPlaceGrpNm",  parameter.get("picPlaceGrpNm"));
					useClassKey.put("picPlaceSubGrp", parameter.get("picPlace"));		//해당 내역을 변경 한다.
					useClassKey.put("picPlace",       parameter.get("picPlace"));
					useClassKey.put("useYn",          parameter.get("useYn"));
					groupProcCnt += posMenuKeyMgmt.insertGrpData(useClassKey);
				    //1-2. 소그룹 메뉴의 내역을 모두 변경한다.
					groupProcCnt += posMenuKeyMgmt.updateDataSubList(parameter);
					//1-4. 이전 소그룹 내역을 삭제 한다.
					Map<String, Object> useOldKeyGrp = new HashMap<String, Object>();
					useOldKeyGrp.put("outletCd",       parameter.get("outletCd"));
					useOldKeyGrp.put("posNum",         parameter.get("posNum"));
					useOldKeyGrp.put("picPlaceGrp",    parameter.get("picPlaceGrp"));
					useOldKeyGrp.put("picPlaceSubGrp", parameter.get("picPlaceSubGrpOld"));
					useOldKeyGrp.put("picPlace",       parameter.get("picPlaceOld"));
					groupProcCnt +=  posMenuKeyMgmt.deleteGrpData(useOldKeyGrp);
				}
				else
				{
					//2.신규 위치 이동한 메뉴 저장
					groupProcCnt += posMenuKeyMgmt.insertData(parameter);
					
					//3.해당 메뉴 삭제 (이전메뉴는 삭제 한다)
					Map<String, Object> useOldKey = new HashMap<String, Object>();
					useOldKey.put("outletCd",       parameter.get("outletCd"));
					useOldKey.put("posNum",         parameter.get("posNum"));
					useOldKey.put("picPlaceGrp",    parameter.get("picPlaceGrp"));
					useOldKey.put("picPlaceSubGrp", parameter.get("picPlaceSubGrpOld"));
					useOldKey.put("picPlace",       parameter.get("picPlaceOld"));
					groupProcCnt += posMenuKeyMgmt.deleteSubData(useOldKey);	
				}

		}
		 
		return groupProcCnt;
	}
	
	
	
	//복사하기전 있는 자료 삭제 한다.
	
	@Override
	@SuppressWarnings("unchecked")
	public int deleteDataCopy(DataSetMap slePosMenuKeyCopy) throws Exception {
		int groupProcCnt = 0;
		
		for (int i = 0 ; i < slePosMenuKeyCopy.size() ; i++) {
			Map<String, Object> parameter = slePosMenuKeyCopy.get(i);
			
				//1.자료 모두 삭제
				groupProcCnt += posMenuKeyMgmt.deleteGrpDataMove(parameter);
				groupProcCnt += posMenuKeyMgmt.deleteSubDataMove(parameter);

		}
		 
		return groupProcCnt;
	}

}
