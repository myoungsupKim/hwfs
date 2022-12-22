package com.hwfs.ms.msc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 위생점검결과조회 SaniCheckResult Service Interface
 * 
 * @ClassName SaniCheckResultService.java
 * @Description SaniCheckResultService Class
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
public interface SaniCheckResultService {
	
	/**
	 * 위생점검결과 목록을 조회한다.
	*/
	RecordSet selectMasterList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectDetailNewList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectSabunList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectFormCdList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectCommonCdList(Map<String, Object> mapParam) throws Exception;
	int saveList(DataSetMap dsMaster, DataSetMap dsDetail,  LoginDTO loginDTO) throws Exception;
	int deleteList(DataSetMap dsMaster, DataSetMap dsDetail) throws Exception;
	

}
