package com.hwfs.sc.sca.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dto.AuthorityChangeLogDTO;
import com.hwfs.sc.cmn.service.AuthorityChangeLogService;
import com.hwfs.sc.cmn.util.Const.AuthorityTable;
import com.hwfs.sc.sca.dao.AuthByMenuMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 권한별 메뉴를 관리하는 AuthByMenuMgmt Service Implementation
 *
 * @ClassName AuthByMenuMgmtServiceImpl.java
 * @Description AuthByMenuMgmtServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.16    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.16
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/sca/authByMenuMgmtService")
public class AuthByMenuMgmtServiceImpl extends DefaultServiceImpl implements
		AuthByMenuMgmtService {

	/** LogService */
	// private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** AuthByMenuMgmtDAO Bean 생성 */
	@Resource(name = "/sc/sca/authByMenuMgmtDAO")
	private AuthByMenuMgmtDAO authByMenuMgmtDAO;

	//권한변경 이력에 대한 서비스
	@Resource(name="/sc/cmn/authorityChangeLogService")
	AuthorityChangeLogService authChgLog;

	/**
	 * 특정시스템에서 사용하는 권한 목록을 조회한다.
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
	public RecordSet selectRoleList(Map<String, Object> mapParam)
			throws Exception {
		return authByMenuMgmtDAO.selectRoleList(mapParam);
	}

	/**
	 * 권한별 메뉴 목록(미등록)을 조회한다.
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
	public RecordSet selectMenuList(Map<String, Object> mapParam)
			throws Exception {
		return authByMenuMgmtDAO.selectMenuList(mapParam);
	}

	/**
	 * 권한별 메뉴 목록(등록)을 조회한다.
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
	public RecordSet selectRoleMenuList(Map<String, Object> mapParam)
			throws Exception {
		return authByMenuMgmtDAO.selectRoleMenuList(mapParam);
	}

	/**
	 * 권한별 메뉴 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		// 삭제가 완료된 이후에 추가 및 저장을 처리한다.
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer) rowData
					.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// Delete 처리
			if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += authByMenuMgmtDAO.delete(rowData);
			}
		}

		// 삭제가 완료된 이후에 추가 및 저장을 처리한다.
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer) rowData
					.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			// Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += authByMenuMgmtDAO.insert(rowData);
			}
			// Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += authByMenuMgmtDAO.update(rowData);
			}
		}

		//로그를 기록한다.
		AuthorityChangeLogDTO dto = new AuthorityChangeLogDTO();

		if (list.getInsRowMaps().size() > 0) {
			dto.setChgFact("NEW_MENU");
			dto.setSccRoleMenuChgLog(list.getInsRowMaps());

			authChgLog.createLog(AuthorityTable.SCC_ROLE_MENU, dto);
		}

		if (list.getUpdRowMaps().size() > 0) {
			dto.setChgFact("CHG_MENU");
			dto.setSccRoleMenuChgLog(list.getUpdRowMaps());

			authChgLog.createLog(AuthorityTable.SCC_ROLE_MENU, dto);
		}

		if (list.getDelRowMaps().size() > 0) {
			dto.setChgFact("DEL_MENU");
			dto.setSccRoleMenuChgLog(list.getDelRowMaps());

			authChgLog.createLog(AuthorityTable.SCC_ROLE_MENU, dto);
		}

		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * 기 등록된 메뉴를 가져온다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectGetMenuList(Map<String, Object> mapParam)
			throws Exception {
		return authByMenuMgmtDAO.selectGetMenuList(mapParam);
	}
}
