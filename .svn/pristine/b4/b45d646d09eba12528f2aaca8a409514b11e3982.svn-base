package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 *  HnrItemMapping Service Interface
 * 
 * @ClassName HnrItemMappingService.java
 * @Description HnrItemMappingService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  
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
public interface HnrItemMappingService {
	Map<String, RecordSet> selectList(Map<String, Object> mapParam) throws Exception;
	int saveList(DataSetMap dataSetMap, LoginDTO loginDTO) throws Exception;
	public String selectItemCode(DataSetMap dataSetMap, String itemType) throws Exception;
}
