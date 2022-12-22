package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scc.dao.CodeMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * CodeMgmtServiceImpl에 대한 설명 작성
 * @ClassName CodeMgmtServiceImpl.java
 * @Description CodeMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 19.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 1. 19.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scc/codeMgmtService")
public class CodeMgmtServiceImpl extends DefaultServiceImpl implements CodeMgmtService {
	
	@Resource(name="/sc/scc/codeMgmtDAO")
	private CodeMgmtDAO codeMgmt;
	
	/**
	 * 공통코드 그룹코드를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.scc.service.CodeMgmtService#selectGroupList(java.util.Map)
	*/
	@Override
	public RecordSet selectGroupList(Map<String, Object> parameter) {
		return codeMgmt.selectGroupList(parameter);
	}

	/**
	 * 특정 그룹코드에 맞는 공통코드를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.scc.service.CodeMgmtService#selectCodeList(java.util.Map)
	*/
	@Override
	public RecordSet selectCodeList(Map<String, Object> parameter) {
		return codeMgmt.selectCodeList(parameter);
	}

	/**
	 * saveList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.scc.service.CodeMgmtService#saveList(java.util.Map)
	*/
	@Override
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap groupList, DataSetMap codeList) {
		int groupProcCnt = 0;
		int codeProcCnt = 0;
		
		for (int i = 0 ; i < groupList.size() ; i++) {
			Map<String, Object> parameter = groupList.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				groupProcCnt += codeMgmt.insertGroupList(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				groupProcCnt += codeMgmt.updateGroupList(parameter);
				
				//특정 그룹코드의 사용여부의 값이 [사용안함] 상태인 경우에는 하위에 해당하는 공통코드의 사용상태도 [사용안함] 상태로 변경한다.
				if ("0".equals(parameter.get("useYn"))) {
					Map<String, Object> useAllCode = new HashMap<String, Object>();
					useAllCode.put("groupCode", parameter.get("groupCode"));
					useAllCode.put("useYn", "N");
					codeMgmt.updateUseAllCode(useAllCode);
				}
			}
		}
		
		for (int i = 0 ; i < codeList.size() ; i++) {
			Map<String, Object> parameter = codeList.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				codeProcCnt += codeMgmt.insertCodeList(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				codeProcCnt += codeMgmt.updateCodeList(parameter);
			}
		}
		
		return groupProcCnt+codeProcCnt;
	}

}
