package com.hwfs.ft.fsi.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 국가별 항구 관리하는 PortAirportMgmtPort Service Interface
 * 
 * @ClassName PortAirportMgmtPortService.java
 * @Description PortAirportMgmtPortService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.10    김종준        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 식재도매 김종준
 * @since 2015.03.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface PortAirportMgmtPortService {

	/**
	 * 국가별 항구 목록을 조회한다.
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
	RecordSet selectPortAirportMgmtPort(Map<String, Object> mapParam) throws Exception;

	/**
	 * 국가별 항구 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int savePortAirportMgmtPortList(DataSetMap list) throws Exception;
}
