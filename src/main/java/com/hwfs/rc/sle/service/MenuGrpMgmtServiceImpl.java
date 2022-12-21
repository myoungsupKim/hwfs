package com.hwfs.rc.sle.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.rc.sle.dao.MenuGrpMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * MenuGrpMgmtServiceImpl에 대한 설명 작성
 * @ClassName MenuGrpMgmtServiceImpl.java
 * @Description MenuGrpMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 23.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 3. 23.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/menuGrpMgmtService")
public class MenuGrpMgmtServiceImpl extends DefaultServiceImpl implements MenuGrpMgmtService {
	@Resource(name="/rc/sle/menuGrpMgmtDAO")
	private MenuGrpMgmtDAO menuGrpMgmt;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MenuGrpMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return menuGrpMgmt.selectList(parameter);
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
	 * @see com.hwfs.rc.sle.service.MenuGrpMgmtService#searchList(java.util.Map)
	 */
	@Override
	public RecordSet searchList(Map<String, Object> parameter) throws Exception {
		return menuGrpMgmt.searchList(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param sleMenuGrpMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MenuGrpMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap sleMenuGrpMgmt) throws Exception {
		int procCnt = 0;
		
		
		
		for (int i = 0 ; i < sleMenuGrpMgmt.size() ; i++) {
			Map<String, Object> parameter = sleMenuGrpMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				 
				procCnt += menuGrpMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				//사용 유무를 미사용으로 변경 한경우  하위코드 처리를 먼저 해야 한다 없는 경우는 상관 없다.
				
				procCnt += menuGrpMgmt.updateData(parameter);
			}
		}
 
		return  procCnt;
	}

	@Override
	@SuppressWarnings("unchecked")
	public int deleteData(DataSetMap sleMenuGrpMgmt) throws Exception {
		int procCnt = 0;
		int menuCnt = 0;
		
		for (int i = 0 ; i < sleMenuGrpMgmt.size() ; i++) {
			Map<String, Object> parameter = sleMenuGrpMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			/*
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				 
				procCnt += menuGrpMgmt.insertData(parameter);
			}
			else
			*/
			
			if (rowType == DataSet.ROW_TYPE_UPDATED){
				//사용 유무를 미사용으로 변경 한경우  하위코드 처리를 먼저 해야 한다 없는 경우는 상관 없다.
				Record chkRs = menuGrpMgmt.selectMenuCnt(parameter);
				
				if(chkRs != null && chkRs.size() > 0) {
					menuCnt = chkRs.getInt("menuCnt");
					if( menuCnt > 0 ){
						String sMsg = "** 메뉴 자료가 존재합니다. **"
								+ "\n 메뉴관리에서 해당 메뉴를 먼저 삭제 하십시오!";
						throw new BizException(sMsg); 
					}else{
						
							procCnt += menuGrpMgmt.deleteData(parameter);
					}
				}
			}
		}
 
		return  procCnt;
	}
	
}
