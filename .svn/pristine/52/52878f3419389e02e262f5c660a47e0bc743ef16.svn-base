package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * SAP 전표 업로드하는 SapSlipUpload Service Interface
 * 
 * @ClassName SapSlipUploadService.java
 * @Description SapSlipUploadService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.16    JUN        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.06.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SapSlipUploadService {

	/**
	 * SAP 전표 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSlipList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 전표생성
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 코드/코드명
	 * @throws Exception
	*/
	String saveSlipList(DataSetMap list) throws Exception;

	/**
	 * 전표생성취소
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 코드/코드명
	 * @throws Exception
	*/
	String cancelSlipList(DataSetMap list) throws Exception;

	/**
	 * SAP 월마감 여부를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSapClose(Map<String, Object> mapParam) throws Exception;

}
