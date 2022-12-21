package com.hwfs.cs.ccs.dao;

import hone.core.util.record.RecordSet;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
* 상담 관리하는 cnslMgnt DAO
* 
* @ClassName CnslMgntDAO.java
* @Description CnslMgntDAO Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.03.12   	이규훈        최초생성
* </pre>
* @author FC종합전산구축 : 상담관리 이규훈
* @since 2015.03.12
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Repository("/cs/ccs/cnslMgntDAO")
public class CnslMgntDAO extends DefaultDAO {

	/**
	 * 상담을 저장한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param rowData
	 * @return
	 */
	public int insertCnslSave(Map<String, Object> parameter) throws Exception {
		return super.update("cs.ccs.cnslMgntDAO.insertCnslSave", parameter);
	}

	/**
	 * 상담이력 목록을 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCnslLogList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("cs.ccs.cnslMgntDAO.selectCnslLogList", parameter);
	}

	/**
	 * 미처리현황 목록을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCnslUntreatLogList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("cs.ccs.cnslMgntDAO.selectCnslUntreatLogList", parameter);
	}

	/**
	 * 상담현황 목록을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCnslTodayLogList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("cs.ccs.cnslMgntDAO.selectCnslTodayLogList", parameter);
	}

	/**
	 * 상담현황 목록 건 수 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int selectCnslTodayLogListCnt(Map<String, Object> parameter) {
		return super.queryForInt("cs.ccs.cnslMgntDAO.selectCnslTodayLogListCnt", parameter);
	}

	/**
	 * 상담이력 목록(팝업)을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCnslLogMgmtList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("cs.ccs.cnslMgntDAO.selectCnslLogMgmtList", parameter);
	}

	
	/**
	 * SMS이력 목록을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectSmsLogList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("cs.ccs.cnslMgntDAO.selectSmsLogList", parameter);
	}

	/**
	 * 미처리현황 목록에서 '처리상태'가 '처리중'->'처리완료' 업데이트한다.
	 *
	 * @param parameter
	 * @return
	 */
	public int updateProcessComplete(Map<String, Object> parameter) throws Exception {
		return super.update("cs.ccs.cnslMgntDAO.updateProcessComplete", parameter);
	}

	/**
	 * 미처리현황 목록 건 수 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int selectCnslUntreatLogCnt(Map<String, Object> parameter) throws Exception {
		return super.queryForInt("cs.ccs.cnslMgntDAO.selectCnslUntreatLogCnt", parameter);
	}

	/**
	 * 사업장 목록(팝업) 을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCnslMgmtCustInQueryList(Map<String, Object> parameter) throws SQLException {
		return super.queryForRecordSet("cs.ccs.cnslMgntDAO.selectCnslMgmtCustInQueryList", parameter);
	}
	
	public RecordSet selectCnslMgmtCustInQueryList2(Map<String, Object> parameter) throws SQLException {
		return super.queryForRecordSet("cs.ccs.cnslMgntDAO.selectCnslMgmtCustInQueryList2", parameter);
	}
	
	/**
	 * 상담평가이력 목록(팝업)을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCnslAllLogList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("cs.ccs.cnslMgntDAO.selectCnslAllLogList", parameter);
	}

	/**
	 * 상담평가이력의 평가내용, 평가점수을(를) 저장한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param rowData
	 * @return
	 */
	public int insertCnslEval(Map<String, Object> rowData) throws Exception {
		return super.update("cs.ccs.cnslMgntDAO.insertCnslEval", rowData);
	}

	/**
	 * 상담평가이력의 평가내용, 평가점수을(를) 수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param rowData
	 * @return
	 */
	public int updateCnslEval(Map<String, Object> rowData) throws Exception {
		return super.update("cs.ccs.cnslMgntDAO.updateCnslEval", rowData);
	}

	/**
	 * 상담평가이력의 평가내용, 평가점수을(를) 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param rowData
	 * @return
	 */
	public int deleteCnslEval(Map<String, Object> rowData) throws Exception {
		return super.update("cs.ccs.cnslMgntDAO.deleteCnslEval", rowData);
	}

	/**
	 * 고객 발신번호로 조회 시 건 수 조회
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int searchUpjangCnt(Map<String, Object> parameter) throws Exception {
		return super.queryForInt("cs.ccs.cnslMgntDAO.searchUpjangCnt", parameter);
	}

	/**
	 * 업장에 속해있는 담당자/영양사 목록을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectFmsUpjangCust(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("cs.ccs.cnslMgntDAO.selectFmsUpjangCust", parameter);
	}

	/**
	 * 내부사용자 목록 조회 한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectjikWonList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("cs.ccs.cnslMgntDAO.selectjikWonList", parameter);
	}

	public RecordSet selectCSList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("cs.ccs.cnslMgntDAO.selectCSList", parameter);
	}

	
	/**
	 * 상담이력 통계 현황 목록 조회 한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCnslHistoryStcsList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("cs.ccs.cnslMgntDAO.selectCnslHistoryStcsList", parameter);
	}

	/**
	 * 협력업체 목록 조회 한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectVendor(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("cs.ccs.cnslMgntDAO.selectVendor2", parameter);
	}

	/**
	 * 협력업체에 따른 담당자 목록 조회 한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectVendorMgmt(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("cs.ccs.cnslMgntDAO.selectVendorMgmt", parameter);
	}

	/**
	 * 주요내용 또는 상담내용을 수정한다. 
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param rowData
	 * @return
	 */
	public int updateContents(Map<String, Object> rowData) throws Exception {
		return super.update("cs.ccs.cnslMgntDAO.updateContents", rowData);
	}
}
