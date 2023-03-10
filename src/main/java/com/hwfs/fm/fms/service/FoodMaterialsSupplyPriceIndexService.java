package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 식자재 단가표하는 FoodMaterialsSupplyPriceIndex Service Interface
 * 
 * @ClassName FoodMaterialsSupplyPriceIndexService.java
 * @Description FoodMaterialsSupplyPriceIndexService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17    최영준        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.04.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FoodMaterialsSupplyPriceIndexService {

	/**
	 * 공급 단가정보 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectListA(Map<String, Object> mapParam) throws Exception;
	RecordSet selectListB(Map<String, Object> mapParam) throws Exception;
	RecordSet selectListC(Map<String, Object> mapParam) throws Exception;
	RecordSet selectListD(Map<String, Object> mapParam) throws Exception;
	RecordSet selectListF(Map<String, Object> mapParam) throws Exception;
	RecordSet selectListG(Map<String, Object> mapParam) throws Exception;

	/**
	 * 단가계약번호 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectContractId(Map<String, Object> mapParam) throws Exception;
}
