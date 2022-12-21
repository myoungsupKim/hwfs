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
import com.hwfs.sc.scc.dao.HnrItemMappingDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * HnrItemMapping Service Implementation
 * 
 * @ClassName HnrItemMappingServiceImpl.java
 * @Description HnrItemMappingServiceImpl Class
 * @Modification-
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
@Service("/sc/scc/hnrItemMappingService")
public class HnrItemMappingServiceImpl extends DefaultServiceImpl implements HnrItemMappingService {
	
	/** HnrItemMappingDAO Bean 생성 */
	@Resource(name = "/sc/scc/hnrItemMappingDAO")
	private HnrItemMappingDAO hnrItemMappingDAO;
	
	public Map<String, RecordSet> selectList(Map<String, Object> mapParam) throws Exception {
		Map<String, RecordSet> hnrItemMappingList = new HashMap<String, RecordSet>();
		hnrItemMappingList.put("hnrItemMappingList", hnrItemMappingDAO.selectHnrItemMapping(mapParam));
		return hnrItemMappingList;
	}

	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap dataSetMap, LoginDTO loginDTO) throws Exception {
		
		int changeRowCnt=0;
		
		// 입력한 코드 듀프 체크 
		String resultStringFd = selectItemCode(dataSetMap, "fd");
		String resultStringHnr = selectItemCode(dataSetMap, "hnr");
		
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
				changeRowCnt +=  hnrItemMappingDAO.insertHnrItemMapping(rowData); 
			}
		}
	
		return changeRowCnt;
	}
	
	@Override
	public String selectItemCode(DataSetMap dataSetMap, String itemType) throws Exception {
		String itemCodeArr = "''";
		String itemCodeList = null;
		
		for(int i=0; i<dataSetMap.size(); i++) {
			Map<String, Object> rowData = dataSetMap.get(i);
			int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if(rowType==DataSet.ROW_TYPE_INSERTED) {
				if(itemType == "fd") {
					itemCodeArr += ",'" + rowData.get("fdItemcode").toString().replaceAll(" ", "") + "'";
				} else {
					itemCodeArr += ",'" + rowData.get("hnrItemcode").toString().replaceAll(" ", "") + "'";
				}
				
				
			}
		}
		
		List<Map> itemCodeMap = hnrItemMappingDAO.selectItemCodeList(itemCodeArr, itemType);
		
		if(itemType == "fd") {
			itemCodeList = itemCodeMap.get(0).get("fdItemcodeList").toString();
		} else {
			itemCodeList = itemCodeMap.get(0).get("hnrItemcodeList").toString();
		}
		
		return itemCodeList;
	}
}
