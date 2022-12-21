package com.hwfs.sm.ssi.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 카드 반송사유 코드를 관리하는 CardBackReasonCd Service Interface
 * 
 * @ClassName CardBackReasonCdService.java
 * @Description CardBackReasonCdService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.30    Yu        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface CardBackReasonCdService {

	/**
	 * 카드 반송사유 코드 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 카드 반송사유 코드 중복체크를 한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	int selectExists(Map<String, Object> mapParam) throws Exception;

	/**
	 * 카드 반송사유 코드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;
}
