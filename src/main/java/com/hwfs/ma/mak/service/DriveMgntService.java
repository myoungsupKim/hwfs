package com.hwfs.ma.mak.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * DriveMgnt Service Interface
 * 
 * @ClassName DriveMgntService.java
 * @Description DriveMgntService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.02.11    kihoon        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 kihoon
 * @since 2019.02.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface DriveMgntService {

	/**
	 * 차량목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCarList(Map<String, Object> mapParam) throws Exception;
	
	RecordSet selectCarDetail(Map<String, Object> mapParam) throws Exception;
	
	int saveList(DataSetMap list) throws Exception;
	
	int saveListDetail(DataSetMap listData, DataSetMap listFile) throws Exception;
	
	Record selectGwDraftMst(Map<String, Object> mapParam) throws Exception;
	
	int updateSignInfo(DataSetMap list) throws Exception;
	
	//int updateCarInfo(DataSetMap list) throws Exception;
	
	//int deleteCarInfo(DataSetMap list) throws Exception;
}
