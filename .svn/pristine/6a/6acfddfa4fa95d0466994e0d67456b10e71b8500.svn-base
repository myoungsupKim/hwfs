package com.hwfs.rc.bms.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.BasCaterchMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * basCaterchMgmtServiceImpl에 대한 설명 작성
 * @ClassName basCaterchMgmtServiceImpl.java
 * @Description basCaterchMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 13.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 2. 13.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/basCaterchMgmtService")
public class BasCaterchMgmtServiceImpl extends DefaultServiceImpl implements BasCaterchMgmtService {

	@Resource(name="/rc/bms/basCaterchMgmtDAO")
	private BasCaterchMgmtDAO basCaterchMgmt;
	
	/**    
	 * selectCaterchList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.rc.bms.service.BasCaterchMgmtService#selectCaterchList()
	 */
	 
	@Override
	public RecordSet selectCaterchList(Map<String, Object> parameter) {
		// TODO Auto-generated method stub
		return basCaterchMgmt.selectCaterchList(parameter);
		
	}
	
	/**
	 * saveCaterchMgmt 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.rc.bms.service.BasCaterchMgmtService#saveCaterchMgmt()
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveCaterchMgmt(DataSetMap bmsCaterchMgmt) {
		int procCnt = 0;
		String amKey = "";
		
		for (int i = 0 ; i < bmsCaterchMgmt.size() ; i++) {
			Map<String, Object> parameter = bmsCaterchMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				//amCd 값이 없는 경우 신규로 MAX 값을 생성 한다.
				//if ("".equals(parameter.get("amCd"))) {
					Record chkRs = this.basCaterchMgmt.maxCaterchCodeCreate(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						amKey = chkRs.getString("maxCaterchcd");
						if(!"".equals(amKey)){
							parameter.put("caterchfCd", amKey);
						}
						 
					}
				//}
				
				procCnt += basCaterchMgmt.insertCaterchMgmt(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += basCaterchMgmt.updateCaterchMgmt(parameter);
			}
		}
		 
		return procCnt;
	}
	
}
