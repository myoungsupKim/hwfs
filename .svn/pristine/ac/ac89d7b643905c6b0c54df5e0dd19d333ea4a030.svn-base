package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.PosMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * PosMgmtServiceImpl에 대한 설명 작성
 * @ClassName PosMgmtServiceImpl.java
 * @Description PosMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 1.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 4. 1.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/posMgmtService")
public class PosMgmtServiceImpl extends DefaultServiceImpl implements PosMgmtService {
	@Resource(name="/rc/sle/posMgmtDAO")
	private PosMgmtDAO posMgmt;
	
	/**
	 * selectListPosNum 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PosMgmtService#selectListPosNum(java.util.Map)
	*/
	@Override
	public RecordSet selectListPosNum(Map<String, Object> parameter) throws Exception {
		return posMgmt.selectListPosNum(parameter);
	}
	
	/**
	 * selectListPosNumAll 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	@Override
	public RecordSet selectListPosNumAll(Map<String, Object> parameter) throws Exception {
		return posMgmt.selectListPosNumAll(parameter);
	}

	@Override
	public RecordSet selectListPosNumIf(Map<String, Object> parameter) throws Exception {
		return posMgmt.selectListPosNumIf(parameter);
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
	 * @see com.hwfs.rc.sle.service.PosMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return posMgmt.selectList(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param slePosMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PosMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap slePosMgmt) throws Exception {
		int procCnt = 0;
		 
		
		for (int i = 0 ; i < slePosMgmt.size() ; i++) {
			Map<String, Object> parameter = slePosMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += posMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += posMgmt.updateData(parameter);
			}
		}
 
		return  procCnt;
	}

}
