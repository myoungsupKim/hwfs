package com.hwfs.sc.scp.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

 /**
 * 개인정보 파기요청을 관리하는 PersDstryReq Service Interface
 * 
 * @ClassName PersDstryReqService.java
 * @Description PersDstryReqService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    kksoo        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface PersDstryReqService {

	/**
	 * 개인정보 파기요청 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 개인정보 파기요청 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;

	/**
	 * 개인정보 파기요청 상신 목록을 조회한다.
	 *
	 * @param list
	 *            조회조건 List<Map>
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	List<Record> selectGwDraftList(List<Map<String, Object>> list) throws Exception;

	/**
	 * 전자결재정보를 Update 처리한다.
	 * <pre>
	 * - 업무 테이블에 Instance ID Update
	 * - 결재정보 공통 테이블에 결재정보 Insert or Update
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 */
	int saveSignInfo(DataSetMap list) throws Exception;

	/**
	 * 개인정보파기요청이 결재승인이 난 경우 개인정보파기이력 테이블에 Insert 처리한다.
	 * <pre>
	 * - 개인정보파기요청 테이블에서 결재승인 && 이력처리YN이 'Y'가 아닌 건에 대해서만 개인정보파기이력 테이블에 INSERT
	 * </pre>
	 *
	 * @return 처리건수
	 * @throws Exception
	 */
	int insertPersDstryReqLog() throws Exception;

}
