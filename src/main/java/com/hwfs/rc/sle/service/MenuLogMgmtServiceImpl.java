package com.hwfs.rc.sle.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.MenuLogMgmtDAO;
import com.hwfs.sc.cmn.util.DateUtil;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * MenuLogMgmtServiceImpl에 대한 설명 작성
 * @ClassName MenuLogMgmtServiceImpl.java
 * @Description MenuLogMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 23.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 4. 23.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/menuLogMgmtService")
public class MenuLogMgmtServiceImpl extends DefaultServiceImpl implements MenuLogMgmtService {
	@Resource(name="/rc/sle/menuLogMgmtDAO")
	private MenuLogMgmtDAO menuLogMgmt;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MenuLogMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return menuLogMgmt.selectList(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param sleMenuLogMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.MenuLogMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap sleMenuLogMgmt) throws Exception {
		int procCnt = 0;
		int maxCode = 0;  
		int posYn   = 1;
		
		for (int i = 0 ; i < sleMenuLogMgmt.size() ; i++) {
			Map<String, Object> parameter = sleMenuLogMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				//Code 값이 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("seq") || "".equals(parameter.get("seq")))
				{					
					Record chkRs = menuLogMgmt.maxCodeCreate(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						maxCode = chkRs.getInt("maxCode");
						if(!"".equals(maxCode)){
							parameter.put("seq", maxCode);
						}
					}
				}
				
				procCnt += menuLogMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += menuLogMgmt.updateData(parameter);
			}
			
			posYn = menuLogMgmt.selectPosYn(parameter);
			
			if(posYn == 0 || parameter.get("applyDd").equals(DateUtil.getYyyymmdd()) ) 
			{
				procCnt += menuLogMgmt.menuSave(parameter);
			}
		}
 
		return  procCnt;
	}

}
