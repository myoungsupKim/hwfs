package com.hwfs.rc.bms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.BasCodeMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * BasCodeMgmtServiceImpl에 대한 설명 작성
 * @ClassName BasCodeMgmtServiceImpl.java
 * @Description BasCodeMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 6.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 2. 6.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/basCodeMgmtService")
public class BasCodeMgmtServiceImpl extends DefaultServiceImpl implements BasCodeMgmtService {
	@Resource(name="/rc/bms/basCodeMgmtDAO")
	private BasCodeMgmtDAO basCodeMgmt;
	
	/**
	 * selectGroupList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.rc.bms.service.BasCodeMgmtService#selectGroupList()
	 */
	@Override
	public RecordSet selectGroupList() {
		// TODO Auto-generated method stub
		return basCodeMgmt.selectGroupList();
	}
	
	/**
	 * selectCodeList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.rc.bms.service.BasCodeMgmtService#selectCodeList()
	 */
	@Override
	public RecordSet selectCodeList(Map<String, Object> parameter) {
		// TODO Auto-generated method stub
		return basCodeMgmt.selectCodeList(parameter);
	}
	
	@Override
	public RecordSet selectListSCC(Map<String, Object> parameter) {
		// TODO Auto-generated method stub
		return basCodeMgmt.selectListSCC(parameter);
	}
	
	
	
	@Override
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap groupList, DataSetMap codeList) {
		int groupProcCnt = 0;
		int codeProcCnt = 0;
		
		for (int i = 0 ; i < groupList.size() ; i++) {
			Map<String, Object> parameter = groupList.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				groupProcCnt += basCodeMgmt.insertGroupList(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				groupProcCnt += basCodeMgmt.updateGroupList(parameter);
				
				//특정 그룹코드의 사용여부의 값이 [사용안함] 상태인 경우에는 하위에 해당하는 공통코드의 사용상태도 [사용안함] 상태로 변경한다.
				 
				if ("0".equals(parameter.get("useYn"))) {
					Map<String, Object> useAllCode = new HashMap<String, Object>();
					useAllCode.put("clsfiCd", parameter.get("clsfiCd"));
					useAllCode.put("useYn", "N");
					basCodeMgmt.updateUseAllCode(useAllCode);
				}
				 
			}
		}
		
		for (int i = 0 ; i < codeList.size() ; i++) {
			Map<String, Object> parameter = codeList.get(i);
			 
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				codeProcCnt += basCodeMgmt.insertCodeList(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				codeProcCnt += basCodeMgmt.updateCodeList(parameter);
			}
		}
		
		return groupProcCnt+codeProcCnt;
	}

}
