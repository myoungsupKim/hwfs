package com.hwfs.sc.scu.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.sc.scu.dao.UserIdReqDAO;

/**
 * 사용자 계정을 신청하는 UserIdReq Service Implementation
 *
 * @ClassName UserIdReqServiceImpl.java
 * @Description UserIdReqServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.31    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.31
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scu/userIdReqService")
public class UserIdReqServiceImpl extends DefaultServiceImpl implements
		UserIdReqService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** UserIdReqDAO Bean 생성 */
	@Resource(name = "/sc/scu/userIdReqDAO")
	private UserIdReqDAO userIdReqDAO;

	@Resource(name = "scUserInfoCsSabunSeqGenSequence")
	private SequenceIdGenService scUserInfoCsSabunSeqGenSequence;

	/**
	 * 사용자ID를 검사한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scu.service.UserIdReqService#selectExistsUserId(java.util.Map)
	 */
	public int selectExistsUserId(Map<String, Object> mapParam)
			throws Exception {
		return userIdReqDAO.selectExistsUserId(mapParam);
	}

	/**
	 * 사용자 정보 목록을 조회한다.
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
		return userIdReqDAO.selectList(mapParam);
	}

	/**
	 * 사용자 정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public Map<String, Object> saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String sabun = "";
		Map<String, Object> rtn = new HashMap<String, Object>();

		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);

			if ("NEW".equals(rowData.get("requestCd").toString())) {
				sabun = scUserInfoCsSabunSeqGenSequence.getNextStringId()
						.trim();
				rowData.put("sabun", sabun);

				userIdReqDAO.insertUserInfo(rowData);
				insRowCnt += userIdReqDAO.insert(rowData);

				logger.debug("-----------------------------------------------------------------------------------------------------------------");
				logger.debug("신 규 신 청");
				logger.debug("사번 : " + sabun);
				logger.debug("-----------------------------------------------------------------------------------------------------------------");
			} else if ("STOP".equals(rowData.get("requestCd").toString())) {
				sabun = rowData.get("sabun").toString();
				logger.debug("-----------------------------------------------------------------------------------------------------------------");
				logger.debug("중 단 신 청");
				logger.debug("-----------------------------------------------------------------------------------------------------------------");

				userIdReqDAO.updateUserInfo(rowData);
				insRowCnt += userIdReqDAO.insert(rowData);
			} else if ("STOP_CANCEL".equals(rowData.get("requestCd").toString())) {
				sabun = rowData.get("sabun").toString();
				logger.debug("-----------------------------------------------------------------------------------------------------------------");
				logger.debug("중 단 해 제");
				logger.debug("-----------------------------------------------------------------------------------------------------------------");

				userIdReqDAO.updateUserInfo(rowData);
				insRowCnt += userIdReqDAO.insert(rowData);
			}
		}

		rtn.put("sabun", sabun);
		rtn.put("procCnt", insRowCnt + updRowCnt + delRowCnt);

		return rtn;
	}
}
