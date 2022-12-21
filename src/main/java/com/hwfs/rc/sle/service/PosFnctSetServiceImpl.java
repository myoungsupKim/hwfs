package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.PosFnctSetDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * PosFnctSetServiceImpl에 대한 설명 작성
 * @ClassName PosFnctSetServiceImpl.java
 * @Description PosFnctSetServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 14.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 4. 14.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/posFnctSetService")
public class PosFnctSetServiceImpl extends DefaultServiceImpl implements PosFnctSetService {
	@Resource(name="/rc/sle/posFnctSetDAO")
	private PosFnctSetDAO posFnctSet;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PosFnctSetService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return posFnctSet.selectList(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param slePosFnctSet
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PosFnctSetService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap slePosFnctSet) throws Exception {
		int procCnt = 0;

		
		for (int i = 0 ; i < slePosFnctSet.size() ; i++) {
			Map<String, Object> parameter = slePosFnctSet.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += posFnctSet.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += posFnctSet.updateData(parameter);
			}
		}
 
		return  procCnt;
	}

}
