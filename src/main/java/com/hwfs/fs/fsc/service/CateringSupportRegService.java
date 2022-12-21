package com.hwfs.fs.fsc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 케터링 지원요청하는 CateringSupportReg Service Interface
 * 
 * @ClassName CateringSupportRegService.java
 * @Description CateringSupportRegService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.05    yanghj        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 yanghj
 * @since 2015.03.05
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface CateringSupportRegService {

	/**
	 * 케터링 지원요청 행사 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCeleList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 케터링 지원요청 조리인력 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectCookHumanList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 케터링 지원요청 기기/기물 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectUtensilList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 케터링 지원요청 교육대상 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectCookGuidList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 케터링 지원요청 교육대상 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectQuantity(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 케터링 사업장 기준정보 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	RecordSet selectListUpjangInfo(Map<String, Object> mapParam) throws Exception;

	/**
	 * 케터링 지원요청 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap parameterCele, DataSetMap parameterCookHuman, DataSetMap parameterUtensilList, DataSetMap parameterCookGuidList, LoginDTO loginDTO ) throws Exception;
}
