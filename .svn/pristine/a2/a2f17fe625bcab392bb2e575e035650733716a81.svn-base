package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.scc.dao.HnrSubinvMappingDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * HnrSubinvMapping Service Implementation
 * 
 * @ClassName OrgConfigServiceImpl.java
 * @Description OrgConfigServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  
 * </pre>
 * @author 
 * @since 
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scc/hnrSubinvMappingService")
public class HnrSubinvMappingServiceImpl extends DefaultServiceImpl implements HnrSubinvMappingService {
	
	/** HnrSubinvMappingDAO Bean 생성 */
	@Resource(name = "/sc/scc/hnrSubinvMappingDAO")
	private HnrSubinvMappingDAO hnrSubinvMappingDAO;
	
	public Map<String, RecordSet> selectList(Map<String, Object> mapParam) throws Exception {
		Map<String, RecordSet> hnrSubinvMappingList = new HashMap<String, RecordSet>();
		hnrSubinvMappingList.put("hnrSubinvMappingList", hnrSubinvMappingDAO.selectHnrSubinvMapping(mapParam));
		return hnrSubinvMappingList;
	}

	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap dataSetMap, LoginDTO loginDTO) throws Exception {
		
		int changeRowCnt=0;
		
		// 입력한 코드 듀프 체크 
		String resultStringFd = selectSubinvCode(dataSetMap, "fd");
		String resultStringHnr = selectSubinvCode(dataSetMap, "hnr");
		
		if(!resultStringFd.equals("-") || !resultStringHnr.equals("-")) {
			String exceptionMsg = "중복된 코드가 있습니다. ";
			if(!resultStringFd.equals("-")) {
				exceptionMsg += "\n FD : "+ resultStringFd;
			}
			if(!resultStringHnr.equals("-")) {
				exceptionMsg += "\n HNR : "+ resultStringHnr;
			}
			
			throw new BizException(exceptionMsg);
		}
		
		// 입력수행
		for(int i=0; i<dataSetMap.size(); i++) {
			Map<String, Object> rowData = dataSetMap.get(i);
			int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if(rowType==DataSet.ROW_TYPE_INSERTED) {
				rowData.put("cuser", loginDTO.getSabun());
				changeRowCnt +=  hnrSubinvMappingDAO.insertHnrSubinvMapping(rowData); 
				
			}
		}
		return changeRowCnt;
	}
	
	@Override
	public String selectSubinvCode(DataSetMap dataSetMap, String subinvType) throws Exception {
		String subinvCodeArr = "''";
		String subinvCodeList = null;
		
		for(int i=0; i<dataSetMap.size(); i++) {
			Map<String, Object> rowData = dataSetMap.get(i);
			int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if(rowType==DataSet.ROW_TYPE_INSERTED) {
				if(subinvType == "fd") {
					subinvCodeArr += ",'" + rowData.get("fdSubinvCode").toString().replaceAll(" ", "") + "'";
				} else {
					subinvCodeArr += ",'" + rowData.get("hnrSubinvCode").toString().replaceAll(" ", "") + "'";
				}
				
				
			}
		}

		List<Map> itemCodeMap = hnrSubinvMappingDAO.selectSubinvCodeList(subinvCodeArr, subinvType);
		
		if(subinvType == "fd") {
			subinvCodeList = itemCodeMap.get(0).get("fdSubinvCodeList").toString();
		} else {
			subinvCodeList = itemCodeMap.get(0).get("hnrSubinvCodeList").toString();
		}
		return subinvCodeList;
	}
}
