package com.hwfs.sc.scu.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 가사번 사용자를 관리하는 TempUserMgmt Service Interface
 * 
 * @ClassName TempUserMgmtService.java
 * @Description TempUserMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.02    김재섭        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.10.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TempUserMgmtService {

	/**
	 * 가사번 사용자 목록을 조회한다.
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
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
	RecordSet selectOrgInfo(Map<String, Object> mapParam) throws Exception;

	RecordSet selectCreateTempSabun(Map<String, Object> mapParam) throws Exception;
	/**
	 * 가사번 사용자 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;
	
	int clearPassword(Map<String, Object> mapParam) throws Exception;
}
