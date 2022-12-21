package com.hwfs.rc.bms.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.BasCustMgmtDAO;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * BasCustMgmtServiceImpl에 대한 설명 작성
 * @ClassName BasCustMgmtServiceImpl.java
 * @Description BasCustMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 26.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 2. 26.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/basCustMgmtService")
public class BasCustMgmtServiceImpl extends DefaultServiceImpl implements	BasCustMgmtService {
	
	@Resource(name="/rc/bms/basCustMgmtDAO")
	private BasCustMgmtDAO basCustMgmt;
	
	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;
	
	/**
	 * selectCustList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.BasCustMgmtService#selectCustList(java.util.Map)
	 */
	@Override
	public RecordSet selectCustList(Map<String, Object> parameter)	throws Exception {
		
		//RecordSet rs = null;
		//int maskAuth = Integer.parseInt(parameter.get("maskAuth").toString());
		//관리용(저장, 삭제, 입력)의 권한이 있는 화면에서 조회권한만 있는 경우에는 아래와 같이 분기처리를 한다.
		//if (maskAuth == Const.MaskAuthMode.MASK) { //조회권한만 있으므로 개인정보의 마스킹 처리를 수행한다.
		//	rs = basCustMgmt.selectCustListMask(parameter);
		//}
		//else { //저장,삭제,입력등의 권한이 있으므로 비 마스킹처리를 한다.
		//	rs = basCustMgmt.selectCustList(parameter);
		//}
		
		//return rs;
		return  basCustMgmt.selectCustList(parameter);
		
	}

	/**
	 * saveCustMgmt 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param bmsAmMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.BasCustMgmtService#saveCustMgmt(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveCustMgmt(DataSetMap bmsCustMgmt, String sabun) throws Exception {
		int procCnt = 0;
		String custKey = "";
		
		for (int i = 0 ; i < bmsCustMgmt.size() ; i++) {
			Map<String, Object> parameter = bmsCustMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			//주소 처리
			addressService.setAddress( parameter, "addrInfo", sabun);
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				//amCd 값이 없는 경우 신규로 MAX 값을 생성 한다.
				//if ("".equals(parameter.get("amCd"))) {
					Record chkRs = this.basCustMgmt.maxCustCodeCreate(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						custKey = chkRs.getString("maxCustCd");
						if(!"".equals(custKey)){
							parameter.put("custCd", custKey);
						}
					}
				//}
				
				procCnt += basCustMgmt.insertCustMgmt(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += basCustMgmt.updateCustMgmt(parameter);
			}
		}
 
		return  procCnt;
	}

}
