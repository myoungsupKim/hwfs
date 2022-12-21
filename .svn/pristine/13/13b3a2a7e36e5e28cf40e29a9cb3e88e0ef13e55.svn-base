package com.hwfs.ms.mef.service;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.ms.mef.dto.FileUploadEfoodistDTO;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

 /**
 * E-FOODIST등록관리(파일첨부)하는 FileUploadEfoodist Service Interface
 * 
 * @ClassName FileUploadEfoodistService.java
 * @Description FileUploadEfoodistService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.17    강대성        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : E-FOODIST(런타임,모바일) 강대성
 * @since 2015.03.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FileUploadEfoodistService {

	/**
	 * E-FOODIST등록관리(파일첨부) 목록을 조회한다.
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
	RecordSet selectList(Map<String, Object> parameter) throws Exception;
	
	/**
	 * E-FOODIST등록관리(파일첨부) 목록을 조회한다.
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
	RecordSet selectDetailList(Map<String, Object> parameter) throws Exception;
	
	/**
	 * 등록정보 목록을 조회한다.
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
	RecordSet selectPopList(Map<String, Object> parameter) throws Exception;
	
	/**
	 * E-FOODIST등록관리(파일첨부) DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	String saveAttachFile(DataSetMap list, DataSetMap listFile) throws Exception;
}
