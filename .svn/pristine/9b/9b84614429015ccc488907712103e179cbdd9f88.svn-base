package com.hwfs.guide.sample.service;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.guide.sample.dto.GuideSampleDTO;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

 /**
 * GuideSampleService에 대한 설명 작성
 * @ClassName GuideSampleService.java
 * @Description GuideSampleService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.01.22.   김재섭       최초생성
 *  2015.02.02.   kksoo        첨부파일 추가
 *  2015.03.24.   kksoo        전자결재 연동 추가
 * </pre>
 * @author FC종합전산구축 : AA 김재섭
 * @since 2015. 1. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface GuideSampleService {
	RecordSet selectList(Map<String, Object> parameter) throws Exception;
	int saveList(DataSetMap list) throws Exception;
	String saveAttachFile(DataSetMap list, DataSetMap listFile) throws Exception;

	RecordSet selectListDTO(GuideSampleDTO parameter) throws Exception;
	int saveListDTO(LoginDTO loginParameter, List<GuideSampleDTO> insertParameter, List<GuideSampleDTO> updateParameter, List<GuideSampleDTO> deleteParameter) throws Exception;

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
	 * selectCcsTempList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	RecordSet selectCcsTempList(Map<String, Object> parameter) throws Exception;
	/**
	 * saveCcsTempList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	int saveCcsTempList(DataSetMap parameter) throws Exception;


	/**
	 * 조직도샘플
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	RecordSet selectOrg() throws Exception;
}
