package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 판매단가를 강제변경하는 SmsSendMgmt Service Interface
 * 
 * @ClassName SmsSendMgmtService.java
 * @Description SmsSendMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.07.25    kihoon        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2016.07.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2016 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SmsSendMgmtService {

	/**
	 * 업장 목록을 조회한다.
	 * <pre>
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
	 * 고객 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCustList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * SMS 발송 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap parameterSend, DataSetMap parameterForm, LoginDTO loginDTO) throws Exception;
	
	/**
	 * SMS 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSmsLogList(Map<String, Object> mapParam) throws Exception;

	/**
	 * saveCouponList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameterSend
	 * @param parameterForm
	 * @param loginDTO
	 * @return
	 * @throws Exception 
	 */
	int saveCouponList(DataSetMap parameterSend, DataSetMap parameterForm,	LoginDTO loginDTO) throws Exception;
	
	/**
	 * LMS 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	//RecordSet selectLmsMgmtList(Map<String, Object> mapParam) throws Exception;
}
