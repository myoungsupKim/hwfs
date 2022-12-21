package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 기기/기물관리하는 EventInfoMaster Service Interface
 * 
 * @ClassName EventInfoMasterService.java
 * @Description EventInfoMasterService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.05    김예진        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.03.05
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EventInfoMasterService {

	/**
	 * 마감현황 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectListCal(Map<String, Object> mapParam) throws Exception;

	/**
	 * 마스터등록 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param loginDTO
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectComboLclass(Map<String, Object> mapParam, LoginDTO loginDTO) throws Exception;
	RecordSet selectComboMclass(Map<String, Object> mapParam) throws Exception;
	RecordSet selectComboSclass(Map<String, Object> mapParam) throws Exception;
	RecordSet selectCodeUse(Map<String, Object> mapParam) throws Exception;
	RecordSet selectMachineMst(Map<String, Object> mapParam, LoginDTO loginDTO) throws Exception;
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 마스터등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap parameterMachineMst, DataSetMap parameterGrd, LoginDTO loginDTO) throws Exception;
}
