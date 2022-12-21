package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.PayCodeMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * PayCodeMgmtServiceImpl에 대한 설명 작성
 * @ClassName PayCodeMgmtServiceImpl.java
 * @Description PayCodeMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 9.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 4. 9.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/payCodeMgmtService")
public class PayCodeMgmtServiceImpl extends DefaultServiceImpl implements PayCodeMgmtService {
	@Resource(name="/rc/sle/payCodeMgmtDAO")
	private PayCodeMgmtDAO payCodeMgmt;
	/**
	 * selectGrpList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PayCodeMgmtService#selectGrpList(java.util.Map)
	 */
	@Override
	public RecordSet selectGrpList(Map<String, Object> parameter) throws Exception {
		return payCodeMgmt.selectGrpList(parameter);
	}

	/**
	 * selectGrpSubList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PayCodeMgmtService#selectGrpSubList(java.util.Map)
	 */
	@Override
	public RecordSet selectGrpSubList(Map<String, Object> parameter) throws Exception {
		return payCodeMgmt.selectGrpSubList(parameter);
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
	 * @see com.hwfs.rc.sle.service.PayCodeMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return payCodeMgmt.selectList(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param slePayCodeMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PayCodeMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap slePayCodeMgmt) throws Exception {
		int codeProcCnt = 0;
		
		for (int i = 0 ; i < slePayCodeMgmt.size() ; i++) {
			Map<String, Object> parameter = slePayCodeMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				codeProcCnt += payCodeMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				codeProcCnt += payCodeMgmt.updateData(parameter);
				 
			}
		}

		return codeProcCnt;
	}

}
