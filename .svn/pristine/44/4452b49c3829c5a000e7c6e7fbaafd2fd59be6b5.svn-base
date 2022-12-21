package com.hwfs.sc.scu.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.sc.scu.dao.UserIdRequestDAO;

/**
 * 사용자 계정(ID)를 신청하는 UserIdRequest Service Implementation
 *
 * @ClassName UserIdRequestServiceImpl.java
 * @Description UserIdRequestServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.29    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.06.29
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scu/userIdRequestService")
public class UserIdRequestServiceImpl extends DefaultServiceImpl implements
		UserIdRequestService {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** UserIdRequestDAO Bean 생성 */
	@Resource(name = "/sc/scu/userIdRequestDAO")
	private UserIdRequestDAO userIdRequestDAO;

	@Resource(name = "scUserInfoCsSabunSeqGenSequence")
	private SequenceIdGenService scUserInfoCsSabunSeqGenSequence;

	/**
	 * 사용자 계정(ID) 목록을 조회한다.
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
		return userIdRequestDAO.selectList(mapParam);
	}

	/**
	 * 사용자 계정(ID) 목록을 조회한다.
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
	public RecordSet selectUserCheck(Map<String, Object> mapParam)
			throws Exception {
		return userIdRequestDAO.selectUserCheck(mapParam);
	}

	/**
	 * 사용자 계정(ID) DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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

		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);

			if ("NEW".equals(rowData.get("requestCd"))) {
				rowData.put("sabun", scUserInfoCsSabunSeqGenSequence.getNextStringId());
				userIdRequestDAO.insertUserInfo(rowData);
				
				if (rowData.containsKey("userAuthLevel") && !"".equals(rowData.get("userAuthLevel").toString())) {
					userIdRequestDAO.deleteAuthLevel(rowData);
					userIdRequestDAO.insertAuthLevel(rowData);
				}
				
			} else if ("STOP".equals(rowData.get("requestCd"))) {
				rowData.put("acctLkReasonCd", "ACCOUNT_STOP");
				userIdRequestDAO.updateUserInfo(rowData);
			} else if ("STOP_CANCEL".equals(rowData.get("requestCd"))) {
				userIdRequestDAO.updateUserInfo(rowData);
			}

			insRowCnt += userIdRequestDAO.insert(rowData);
		}

		return insRowCnt + updRowCnt + delRowCnt;
	}
}
