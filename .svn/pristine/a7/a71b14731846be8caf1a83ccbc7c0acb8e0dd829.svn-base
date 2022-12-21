package com.hwfs.sc.scu.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scu.dao.UserIdReqListDAO;

 /**
 * 사용자ID 신청현황을 관리하는 UserIdReqList Service Implementation
 *
 * @ClassName UserIdReqListServiceImpl.java
 * @Description UserIdReqListServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.01    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.01
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scu/userIdReqListService")
public class UserIdReqListServiceImpl extends DefaultServiceImpl implements UserIdReqListService {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UserIdReqListDAO Bean 생성 */
	@Resource(name = "/sc/scu/userIdReqListDAO")
	private UserIdReqListDAO userIdReqListDAO;


	/**
	 * 사용자ID 신청현황 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return userIdReqListDAO.selectList(mapParam);
	}

	/**
	 * 사용자ID 신청현황 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet
	 *            조회결과
	 * @throws Exception
	 */
	public Map<String, RecordSet> selectAuthList(Map<String, Object> mapParam) throws Exception {
		Map<String, RecordSet> rtn = new HashMap<String, RecordSet>();

		rtn.put("UserGroupAuth", userIdReqListDAO.selectUserGroupAuthList(mapParam));
		rtn.put("UserAuth", userIdReqListDAO.selectUserAuthList(mapParam));
		rtn.put("BoardAuth", userIdReqListDAO.selectBoardAuthList(mapParam));

		return rtn;
	}

	/**
	 * 사용자ID 신청현황 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int save(DataSetMap master, DataSetMap list, DataSetMap listBbsAuth) throws Exception {
		int transRowCnt = 0;

		//권한정보를 생성한다.
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);

			if ("1".equals(rowData.get("chk").toString())) {
				transRowCnt += userIdReqListDAO.insertUserAuth(rowData);
			}
		}
		
		//사용자게시판권한정보를 생성한다.
		for (int i = 0 ; i < listBbsAuth.size() ; i++) {
			Map<String, Object> rowData = listBbsAuth.get(i);
			
			//신규
			if ("1".equals(rowData.get("incUserRole").toString())  && "0".equals(rowData.get("oldIncUserRole").toString())) {
				userIdReqListDAO.insertBbsAuth(rowData);
			}
			else if ("0".equals(rowData.get("incUserRole").toString())  && "1".equals(rowData.get("oldIncUserRole").toString())) {
				userIdReqListDAO.deleteBbsAuth(rowData);
			}
		}

		//사용자정보 갱신
		transRowCnt += userIdReqListDAO.updateUserInfo(master.get(0));

		//사용자권한레벨
		userIdReqListDAO.deleteAuthLevel(master.get(0));
		userIdReqListDAO.insertAuthLevel(master.get(0));
		
		//사용자ID 요청정보 갱신
		transRowCnt += userIdReqListDAO.update(master.get(0));

		return transRowCnt;
	}

	/**
	 * 사용자id 중단을 처리한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scu.service.UserIdReqListService#saveStop(java.util.Map)
	*/
	public int saveStop(Map<String, Object> parameter) throws Exception {
		int transRowCnt = 0;

		//사용자정보 갱신
		transRowCnt += userIdReqListDAO.updateStopUserInfo(parameter);

		//사용자ID 요청정보 갱신
		transRowCnt += userIdReqListDAO.update(parameter);

		//사용자 권한제거
		transRowCnt += userIdReqListDAO.deleteUserAuth(parameter);

		//사용자 예외권한제거
		transRowCnt += userIdReqListDAO.deleteUserMenu(parameter);

		return transRowCnt;
	}

	public int saveReturn(Map<String, Object> parameter) throws Exception {
		int transRowCnt = 0;

		Map<String, Object> status = new HashMap<String, Object>();
		status.put("sabun", parameter.get("sabun"));

		if ("NEW".equals(parameter.get("requestCd").toString())) {
			status.put("useYn", "N");
			status.put("acctStatus", "RETURN");
		}
		else if ("STOP".equals(parameter.get("requestCd").toString())) {
			status.put("useYn", "Y");
			status.put("acctStatus", "NORMAL");
		}
		else if ("STOP_CANCEL".equals(parameter.get("requestCd").toString())) {
			status.put("useYn", "N");
			status.put("acctStatus", "RETURN");
		}

		//사용자정보 갱신
		transRowCnt += userIdReqListDAO.updateReturnUserInfo(status);

		//사용자ID 요청정보 갱신
		transRowCnt += userIdReqListDAO.updateReturn(parameter);

		return transRowCnt;
	}
}
