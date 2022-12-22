package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

 /**
 * 무단사용자를 관리하는 NoPermissionUserMgmt Service Interface
 * 
 * @ClassName NoPermissionUserMgmtService.java
 * @Description NoPermissionUserMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.08    kksoo        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.07.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface NoPermissionUserMgmtService {

	/**
	 * 무단사용자 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 무단사용자 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 차단 또는 해지 처리한다.
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;

	/**
	 * 무단사용자를 접속차단하기 위해 등록한다.
	 * <pre>
	 * - 접속사용자 화면에서 호출한다.
	 * - 미접속 상태로 변경한다.
	 * </pre>
	 *
	 * @param listParam
	 *            무단사용자 정보 List<Map> : sabun, connIp, sessionId, appId로 구성
	 * @param regYn
	 *            무단사용자 등록 여부
	 * @param itctReason
	 *            접속차간사유
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveNoPermissionUser(List<Map<String, Object>> listParam, String regYn, String itctReason) throws Exception;

}
