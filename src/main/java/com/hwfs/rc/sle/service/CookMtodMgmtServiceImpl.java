package com.hwfs.rc.sle.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.CookMtodMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * CookMtodMgmtServiceImpl에 대한 설명 작성
 * @ClassName CookMtodMgmtServiceImpl.java
 * @Description CookMtodMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 8.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 4. 8.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/cookMtodMgmtService")
public class CookMtodMgmtServiceImpl extends DefaultServiceImpl implements CookMtodMgmtService {
	@Resource(name="/rc/sle/cookMtodMgmtDAO")
	private CookMtodMgmtDAO cookMtodMgmt;
	/**
	 * selectGrpList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.CookMtodMgmtService#selectGrpList(java.util.Map)
	 */
	@Override
	public RecordSet selectGrpList(Map<String, Object> parameter) throws Exception {
		return cookMtodMgmt.selectGrpList(parameter);
	}

	@Override
	public RecordSet selectListGrpCheck(Map<String, Object> parameter) throws Exception {
		return cookMtodMgmt.selectListGrpCheck(parameter);
	}
	@Override
	public RecordSet selectListCheck(Map<String, Object> parameter) throws Exception {
		return cookMtodMgmt.selectListCheck(parameter);
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
	 * @see com.hwfs.rc.sle.service.CookMtodMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return cookMtodMgmt.selectList(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param sleCookMtodGrpMgmt
	 * @param sleCookMtodMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.CookMtodMgmtService#saveData(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap sleCookMtodGrpMgmt, DataSetMap sleCookMtodMgmt) throws Exception {
		int groupProcCnt = 0;
		int codeProcCnt = 0;
		String maxCode = "";
		
		for (int i = 0 ; i < sleCookMtodGrpMgmt.size() ; i++) {
			Map<String, Object> parameter = sleCookMtodGrpMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				
				if(!parameter.containsKey("cookMtodGrp") || "".equals(parameter.get("cookMtodGrp")))
				{					
					Record chkRs = cookMtodMgmt.maxCodeCreateGrp(parameter);
					if(chkRs != null && chkRs.size() > 0) {
							maxCode = chkRs.getString("maxCode");
							if(!"".equals(maxCode)){
								parameter.put("cookMtodGrp", maxCode);
							}
						
					}
				}
				
				groupProcCnt += cookMtodMgmt.insertGrpData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				groupProcCnt += cookMtodMgmt.updateGrpData(parameter);
				
				//특정 그룹코드의 사용여부의 값이 [사용안함] 상태인 경우에는 하위에 해당하는 코드의 사용상태도 [사용안함] 상태로 변경한다.
				if ("0".equals(parameter.get("useYn"))) {
					Map<String, Object> useAllCode = new HashMap<String, Object>();
					useAllCode.put("outletCd", parameter.get("outletCd"));
					useAllCode.put("cookMtodGrp", parameter.get("cookMtodGrp"));
					useAllCode.put("useYn", "N");
					cookMtodMgmt.updateUseAllData(useAllCode);
				}
			}
		}
		
		for (int i = 0 ; i < sleCookMtodMgmt.size() ; i++) {
			Map<String, Object> parameter = sleCookMtodMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {

				//Code 값이 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("cookMtodCd") || "".equals(parameter.get("cookMtodCd")))
				{					
					Record chkRs = cookMtodMgmt.maxCodeCreate(parameter);
					if(chkRs != null && chkRs.size() > 0) {
							maxCode = chkRs.getString("maxCode");
							if(!"".equals(maxCode)){
								parameter.put("cookMtodCd", maxCode);
							}
						
					}
				}
				
				codeProcCnt += cookMtodMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				codeProcCnt += cookMtodMgmt.updateData(parameter);
			}
		}
		
		return groupProcCnt+codeProcCnt;
	}

}
