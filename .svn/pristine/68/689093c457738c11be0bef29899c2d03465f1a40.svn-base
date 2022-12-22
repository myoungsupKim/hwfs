package com.hwfs.ms.msc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 개선계획작성 SaniImprovePlanService
 * 
 * @ClassName SaniImprovePlanService.java
 * @Description SaniImprovePlanService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.29                최초생성
 * </pre>
 * @author 
 * @since 2022.07.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SaniImprovePlanService {
	
	/**
	 * 개선계획작성 목록을 조회한다.
	*/
	RecordSet selectMaster(Map<String, Object> mapParam) throws Exception;
	RecordSet selectDetail(Map<String, Object> mapParam) throws Exception;
	int saveList(DataSetMap dsDetail,  LoginDTO loginDTO) throws Exception;
	

}
