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
import com.hwfs.sc.sca.dao.AuthMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 권한그룹을 관리한다.
 *
 * @ClassName AuthMgmtServiceImpl.java
 * @Description AuthMgmtServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 29.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 1. 29.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/sca/authMgmtService")
public class AuthMgmtServiceImpl extends DefaultServiceImpl implements
		AuthMgmtService {

	@Resource(name = "/sc/sca/authMgmtDAO")
	private AuthMgmtDAO authMgmt;

	//권한변경 이력에 대한 서비스
	@Resource(name="/sc/cmn/authorityChangeLogService")
	AuthorityChangeLogService authChgLog;
	/**
	 * 조건에 맞는 권한그룹을 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.sca.service.AuthMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return authMgmt.selectList(parameter);
	}

	/**
	 * 신규/변경/삭제에 대한 권한그룹을 처리한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.sca.service.AuthMgmtService#saveList(hone.online.xplatform.map.DataSetMap)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public int saveList(DataSetMap parameter) throws Exception {
		int procCnt = 0;

		AuthorityChangeLogDTO dto = new AuthorityChangeLogDTO();

		for (int i = 0; i < parameter.size(); i++) {
			Map<String, Object> rowData = parameter.get(i);
			int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			dto.setSccRoleChgLog(rowData);

			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += authMgmt.insertList(rowData);

				//이력을 생성한다.
				dto.setChgFact("NEW_ROLE");
				authChgLog.createLog(AuthorityTable.SCC_ROLE, dto);
			} else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				procCnt += authMgmt.updateList(rowData);

				//이력을 생성한다.
				dto.setChgFact("CHG_ROLE");
				authChgLog.createLog(AuthorityTable.SCC_ROLE, dto);
			} else if (rowType == DataSet.ROW_TYPE_DELETED) {
				procCnt += authMgmt.deleteList(rowData);
				authMgmt.deleteUserRole(rowData);
				authMgmt.deleteDeptRole(rowData);
				authMgmt.deleteUgrpRole(rowData);
				//이력을 생성한다.
				dto.setChgFact("DEL_ROLE");
				authChgLog.createLog(AuthorityTable.SCC_ROLE, dto);
			}
		}

		return procCnt;
	}

}
