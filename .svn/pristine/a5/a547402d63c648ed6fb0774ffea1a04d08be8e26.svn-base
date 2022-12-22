package com.hwfs.cs.ccs.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.sql.SQLException;
import java.util.Map;

/**
* 상담 관리하는 CnslMgmt Service Interface
* 
* @ClassName CnslMgmtService.java
* @Description CnslMgmtService Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.03.12    이규훈        최초생성
* </pre>
* @author FC종합전산구축 :  상담관리 이규훈
* @since 2015.03.12
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
public interface CnslMgntService {

	/**
	 * 상담을 저장한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	int insertCnslSave(DataSetMap list) throws Exception;

	/**
	 * 상담이력 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param parameter
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectCnslLogList(Map<String, Object> parameter) throws Exception;

	/**
	 * 미처리현황 목록을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	RecordSet selectCnslUntreatLogList(Map<String, Object> parameter) throws Exception;

	/**
	 * 상담현황 목록을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	RecordSet selectCnslTodayLogList(Map<String, Object> parameter) throws Exception;

	/**
	 * 상담현황 목록 건 수 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	int selectCnslTodayLogListCnt(Map<String, Object> parameter) throws Exception;

	/**
	 * 상담이력 목록(팝업)을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	RecordSet selectCnslLogMgmtList(Map<String, Object> parameter) throws Exception;
	
	/**
	 * SMS이력 목록 조회 한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	RecordSet selectSmsLogList(Map<String, Object> parameter) throws Exception;

	/**
	 * 미처리현황 목록에서 '처리상태'가 '처리중'->'처리완료' 업데이트한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param map
	 * @return
	 */
	int updateProcessComplete(DataSetMap list) throws Exception;

	/**
	 * 미처리현황 목록 건 수 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	int selectCnslUntreatLogCnt(Map<String, Object> parameter) throws Exception;

	/**
	 * 사업장 목록을 조회한다.(팝업)
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	RecordSet selectCnslMgmtCustInQueryList(Map<String, Object> parameter) throws SQLException;
		
	/**
	 * 상담평가이력 목록(팝업)을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param map
	 * @return
	 */
	RecordSet selectCnslAllLogList(Map<String, Object> parameter) throws Exception;

	/**
	 * 상담평가이력의 평가내용, 평가점수을(를) 저장한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	int insertCnslEvalSave(DataSetMap list) throws Exception;

	/**
	 * 고객 발신번호로 조회 시 건 수 조회
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	int searchUpjangCnt(Map<String, Object> parameter) throws Exception;

	/**
	 * 업장에 속해있는 담당자/영양사 목록을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	RecordSet selectFmsUpjangCust(Map<String, Object> parameter) throws Exception;

	/**
	 * 내부사용자 목록 조회 한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	RecordSet selectjikWonList(Map<String, Object> parameter) throws Exception;
	
	RecordSet selectCSList(Map<String, Object> parameter) throws Exception;

	/**
	 * 상담이력 통계 현황 목록 조회 한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	RecordSet selectCnslHistoryStcsList(Map<String, Object> parameter) throws Exception;

	/**
	 * 협력업체 목록 조회 한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	RecordSet selectVendor(Map<String, Object> parameter) throws Exception;

	/**
	 * 협력업체에 따른 담당자 목록 조회 한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	RecordSet selectVendorMgmt(Map<String, Object> parameter) throws Exception;

	/**
	 * 주요내용 또는 상담내용을 수정한다. 
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	int updateContents(DataSetMap parameter) throws Exception;
}
