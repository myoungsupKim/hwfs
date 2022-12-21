package com.hwfs.guide.sample.service;

import java.util.List;
import java.util.Map;

 /**
 * EAI 호출 샘플하는 EAISample Service Interface
 *
 * @ClassName EAISampleService.java
 * @Description EAISampleService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.10    김재섭        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.10
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EAISampleService {

	/**
	 * 가수금 조회
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet
	 *            조회결과
	 * @throws Exception
	*/
	List<Map<String, Object>> selectSuspenseInquery(Map<String, Object> mapParam) throws Exception;

	/**
	 * 가수금 상세(히스토리) 조회
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> selectSuspenseLogInquery(Map<String, Object> mapParam) throws Exception;

	/**
	 * 가수금 대체 요청
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> processSuspenseAltRequest(Map<String, Object> mapParam) throws Exception;

	List<Map<String, Object>> selectSuspenseAltResult(Map<String, Object> mapParam) throws Exception;

	/**
	 * BPC로 최종 PL 전송
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	//List<Map<String, Object>> insertPlToBpc(Map<String, Object> mapParam) throws Exception;
}
