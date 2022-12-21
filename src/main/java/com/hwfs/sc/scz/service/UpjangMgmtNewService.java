package com.hwfs.sc.scz.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

 /**
 * 업장의 마스터 정보를 관리하는 UpjangMgmt Service Interface
 *
 * @ClassName UpjangMgmtService.java
 * @Description UpjangMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.07    김재섭        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.07
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface UpjangMgmtNewService {

	/**
	 * 업장 마스터 정보 목록을 조회한다.
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
	
	RecordSet selectSaveUpjangList(DataSetMap list, Map<String, Object> mapParam) throws Exception;
	
	RecordSet selectLikeUpjangNm(Map<String, Object> mapParam) throws Exception;

	/**
	 * 업장 마스터 정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	List<Map<String, Object>> saveList(DataSetMap list, String sabun, DataSetMap changeLog) throws Exception;
	
	Map<String, Object> selectGwContent(Map<String, Object> mapParam) throws Exception;
	
	int updateGwId(Map<String, Object> parameter) throws Exception;
	
	int procSapRequest() throws Exception;
	
	RecordSet selectIncludeCS(Map<String, Object> mapParam) throws Exception;
	
	int updataUserCancel(Map<String, Object> parameter) throws Exception;
}
