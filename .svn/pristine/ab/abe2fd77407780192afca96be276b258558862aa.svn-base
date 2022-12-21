package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.PosDcEventScrnDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * PosDcEventScrnServiceImpl에 대한 설명 작성
 * @ClassName PosDcEventScrnServiceImpl.java
 * @Description PosDcEventScrnServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 11.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 5. 11.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/posDcEventScrnService")
public class PosDcEventScrnServiceImpl extends DefaultServiceImpl implements PosDcEventScrnService {
	@Resource(name="/rc/sle/posDcEventScrnDAO")
	private PosDcEventScrnDAO posDcEventScrn;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PosDcEventScrnService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return posDcEventScrn.selectList(parameter);
	}

	/**
	 * searchList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PosDcEventScrnService#searchList(java.util.Map)
	 */
	@Override
	public RecordSet searchList(Map<String, Object> parameter) throws Exception {
		return posDcEventScrn.searchList(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param slePosDcEventScrn
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PosDcEventScrnService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap slePosDcEventScrn) throws Exception {
		int procCnt = 0;
	 
		for (int i = 0 ; i < slePosDcEventScrn.size() ; i++) {
			Map<String, Object> parameter = slePosDcEventScrn.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				 
				procCnt += posDcEventScrn.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				//사용 유무를 미사용으로 변경 한경우  하위코드 처리를 먼저 해야 한다 없는 경우는 상관 없다.
				
				procCnt += posDcEventScrn.updateData(parameter);
			}
		}
 
		return  procCnt;
	}

	/**
	 * deleteData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param slePosDcEventScrn
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PosDcEventScrnService#deleteData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int deleteData(DataSetMap slePosDcEventScrn) throws Exception {
		int procCnt = 0;

		for (int i = 0 ; i < slePosDcEventScrn.size() ; i++) {
			Map<String, Object> parameter = slePosDcEventScrn.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			 
			
			if (rowType == DataSet.ROW_TYPE_UPDATED){
				//사용 유무를 미사용으로 변경 한경우  하위코드 처리를 먼저 해야 한다 없는 경우는 상관 없다.
				
				procCnt += posDcEventScrn.deleteData(parameter);
			}
		}
 
		return  procCnt;
	}

}
