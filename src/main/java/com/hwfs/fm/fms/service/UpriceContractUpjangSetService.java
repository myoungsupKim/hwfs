package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 단가계약업장을 설정하는 UpriceContractUpjangSet Service Interface
 * 
 * @ClassName UpriceContractUpjangSetService.java
 * @Description UpriceContractUpjangSetService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.09    최성연        최초생성
 *   
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.03.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface UpriceContractUpjangSetService {
	/**
	 * 단가계약업장 목록을 조회한다.
	 * <pre>
	 * - DTO 
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectStd(Map<String, Object> mapParam) throws Exception;

	/**
	 * 대상업체 목록을 조회한다.
	 * <pre>
	 * - DTO 
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 단가계약업장 목록을 조회한다.
	 * <pre>
	 * - DTO 
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectUpjangList(Map<String, Object> mapParam) throws Exception;
	

	/**
	 * 센터정보 LIST를 조회한다.
	 * <pre>
	 * - DTO 
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCenter(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 팀정보 LIST를 조회한다.
	 * <pre>
	 * - DTO 
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectTeam(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 단가계약업장의 이익율관리 항목여부를 저장한다 
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveStdList(LoginDTO loginParameter, DataSetMap list) throws Exception;

	
	/**
	 * 단가계약업장을 삭제한다 
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int delStdList(LoginDTO loginParameter, DataSetMap list) throws Exception;
	
	
	
	/**
	 * 단가계약업장 데이터를 rowType에 따라 Insert/Update/Delete 처리한다. (DTO)
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(LoginDTO loginParameter, DataSetMap list) throws Exception;
	
	/**
	 * 단가계약업장을 지정한다. (DTO)
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList2(LoginDTO loginParameter, DataSetMap list) throws Exception;

	/**
	 * 단가계약업장의 비고사항을 저장한다. (DTO)
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveAttr(LoginDTO loginParameter, DataSetMap list) throws Exception;

}
