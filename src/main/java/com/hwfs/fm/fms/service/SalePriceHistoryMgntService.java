package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 판매가격 이력관리 SalePriceHistoryMgntService Service Interface
 * 
 * @ClassName SalePriceHistoryMgntService.java
 * @Description SalePriceHistoryMgntService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.06.04    kihoon        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 kihoon
 * @since 2018.06.04
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SalePriceHistoryMgntService {

	
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	List<Map<String, Object>> selectListKamis(Map<String, Object> mapParam) throws Exception;
	RecordSet selectTrendList(Map<String, Object> mapParam) throws Exception;
	List<Map> selectPredict(Map<String, Object> mapParam, Map<String, Object> param2) throws Exception;
	
	RecordSet selectStatusList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectLstOrderList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectContractList(Map<String, Object> mapParam, LoginDTO loginDTO) throws Exception;
	int saveContractList(DataSetMap list, LoginDTO loginDTO) throws Exception;
}
