package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.MonTargetMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * MonTargetMgmtServiceImpl에 대한 설명 작성
 * @ClassName MonTargetMgmtServiceImpl.java
 * @Description MonTargetMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 27.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 4. 27.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/monTargetMgmtService")
public class MonTargetMgmtServiceImpl extends DefaultServiceImpl implements MonTargetMgmtService {
	@Resource(name="/rc/sle/monTargetMgmtDAO")
	private MonTargetMgmtDAO monTargetMgmt;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MonTargetMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return monTargetMgmt.selectList(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param sleSalsGoalMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MonTargetMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap sleSalsGoalMgmt) throws Exception {
		int procCnt = 0;
		 
		
		for (int i = 0 ; i < sleSalsGoalMgmt.size() ; i++) {
			Map<String, Object> parameter = sleSalsGoalMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += monTargetMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += monTargetMgmt.updateData(parameter);
			}
		}
 
		return  procCnt;
	}
	
	
	@Override
	public int deleteData(Map<String, Object> parameter) throws Exception {
		int procCnt = 0;
		 
		
	 
			procCnt += monTargetMgmt.deleteData(parameter);
		 
 
		return  procCnt;
	}
}
