package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.sc.cmn.dao.AuthorityChangeLogDAO;
import com.hwfs.sc.cmn.dto.AuthorityChangeLogDTO;
import com.hwfs.sc.cmn.util.Const.AuthorityTable;

/**
 * 권한의 변경 이력을 생성하는 AuthorityChangeLog Service Implementation
 *
 * @ClassName AuthorityChangeLogServiceImpl.java
 * @Description AuthorityChangeLogServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.18    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.18
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/authorityChangeLogService")
public class AuthorityChangeLogServiceImpl extends DefaultServiceImpl implements
		AuthorityChangeLogService {

	/** AuthorityChangeLogDAO Bean 생성 */
	@Resource(name = "/sc/cmn/authorityChangeLogDAO")
	private AuthorityChangeLogDAO authorityChangeLogDAO;

	@Resource(name = "sccAuthChgLogSeqGenSequence")
	private SequenceIdGenService sccAuthChgLogSeqGenSequence;

	/**
	 * 권한 변경 이력 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return authorityChangeLogDAO.selectList(mapParam);
	}

	/**
	 * 권한 변경 이력을 생성한다.
	 *
	 * @param changeLog
	 *            이력 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	public Map<String, Object> createLog(int authoriyTable,
			AuthorityChangeLogDTO changeLog) throws Exception {

		Map<String, Object> parameter = new HashMap<String, Object>();
		Map<String, Object> rtn = new HashMap<String, Object>();

		parameter.put("chgFact", changeLog.getChgFact());

		switch (authoriyTable) {
		case AuthorityTable.SCC_ROLE:
			parameter.put("chgTable", "SCC_ROLE");
			break;
		case AuthorityTable.SCC_DEPT_ROLE:
			parameter.put("chgTable", "SCC_DEPT_ROLE");
			break;
		case AuthorityTable.SCC_ROLE_MENU:
			parameter.put("chgTable", "SCC_ROLE_MENU");
			break;
		case AuthorityTable.SCC_USER_GROUP_ROLE:
			parameter.put("chgTable", "SCC_USER_GROUP_ROLE");
			break;
		case AuthorityTable.SCC_USER_MENU:
			parameter.put("chgTable", "SCC_USER_MENU");
			break;
		case AuthorityTable.SCC_USER_ROLE:
			parameter.put("chgTable", "SCC_USER_ROLE");
			break;
		default :
			break;
		}

		rtn = createLog(parameter);

		switch (authoriyTable) {
		case AuthorityTable.SCC_ROLE:
			Map<String, Object> sccRole = changeLog.getSccRoleChgLog();
			sccRole.put("mgmtNum", rtn.get("mgmtNum"));

			authorityChangeLogDAO.insertRoleChangeLog(sccRole);
			break;
		case AuthorityTable.SCC_DEPT_ROLE:
			// 사원번호가 존재하면 사용에 따른 부서의 권한의 변경이 있을때...
			if (!"".equals(changeLog.getSabun())) {
				Map<String, Object> userChangeLog = new HashMap<String, Object>();
				userChangeLog.put("mgmtNum", rtn.get("mgmtNum"));
				userChangeLog.put("sabun", changeLog.getSabun());

				authorityChangeLogDAO.insertUserChangeLog(userChangeLog);
			}

			List<Map<String, Object>> deptRolelist = changeLog
					.getSccDeptRoleChgLog();

			for (int i = 0; i < deptRolelist.size(); i++) {
				Map<String, Object> sccDeptRole = deptRolelist.get(i);
				sccDeptRole.put("mgmtNum", rtn.get("mgmtNum"));

				authorityChangeLogDAO.insertDeptRoleChangeLog(sccDeptRole);
			}

			break;
		case AuthorityTable.SCC_ROLE_MENU:
			List<Map<String, Object>> roleMenulist = changeLog
					.getSccRoleMenuChgLog();

			for (int i = 0; i < roleMenulist.size(); i++) {
				Map<String, Object> sccRoleMenu = roleMenulist.get(i);
				sccRoleMenu.put("mgmtNum", rtn.get("mgmtNum"));

				authorityChangeLogDAO.insertRoleMenuChangeLog(sccRoleMenu);
			}
			break;
		case AuthorityTable.SCC_USER_GROUP_ROLE:
			// 사원번호가 존재하면 사용에 따른 부서의 권한의 변경이 있을때...
			if (!"".equals(changeLog.getSabun())) {
				Map<String, Object> userChangeLog = new HashMap<String, Object>();
				userChangeLog.put("mgmtNum", rtn.get("mgmtNum"));
				userChangeLog.put("sabun", changeLog.getSabun());

				authorityChangeLogDAO.insertUserChangeLog(userChangeLog);
			}

			List<Map<String, Object>> userGroupRolelist = changeLog
					.getSccUserGroupRoleChgLog();

			for (int i = 0; i < userGroupRolelist.size(); i++) {
				Map<String, Object> sccUserGroupRole = userGroupRolelist.get(i);
				sccUserGroupRole.put("mgmtNum", rtn.get("mgmtNum"));

				authorityChangeLogDAO
						.insertUserGroupRoleChangeLog(sccUserGroupRole);
			}
			break;
		case AuthorityTable.SCC_USER_MENU:
			Map<String, Object> sccUserMenu = changeLog.getSccUserMenuChgLog();
			sccUserMenu.put("mgmtNum", rtn.get("mgmtNum"));
			
			Map<String, Object> usermMenuChangeLog = new HashMap<String, Object>();
			usermMenuChangeLog.put("mgmtNum", rtn.get("mgmtNum"));
			usermMenuChangeLog.put("sabun", changeLog.getSabun());

			authorityChangeLogDAO.insertUserChangeLog(usermMenuChangeLog);

			authorityChangeLogDAO.insertUserMenuChangeLog(sccUserMenu);
			break;
		case AuthorityTable.SCC_USER_ROLE:
			List<Map<String, Object>> userRolelist = changeLog
					.getSccUserRoleChgLog();
			Map<String, Object> userChangeLog = new HashMap<String, Object>();
			userChangeLog.put("mgmtNum", rtn.get("mgmtNum"));
			userChangeLog.put("sabun", changeLog.getSabun());

			authorityChangeLogDAO.insertUserChangeLog(userChangeLog);

			for (int i = 0; i < userRolelist.size(); i++) {
				Map<String, Object> sccUserRole = userRolelist.get(i);
				sccUserRole.put("mgmtNum", rtn.get("mgmtNum"));

				authorityChangeLogDAO.insertUserRoleChangeLog(sccUserRole);
			}

			break;
		default :
			break;
		}

		return rtn;
	}

	private Map<String, Object> createLog(Map<String, Object> changeLog)
			throws Exception {
		Map<String, Object> rtn = new HashMap<String, Object>();

		changeLog.put("mgmtNum", sccAuthChgLogSeqGenSequence.getNextStringId()
				.trim());

		rtn.put("mgmtNum", changeLog.get("mgmtNum"));
		rtn.put("procCnt", authorityChangeLogDAO.insertChangeLog(changeLog));

		return rtn;
	}

}
