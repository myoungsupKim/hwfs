package com.hwfs.sc.scm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scm.dao.SysMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * SystemMgmtServiceImpl에 대한 설명 작성
 * @ClassName SystemMgmtServiceImpl.java
 * @Description SystemMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 26.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 1. 26.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scm/sysMgmtService")
public class SysMgmtServiceImpl extends DefaultServiceImpl implements SysMgmtService {
	
	@Resource(name="/sc/scm/sysMgmtDAO")
	private SysMgmtDAO sysMgmt;
	
	/**
	 * 시스템 구분에 해당하는 시스템 정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.scm.service.SystemMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) {
		return sysMgmt.selectList(parameter);
	}

	/**
	 * 신규/변경/삭제된 시스템정보를 저장한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.scm.service.SystemMgmtService#saveList(hone.online.xplatform.map.DataSetMap)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public int saveList(DataSetMap parameter) {
		int procCnt = 0;
		
		for (int i = 0 ; i < parameter.size() ; i++) {
			Map<String, Object> rowData = parameter.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += sysMgmt.insertList(rowData);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += sysMgmt.updateList(rowData);
			}
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				procCnt += sysMgmt.deleteList(rowData);
			}
		}
		
		return procCnt;
	}

}
