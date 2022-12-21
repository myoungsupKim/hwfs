package com.hwfs.fm.fmc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 물류요청서등록하는 DistributionRequestRptReg Service Interface
 * 
 * @ClassName DistributionRequestRptRegService.java
 * @Description DistributionRequestRptRegService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.06    최영준        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.03.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface DistributionRequestRptRegService {

	/**
	 * 물류요청서 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param parameter
	 *            조회조건 MAP
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	//RecordSet selectListDTO(DistributionRequestRptRegDTO parameter) throws Exception;
	
	RecordSet selectList(Map<String, Object> parameter) throws Exception;
	RecordSet selectMast(Map<String, Object> parameter) throws Exception;
	

	/**
	 * 물류요청서 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DistributionRequestRptReg XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	
	int saveList(DataSetMap list) throws Exception;
	int saveMast(Map<String, Object> parameter2) throws Exception;
	
}
