package com.hwfs.sc.scm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scm.dao.PrgMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * PrgMgmtServiceImpl에 대한 설명 작성
 * @ClassName PrgMgmtServiceImpl.java
 * @Description PrgMgmtServiceImpl Class 
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
@Service("/sc/scm/prgMgmtService")
public class PrgMgmtServiceImpl extends DefaultServiceImpl implements PrgMgmtService {
	
	@Resource(name="/sc/scm/prgMgmtDAO")
	private PrgMgmtDAO prgMgmt;
	
	/**
	 * 조회 조건에 해당하는 프로그램 정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.scm.service.PrgMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) {
		return prgMgmt.selectList(parameter);
	}
	
	/**
	 * 시스템구분에 따른 Service Id를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.scm.service.PrgMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectServiceIdList(Map<String, Object> parameter) throws Exception {
		return prgMgmt.selectServiceIdList(parameter);
	}
	
	/**
	 * 이미 등록되어 있는지를 중복체크한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.scm.service.PrgMgmtService#selectExists(java.util.Map)
	*/
	@Override
	public int selectExists(Map<String, Object> parameter) {
		return prgMgmt.selectExists(parameter);
	}

	/**
	 * 추가/변경/삭제되는 프로그램 정보를 저장한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.scm.service.PrgMgmtService#saveList(hone.online.xplatform.map.DataSetMap)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public int saveList(DataSetMap parameter) {
		int procCnt = 0;
		
		for (int i = 0 ; i < parameter.size() ; i++) {
			Map<String, Object> rowData = parameter.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += prgMgmt.insertList(rowData);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += prgMgmt.updateList(rowData);
			}
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				procCnt += prgMgmt.deleteList(rowData);
			}
		}
		
		return procCnt;
	}

}
