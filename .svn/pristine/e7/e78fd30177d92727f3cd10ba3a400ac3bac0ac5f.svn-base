package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.TableMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * TableMgmtServiceImpl에 대한 설명 작성
 * @ClassName TableMgmtServiceImpl.java
 * @Description TableMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 3.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 4. 3.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/tableMgmtService")
public class TableMgmtServiceImpl extends DefaultServiceImpl implements TableMgmtService {
	@Resource(name="/rc/sle/tableMgmtDAO")
	private TableMgmtDAO tableMgmt;
	/**
	 * selectGrpList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.TableMgmtService#selectGrpList(java.util.Map)
	 */
	@Override
	public RecordSet selectGrpList(Map<String, Object> parameter) throws Exception {
		return tableMgmt.selectGrpList(parameter);
	}
	
	@Override
	public RecordSet selectViewGrpList(Map<String, Object> parameter) throws Exception {
		return tableMgmt.selectViewGrpList(parameter);
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
	 * @see com.hwfs.rc.sle.service.TableMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return tableMgmt.selectList(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param sleTableGrpMgmt
	 * @param sleTableMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.TableMgmtService#saveData(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap sleTableGrpMgmt, DataSetMap sleTableMgmt) throws Exception {
		int groupProcCnt = 0;
		int codeProcCnt = 0;
		
		for (int i = 0 ; i < sleTableGrpMgmt.size() ; i++) {
			Map<String, Object> parameter = sleTableGrpMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				groupProcCnt += tableMgmt.insertGrpData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				groupProcCnt += tableMgmt.updateGrpData(parameter);
				
				//특정 그룹코드의 사용여부의 값이 [사용안함] 상태인 경우에는 하위에 해당하는 공통코드의 사용상태도 [사용안함] 상태로 변경한다.
				if ("0".equals(parameter.get("useYn"))) {
					Map<String, Object> useAllCode = new HashMap<String, Object>();
					useAllCode.put("outletCd", parameter.get("outletCd"));
					useAllCode.put("tableGrp", parameter.get("tableGrp"));
					useAllCode.put("useYn", "N");
					tableMgmt.updateUseAllData(useAllCode);
				}
			}
		}
		
		for (int i = 0 ; i < sleTableMgmt.size() ; i++) {
			Map<String, Object> parameter = sleTableMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				codeProcCnt += tableMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				codeProcCnt += tableMgmt.updateData(parameter);
			}
		}
		
		return groupProcCnt+codeProcCnt;
	}

}
