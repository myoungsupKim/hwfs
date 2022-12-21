package com.hwfs.sc.scu.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dto.AuthorityChangeLogDTO;
import com.hwfs.sc.cmn.service.AuthorityChangeLogService;
import com.hwfs.sc.cmn.util.Const.AuthorityTable;
import com.hwfs.sc.scu.dao.UserRoleGrantDAO;

/**
 * 사용자 권한을 부여하는 UserRoleGrant Service Implementation
 *
 * @ClassName UserRoleGrantServiceImpl.java
 * @Description UserRoleGrantServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.25    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.25
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scu/userRoleGrantService")
public class UserRoleGrantServiceImpl extends DefaultServiceImpl implements
		UserRoleGrantService {

	/** LogService */
	// private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** UserRoleGrantDAO Bean 생성 */
	@Resource(name = "/sc/scu/userRoleGrantDAO")
	private UserRoleGrantDAO userRoleGrantDAO;

	// 권한변경 이력에 대한 서비스
	@Resource(name = "/sc/cmn/authorityChangeLogService")
	AuthorityChangeLogService authChgLog;

	/**
	 * 권한부여 목록을 조회한다.
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
	public Map<String, Object> selectList(Map<String, Object> mapParam)
			throws Exception {

		Map<String, Object> rtn = new HashMap<String, Object>();

		rtn.put("userInfo", userRoleGrantDAO.selectUserInfo(mapParam));
		rtn.put("userAuth", userRoleGrantDAO.selectUserAuthList(mapParam));

		return rtn;
	}

	/**
	 * 권한부여 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(String chgSrlnum, String sabun, DataSetMap list,
			Map<String, Object> userInfo) throws Exception {
		//int insRowCnt = 0;
		int updRowCnt = 0;
		//int delRowCnt = 0;

		List<Map<String, Object>> insUserRole = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> delUserRole = new ArrayList<Map<String, Object>>();

		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);

			rowData.put("sabun", sabun);

			// 신규
			if ("0".equals(rowData.get("oldRoleChk").toString())
					&& "1".equals(rowData.get("chk").toString())) {
				userRoleGrantDAO.insert(rowData);
				insUserRole.add(rowData);
			}
			// 제거
			else if ("1".equals(rowData.get("oldRoleChk").toString())
					&& "0".equals(rowData.get("chk").toString())) {
				// 변경로그 기록
				// authChngHistService.insertUserRoleChgLog(rowData);

				userRoleGrantDAO.delete(rowData);
				delUserRole.add(rowData);
			}
		}

		// 사용자의 정보를 갱신한다.
		userRoleGrantDAO.updateUserInfo(userInfo);

		// 상태값을 수정한다.
		Map<String, Object> updParam = new HashMap<String, Object>();
		updParam.put("chgSrlnum", chgSrlnum);
		updRowCnt = userRoleGrantDAO.update(updParam);

		// 로그를 기록한다.
		AuthorityChangeLogDTO dto = new AuthorityChangeLogDTO();
		dto.setSabun(sabun);

		// 부서에 대한 권한 로그
		if ("Y".equals(userInfo.get("deptAuthApplyYn").toString())
				&& "N".equals(userInfo.get("oldDeptAuthApplyYn"))) {
			// 신규부서 권한 추가됨.
			RecordSet rs = userRoleGrantDAO.selectDeptAuthList(userInfo);

			dto.setChgFact("NEW_REQ_DEPT");
			dto.setSccDeptRoleChgLog(convertRecordSetToList(rs));

			authChgLog.createLog(AuthorityTable.SCC_DEPT_ROLE, dto);
		} else if ("N".equals(userInfo.get("deptAuthApplyYn").toString())
				&& "Y".equals(userInfo.get("oldDeptAuthApplyYn"))) {
			// 기존부서 권한 제거됨.
			RecordSet rs = userRoleGrantDAO.selectDeptAuthList(userInfo);

			dto.setChgFact("DEL_REQ_DEPT");
			dto.setSccDeptRoleChgLog(convertRecordSetToList(rs));

			authChgLog.createLog(AuthorityTable.SCC_DEPT_ROLE, dto);
		} else if (("Y".equals(userInfo.get("deptAuthApplyYn").toString()) && "Y"
				.equals(userInfo.get("oldDeptAuthApplyYn")))
				&& (!userInfo.get("upjang").toString()
						.equals(userInfo.get("oldUpjang").toString()))) {
			// 부서가 변경됨.
			RecordSet rs = userRoleGrantDAO.selectDeptAuthList(userInfo);

			dto.setChgFact("CHG_REQ_DEPT");
			dto.setSccDeptRoleChgLog(convertRecordSetToList(rs));

			authChgLog.createLog(AuthorityTable.SCC_DEPT_ROLE, dto);
		}

		// 사용자군에 대한 권한 로그
		if ("Y".equals(userInfo.get("userGroupAuthApplyYn").toString())
				&& "N".equals(userInfo.get("oldUserGroupAuthApplyYn"))) {
			// 신규 사용자군 권한 추가됨.
			RecordSet rs = userRoleGrantDAO.selectUserGroupAuthList(userInfo);

			dto.setChgFact("NEW_REQ_USERGROUP");
			dto.setSccUserGroupRoleChgLog(convertRecordSetToList(rs));

			authChgLog.createLog(AuthorityTable.SCC_USER_GROUP_ROLE, dto);
		} else if ("N".equals(userInfo.get("userGroupAuthApplyYn").toString())
				&& "Y".equals(userInfo.get("oldUserGroupAuthApplyYn"))) {
			// 기존 사용자군 권한 제거됨.
			RecordSet rs = userRoleGrantDAO.selectUserGroupAuthList(userInfo);

			dto.setChgFact("DEL_REQ_USERGROUP");
			dto.setSccUserGroupRoleChgLog(convertRecordSetToList(rs));

			authChgLog.createLog(AuthorityTable.SCC_USER_GROUP_ROLE, dto);
		} else if (("Y".equals(userInfo.get("userGroupAuthApplyYn").toString()) && "Y"
				.equals(userInfo.get("oldUserGroupAuthApplyYn")))
				&& (!userInfo.get("userGroup").toString()
						.equals(userInfo.get("oldUserGroup").toString()))) {
			// 사용자군이 변경됨.
			RecordSet rs = userRoleGrantDAO.selectUserGroupAuthList(userInfo);

			dto.setChgFact("CHG_REQ_USERGROUP");
			dto.setSccUserGroupRoleChgLog(convertRecordSetToList(rs));

			authChgLog.createLog(AuthorityTable.SCC_USER_GROUP_ROLE, dto);
		}

		// 사용자 권한 로그
		if (insUserRole.size() > 0) {
			dto.setChgFact("NEW_REQ_USER");
			dto.setSccUserRoleChgLog(insUserRole);

			authChgLog.createLog(AuthorityTable.SCC_USER_ROLE, dto);
		}

		if (delUserRole.size() > 0) {
			dto.setChgFact("DEL_REQ_USER");
			dto.setSccUserRoleChgLog(delUserRole);

			authChgLog.createLog(AuthorityTable.SCC_USER_ROLE, dto);
		}

		return updRowCnt;
	}

	/**
	 * RecordSet을 List<Map<String, Object>>로 변환
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param recordSet
	 * @return
	 */
	private List<Map<String, Object>> convertRecordSetToList(RecordSet recordSet) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		for (int i = 0; i < recordSet.size(); i++) {
			Record r = recordSet.get(i);

			Set<String> keySet = r.keySet();
			Iterator<String> keys = keySet.iterator();
			Map<String, Object> map1 = new HashMap<String, Object>();

			while (keys.hasNext()) {
				String key = keys.next().toString();
				map1.put(key, r.get(key));
			}

			list.add(map1);
		}

		return list;
	}
}
