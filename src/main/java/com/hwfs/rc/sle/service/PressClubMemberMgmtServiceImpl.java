package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.PressClubMemberMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * PressClubMemberMgmtServiceImpl에 대한 설명 작성
 * @ClassName PressClubMemberMgmtServiceImpl.java
 * @Description PressClubMemberMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 15.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 5. 15.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/pressClubMemberMgmtService")
public class PressClubMemberMgmtServiceImpl extends DefaultServiceImpl implements PressClubMemberMgmtService {
	@Resource(name="/rc/sle/pressClubMemberMgmtDAO")
	private PressClubMemberMgmtDAO pressClubMemberMgmt;

	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PressClubMemberMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return pressClubMemberMgmt.selectList(parameter);
	}

	 
	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param slePressClubMemberMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.PressClubMemberMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap slePressClubMemberMgmt) throws Exception {
		int procCnt = 0;
		 
		for (int i = 0 ; i < slePressClubMemberMgmt.size() ; i++) {
			Map<String, Object> parameter = slePressClubMemberMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += pressClubMemberMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += pressClubMemberMgmt.updateData(parameter);
			}
		}
 
		return  procCnt;
	}

}
