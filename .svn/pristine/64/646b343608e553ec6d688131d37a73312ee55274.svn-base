package com.hwfs.cs.ccs.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.sql.SQLException;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cs.ccs.dao.CnslMgntDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
* 상담 관리하는 CnslMgnt Service Implementation
* 
* @ClassName CnslMgntServiceImpl.java
* @Description CnslMgntServiceImpl Class
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
@Service("/cs/ccs/cnslMgntService")
public class CnslMgntServiceImpl extends DefaultServiceImpl implements CnslMgntService {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CnslMgntDAO Bean 생성 */
	@Resource(name = "/cs/ccs/cnslMgntDAO")
	private CnslMgntDAO cnslMgntDAO;

	/**
	 * 상담을 저장한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#insertCnslSave(hone.online.xplatform.map.DataSetMap)
	*/
	@Override
	public int insertCnslSave(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		for (int i = 0; i < list.size(); i++) {
			@SuppressWarnings("unchecked")
			Map<String, Object> rowData = list.get(i);
			insRowCnt += cnslMgntDAO.insertCnslSave(rowData);
			cnslMgntDAO.insertCnslEval(rowData);
		}

		return insRowCnt + updRowCnt + delRowCnt;
	}

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
	public RecordSet selectCnslLogList(Map<String, Object> parameter) throws Exception {
		return cnslMgntDAO.selectCnslLogList(parameter);
	}

	/**
	 * 미처리현황 목록을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#selectCnslUntreatLogList(java.util.Map)
	*/
	@Override
	public RecordSet selectCnslUntreatLogList(Map<String, Object> parameter) throws Exception {
		return cnslMgntDAO.selectCnslUntreatLogList(parameter);
	}

	/**
	 * 미처리현황 목록에서 '처리상태'가 '처리중'->'처리완료' 업데이트한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int updateProcessComplete(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			updRowCnt += cnslMgntDAO.updateProcessComplete(rowData);
		}

		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * 상담현황 목록을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#selectCnslTodayLogList(java.util.Map)
	*/
	@Override
	public RecordSet selectCnslTodayLogList(Map<String, Object> parameter) throws Exception {
		return cnslMgntDAO.selectCnslTodayLogList(parameter);
	}

	/**
	 * 상담현황 목록 건 수 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#selectCnslTodayLogListCnt(java.util.Map)
	*/
	@Override
	public int selectCnslTodayLogListCnt(Map<String, Object> parameter) throws Exception {
		return cnslMgntDAO.selectCnslTodayLogListCnt(parameter);
	}

	/**
	 * 상담이력 목록(팝업)을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#selectCnslLogMgmtList(java.util.Map)
	*/
	@Override
	public RecordSet selectCnslLogMgmtList(Map<String, Object> parameter) throws Exception {
		return cnslMgntDAO.selectCnslLogMgmtList(parameter);
	}

	/**
	 * SMS이력 목록을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#selectSmsLogList(java.util.Map)
	*/
	@Override
	public RecordSet selectSmsLogList(Map<String, Object> parameter) throws Exception {
		return cnslMgntDAO.selectSmsLogList(parameter);
	}

	/**
	 * 미처리현황 목록 건 수 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#selectCnslUntreatLogCnt(java.util.Map)
	*/
	@Override
	public int selectCnslUntreatLogCnt(Map<String, Object> parameter) throws Exception {
		return cnslMgntDAO.selectCnslUntreatLogCnt(parameter);
	}

	/**
	 * 사업장 목록(팝업) 을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#selectCnslMgmtCustInQueryList(java.util.Map)
	*/
	@Override
	public RecordSet selectCnslMgmtCustInQueryList(Map<String, Object> parameter) throws SQLException {
		if ( "RING".equals(parameter.get("flag")) ) {
			return cnslMgntDAO.selectCnslMgmtCustInQueryList2(parameter);
		} else {
			return cnslMgntDAO.selectCnslMgmtCustInQueryList(parameter);
		}
		
	}

	/**
	 * 상담평가이력 목록(팝업)을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#selectCnslAllLogList(java.util.Map)
	*/
	@Override
	public RecordSet selectCnslAllLogList(Map<String, Object> parameter) throws Exception {
		return cnslMgntDAO.selectCnslAllLogList(parameter);
	}

	/**
	 * 상담평가이력의 평가내용, 평가점수을(를) 저장한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#insertCnslEvalSave(hone.online.xplatform.map.DataSetMap)
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int insertCnslEvalSave(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += cnslMgntDAO.insertCnslEval(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += cnslMgntDAO.updateCnslEval(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += cnslMgntDAO.deleteCnslEval(rowData);
			}
		}
		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * 고객 발신번호로 조회 시 건 수 조회
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#searchUpjangCnt(hone.online.xplatform.map.DataSetMap)
	*/
	@Override
	public int searchUpjangCnt(Map<String, Object> parameter) throws Exception {
		int searchUpjangCnt = cnslMgntDAO.searchUpjangCnt(parameter);

		return searchUpjangCnt;
	}

	/**
	 * 업장에 속해있는 담당자/영양사 목록을 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#selectFmsUpjangCust(java.util.Map)
	*/
	@Override
	public RecordSet selectFmsUpjangCust(Map<String, Object> parameter) throws Exception {
		return cnslMgntDAO.selectFmsUpjangCust(parameter);
	}

	/**
	 * 내부사용자 목록 조회 한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#selectjikWonList(java.util.Map)
	*/
	@Override
	public RecordSet selectjikWonList(Map<String, Object> parameter) throws Exception {
		return cnslMgntDAO.selectjikWonList(parameter);
	}

	@Override
	public RecordSet selectCSList(Map<String, Object> parameter) throws Exception {
		return cnslMgntDAO.selectCSList(parameter);
	}
	
	/**
	 * 상담이력 통계 현황 목록 조회 한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#selectCnslHistoryStcsList(java.util.Map)
	*/
	@Override
	public RecordSet selectCnslHistoryStcsList(Map<String, Object> parameter) throws Exception {
		return cnslMgntDAO.selectCnslHistoryStcsList(parameter);
	}

	/**
	 * 협력업체 목록 조회 한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#selectVendor(java.util.Map)
	*/
	@Override
	public RecordSet selectVendor(Map<String, Object> parameter) throws Exception {
		return cnslMgntDAO.selectVendor(parameter);
	}

	/**
	 * 협력업체에 따른 담당자 목록 조회 한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#selectVendorMgmt(java.util.Map)
	*/
	@Override
	public RecordSet selectVendorMgmt(Map<String, Object> parameter) throws Exception {
		return cnslMgntDAO.selectVendorMgmt(parameter);
	}

	/**
	 * 주요내용 또는 상담내용을 수정한다. 
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.cs.ccs.service.CnslMgntService#updateContents(hone.online.xplatform.map.DataSetMap)
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int updateContents(DataSetMap parameter) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		for (int i = 0; i < parameter.size(); i++) {
			Map<String, Object> rowData = parameter.get(i);
			int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += cnslMgntDAO.updateContents(rowData);
			}
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += cnslMgntDAO.updateContents(rowData);
			}
		}
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
