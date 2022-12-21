package com.hwfs.rc.bms.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.BasAmMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * BasAmMgmtServiceImpl에 대한 설명 작성
 * @ClassName BasAmMgmtServiceImpl.java
 * @Description BasAmMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 9.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 2. 9.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/basAmMgmtService")
public class BasAmMgmtServiceImpl extends DefaultServiceImpl implements	BasAmMgmtService {
 
	@Resource(name="/rc/bms/basAmMgmtDAO")
	private BasAmMgmtDAO basAmMgmt;
	
	/**
	 * selectAmList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.rc.bms.service.BasAmMgmtService#selectAmList()
	 */
	 
	@Override
	public RecordSet selectAmList(Map<String, Object> parameter) {
	 
		return basAmMgmt.selectList(parameter);
		
	}
	
	@Override
	public RecordSet amEmpNoSearch(Map<String, Object> parameter) {
	 
		return basAmMgmt.amEmpNoSearch(parameter);
		
	}
	
	
	/**
	 * saveAmMgmt 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.rc.bms.service.BasAmMgmtService#saveAmMgmt()
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveAmMgmt(DataSetMap bmsAmMgmt) {
		int procCnt = 0;
		String amKey = "";
		
		for (int i = 0 ; i < bmsAmMgmt.size() ; i++) {
			Map<String, Object> parameter = bmsAmMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				//amCd 값이 없는 경우 신규로 MAX 값을 생성 한다.
				//if ("".equals(parameter.get("amCd"))) {
					Record chkRs = this.basAmMgmt.maxAmCodeCreate();
					if(chkRs != null && chkRs.size() > 0) {
						amKey = chkRs.getString("maxAmcd");
						if(!"".equals(amKey)){
							parameter.put("amCd", amKey);
						}
					}
				//}
				
				procCnt += basAmMgmt.insertAmMgmt(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += basAmMgmt.updateAmMgmt(parameter);
			}
		}
 
		return  procCnt;
	}
	
}
