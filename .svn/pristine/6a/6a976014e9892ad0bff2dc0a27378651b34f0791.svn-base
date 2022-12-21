package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

 /**
 * 접속사용자를 조회하는 ConnectUser Service Interface
 *
 * @ClassName ConnectUserService.java
 * @Description ConnectUserService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.08    김재섭        최초생성
 *  2015.07.09    kksoo         무단사용자 접속차단 및 접속상태 변경
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.08
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface ConnectUserService {

	/**
	 * CC별 접속자수를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCcByConnectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * CC별 접속자수를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectUserList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 접속사용자 목록을 조회한다.
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
	Map<String, RecordSet> selectList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 미접속 상태로 변경한다.
	 *
	 * @param listParam
	 * @throws Exception
	 */
	void changeDisconnStatus(List<Map<String, Object>> listParam) throws Exception;

}
