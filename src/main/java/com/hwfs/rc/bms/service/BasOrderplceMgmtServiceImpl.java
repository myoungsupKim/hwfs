package com.hwfs.rc.bms.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.BasOrderplceMgmtDAO;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * BasOrderplceMgmtServiceImpl에 대한 설명 작성
 * @ClassName BasOrderplceMgmtServiceImpl.java
 * @Description BasOrderplceMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 24.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 2. 24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
 /**
 * BasOrderplceMgmtServiceImpl에 대한 설명 작성
 * @ClassName BasOrderplceMgmtServiceImpl.java
 * @Description BasOrderplceMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 7.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 7. 7.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/basOrderplceMgmtService")
public class BasOrderplceMgmtServiceImpl extends DefaultServiceImpl implements BasOrderplceMgmtService {
	@Resource(name="/rc/bms/basOrderplceMgmtDAO")
	private BasOrderplceMgmtDAO basOrderplceMgmt;
	
	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;
	 
	/**
	 * selectOrderplceList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.rc.bms.service.BasOrderplceMgmtService#selectOrderplceList(java.util.Map)
	 */
	@Override
	public RecordSet selectOrderplceList(Map<String, Object> parameter) { 
		return  basOrderplceMgmt.selectOrderplceList(parameter); 
	}

	 
	/**
	 * saveOrderplceMgmt 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param bmsOrderplceMgmt
	 * @param sabun
	 * @return
	 * @see com.hwfs.rc.bms.service.BasOrderplceMgmtService#saveOrderplceMgmt(hone.online.xplatform.map.DataSetMap, java.lang.String)
	*/
	 
	@SuppressWarnings("unchecked")
	public int saveOrderplceMgmt(DataSetMap bmsOrderplceMgmt, String sabun) throws Exception {
		int procCnt = 0;
		String vendorKey = "";
		
		for (int i = 0 ; i < bmsOrderplceMgmt.size() ; i++) {
			Map<String, Object> parameter = bmsOrderplceMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			//주소 처리
			addressService.setAddress( parameter, "addrInfo", sabun);
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				 
					Record chkRs = this.basOrderplceMgmt.maxOrderplceCodeCreate(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						vendorKey = chkRs.getString("maxVndorCd");
						if(!"".equals(vendorKey)){
							parameter.put("vendorCd", vendorKey);
						}
					}
			 
				
				procCnt += basOrderplceMgmt.insertOrderplceMgmt(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += basOrderplceMgmt.updateOrderplceMgmt(parameter);
			}
		}
 
		return  procCnt;
	}

}
