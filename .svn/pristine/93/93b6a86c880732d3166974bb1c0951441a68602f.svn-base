package com.hwfs.sc.sca.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dto.AuthorityChangeLogDTO;
import com.hwfs.sc.cmn.service.AuthorityChangeLogService;
import com.hwfs.sc.cmn.util.Const.AuthorityTable;
import com.hwfs.sc.sca.dao.AuthMappingMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 권한을 부여하는 AuthMappingMgmt Service Implementation
 *
 * @ClassName AuthMappingMgmtServiceImpl.java
 * @Description AuthMappingMgmtServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.17    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.17
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/sca/authMappingMgmtService")
public class AuthMappingMgmtServiceImpl extends DefaultServiceImpl implements
		AuthMappingMgmtService {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** AuthMappingMgmtDAO Bean 생성 */
	@Resource(name = "/sc/sca/authMappingMgmtDAO")
	private AuthMappingMgmtDAO authMappingMgmtDAO;

	//권한변경 이력에 대한 서비스
	@Resource(name="/sc/cmn/authorityChangeLogService")
	AuthorityChangeLogService authChgLog;

	/**
	 * 권한 목록을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectAuthList(Map<String, Object> mapParam)
			throws Exception {
		return authMappingMgmtDAO.selectAuthList(mapParam);
	}

	/**
	 * 권한 목록을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public Map<String, RecordSet> selectAuthDeptList(
			Map<String, Object> mapParam) throws Exception {

		Map<String, RecordSet> rtn = new HashMap<String, RecordSet>();

		rtn.put("UnCcMap",
				authMappingMgmtDAO.selectAuthDeptUnCcMapList(mapParam));
		rtn.put("CcMap", authMappingMgmtDAO.selectAuthDeptCcMapList(mapParam));

		return rtn;
	}

	/**
	 * 권한 목록을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectDeptAuthCcList(Map<String, Object> mapParam)
			throws Exception {
		return authMappingMgmtDAO.selectDeptAuthCcList(mapParam);
	}

	/**
	 * 미등록 권한목록과 등록된 권한목록을 조회한다.(CC별 권한관리)
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public Map<String, RecordSet> selectDeptAuthList(
			Map<String, Object> mapParam) throws Exception {

		Map<String, RecordSet> rtn = new HashMap<String, RecordSet>();

		rtn.put("UnAuthMap",
				authMappingMgmtDAO.selectDeptAuthUnAuthMapList(mapParam));
		rtn.put("AuthMap",
				authMappingMgmtDAO.selectDeptAuthAuthMapList(mapParam));

		return rtn;
	}

	/**
	 * 권한 부여 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
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
	public int saveDeptRoleList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer) rowData
					.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += authMappingMgmtDAO.insertDeptRole(rowData);
			}
			// Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += authMappingMgmtDAO.updateDeptRole(rowData);
			}
			// Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += authMappingMgmtDAO.deleteDeptRole(rowData);
			}
		}

		//로그를 기록한다.
		AuthorityChangeLogDTO dto = new AuthorityChangeLogDTO();

		if (list.getInsRowMaps().size() > 0) {
			dto.setChgFact("NEW_DEPT");
			dto.setSccDeptRoleChgLog(list.getInsRowMaps());

			authChgLog.createLog(AuthorityTable.SCC_DEPT_ROLE, dto);
		}

		if (list.getUpdRowMaps().size() > 0) {
			dto.setChgFact("CHG_DEPT");
			dto.setSccDeptRoleChgLog(list.getUpdRowMaps());

			authChgLog.createLog(AuthorityTable.SCC_DEPT_ROLE, dto);
		}

		if (list.getDelRowMaps().size() > 0) {
			dto.setChgFact("DEL_DEPT");
			dto.setSccDeptRoleChgLog(list.getDelRowMaps());

			authChgLog.createLog(AuthorityTable.SCC_DEPT_ROLE, dto);
		}


		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * 권한별 사용자군관리에서 등록 사용자군과 미등록 사용자군을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public Map<String, RecordSet> selectAuthCustList(
			Map<String, Object> mapParam) throws Exception {

		Map<String, RecordSet> rtn = new HashMap<String, RecordSet>();

		rtn.put("UnCustMap",
				authMappingMgmtDAO.selectAuthCustUnCustMapList(mapParam));
		rtn.put("CustMap",
				authMappingMgmtDAO.selectAuthCustCustMapList(mapParam));

		return rtn;
	}

	/**
	 * 권한 부여 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
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
	public int saveUserGroupRoleList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer) rowData
					.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += authMappingMgmtDAO.insertUserGroupRole(rowData);
			}
			// Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += authMappingMgmtDAO.updateUserGroupRole(rowData);
			}
			// Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += authMappingMgmtDAO.deleteUserGroupRole(rowData);
			}
		}

		//로그를 기록한다.
		AuthorityChangeLogDTO dto = new AuthorityChangeLogDTO();

		if (list.getInsRowMaps().size() > 0) {
			dto.setChgFact("NEW_USER_GROUP");
			dto.setSccUserGroupRoleChgLog(list.getInsRowMaps());

			authChgLog.createLog(AuthorityTable.SCC_USER_GROUP_ROLE, dto);
		}

		if (list.getUpdRowMaps().size() > 0) {
			dto.setChgFact("CHG_USER_GROUP");
			dto.setSccUserGroupRoleChgLog(list.getUpdRowMaps());

			authChgLog.createLog(AuthorityTable.SCC_USER_GROUP_ROLE, dto);
		}

		if (list.getDelRowMaps().size() > 0) {
			dto.setChgFact("DEL_USER_GROUP");
			dto.setSccUserGroupRoleChgLog(list.getDelRowMaps());

			authChgLog.createLog(AuthorityTable.SCC_USER_GROUP_ROLE, dto);
		}

		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * 사용자군 목록을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectCustAuthUserGroupList(Map<String, Object> mapParam)
			throws Exception {
		return authMappingMgmtDAO.selectCustAuthUserGroupList(mapParam);
	}

	/**
	 * 미등록 권한목록과 등록된 권한목록을 조회한다.(사용자군별 권한관리)
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public Map<String, RecordSet> selectCustAuthList(
			Map<String, Object> mapParam) throws Exception {

		Map<String, RecordSet> rtn = new HashMap<String, RecordSet>();

		rtn.put("UnAuthMap",
				authMappingMgmtDAO.selectCustAuthUnAuthMapList(mapParam));
		rtn.put("AuthMap",
				authMappingMgmtDAO.selectCustAuthAuthMapList(mapParam));

		return rtn;
	}
}
