package com.hwfs.sc.scu.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.cmn.util.StringUtil;
import com.hwfs.sc.cmn.dao.PersChgDAO;
import com.hwfs.sc.cmn.dto.AuthorityChangeLogDTO;
import com.hwfs.sc.cmn.dto.SmsDTO;
import com.hwfs.sc.cmn.service.AuthorityChangeLogService;
import com.hwfs.sc.cmn.service.SmsSendService;
import com.hwfs.sc.cmn.util.Const.AuthorityTable;
import com.hwfs.sc.scu.dao.UserMngtDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 사용자를 관리하는 UserMngt Service Implementation
 *
 * @ClassName UserMngtServiceImpl.java
 * @Description UserMngtServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.27    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.27
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scu/userMngtService")
public class UserMngtServiceImpl extends DefaultServiceImpl implements
		UserMngtService {

	/** LogService */
	// private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** UserMngtDAO Bean 생성 */
	@Resource(name = "/sc/scu/userMngtDAO")
	private UserMngtDAO userMngtDAO;
	
	/** PersChgDAO Bean 생성 */
	@Resource(name = "/sc/cmn/persChgDAO")
	private PersChgDAO persChgDAO;
	
	@Resource(name = "scUserInfoCsSabunSeqGenSequence")
	private SequenceIdGenService scUserInfoCsSabunSeqGenSequence;

	//권한변경 이력에 대한 서비스
	@Resource(name="/sc/cmn/authorityChangeLogService")
	AuthorityChangeLogService authChgLog;

	/** SmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/smsSendService")
	private SmsSendService smsSendService;
	
	/**
	 * 등록된 사용자가 있는지 확인한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectExistsUser(Map<String, Object> mapParam)
			throws Exception {
		return userMngtDAO.selectExistsUser(mapParam);
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
	public RecordSet selectAuthLevelList(Map<String, Object> mapParam)
			throws Exception {
		return userMngtDAO.selectAuthLevelList(mapParam);
	}

	/**
	 * 사용자 정보와 사용자권한레벨을 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scu.service.UserMngtService#select(java.util.Map)
	 */
	public Map<String, Object> select(Map<String, Object> mapParam)
			throws Exception {

		Map<String, Object> rtn = new HashMap<String, Object>();

		rtn.put("master", userMngtDAO.select(mapParam));
		rtn.put("authLevel", userMngtDAO.selectAuthLevelList(mapParam));
		rtn.put("loginHis", userMngtDAO.selectLoginHistory(mapParam));
		//rtn.put("changeHistory", userMngtDAO.selectHistory(mapParam));

		return rtn;
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
	public Map<String, Object> selectHist(Map<String, Object> mapParam)
			throws Exception {

		Map<String, Object> rtn = new HashMap<String, Object>();
		rtn.put("changeHistory", userMngtDAO.selectHistory(mapParam));

		return rtn;
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
	public Map<String, String> save(DataSetMap list, DataSetMap authLevelList) throws Exception {
//		int insRowCnt = 0;
//		int updRowCnt = 0;
//		int delRowCnt = 0;
		String sabun = "";
		String pwd = "NONE";

		// 사용자 정보를 처리한다.
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer) rowData
					.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {

				if (rowData.containsKey("userType") && "외부".equals(rowData.get("userType"))) {
					rowData.put("sabun", scUserInfoCsSabunSeqGenSequence.getNextStringId());
					Random r = new Random();
					r.setSeed(new Date().getTime());
					pwd = String.valueOf(Math.abs(r.nextLong() / 6));
					
					if (pwd.length() > 6) {
						pwd = pwd.substring(0, 6);
					}
					
					rowData.put("password", pwd);
				}
				else {
					pwd = rowData.get("sabun").toString();
					rowData.put("password", pwd);
				}

				userMngtDAO.insert(rowData);
			}
			// Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				userMngtDAO.update(rowData);
			}
			// Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				userMngtDAO.delete(rowData);
			}

			sabun = rowData.get("sabun").toString();

			if (rowData.containsKey("authlevel") && !"".equals(rowData.get("authlevel").toString())) {
				userMngtDAO.deleteAuthLevel(rowData);
				userMngtDAO.insertAuthLevel(rowData);
			}

		}

		// 사용자 권한레벨 정보를 처리한다.
/*
		for (int i = 0; i < authLevelList.size(); i++) {
			Map<String, Object> rowData = authLevelList.get(i);
			// int rowType =
			// ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			rowData.put("sabun", sabun);
			// 등록
			if ("1".equals(rowData.get("chk").toString())
					&& "0".equals(rowData.get("oldChk"))) {
				userMngtDAO.insertAuthLevel(rowData);
			}
			// 제거
			else if ("0".equals(rowData.get("chk").toString())
					&& "1".equals(rowData.get("oldChk"))) {
				userMngtDAO.deleteAuthLevel(rowData);
			}
		}
*/
		Map<String, String> rtn = new HashMap<String, String>();
		rtn.put("sabun", sabun);
		rtn.put("pwd", pwd);

		return rtn;
	}

	/**
	 * 사용자의 권한을 조회한다.(미등록/등록)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scu.service.UserMngtService#select(java.util.Map)
	 */
	public Map<String, Object> selectUserAuth(Map<String, Object> mapParam)
			throws Exception {

		Map<String, Object> rtn = new HashMap<String, Object>();

		rtn.put("UnUserAuth", userMngtDAO.selectUnUserAuth(mapParam));
		rtn.put("UserAuth", userMngtDAO.selectUserAuth(mapParam));

		return rtn;
	}

	/**
	 * 사용자권한정보를 처리한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scu.service.UserMngtService#saveUserAuth(hone.online.xplatform.map.DataSetMap)
	 */
	@SuppressWarnings("unchecked")
	public int saveUserAuth(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		// 사용자 정보를 처리한다.
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer) rowData
					.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += userMngtDAO.insertUserAuth(rowData);
			}
			// Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += userMngtDAO.updateUserAuth(rowData);
			}
			// Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += userMngtDAO.deleteUserAuth(rowData);
			}
		}

		//로그를 기록한다.
		AuthorityChangeLogDTO dto = new AuthorityChangeLogDTO();

		if (list.getInsRowMaps().size() > 0) {
			dto.setChgFact("NEW_ROLE");
			dto.setSabun(list.getInsRowMaps().get(0).get("sabun").toString());
			dto.setSccUserRoleChgLog(list.getInsRowMaps());
			authChgLog.createLog(AuthorityTable.SCC_USER_ROLE, dto);
		}

		if (list.getUpdRowMaps().size() > 0) {
			dto.setChgFact("CHG_ROLE");
			dto.setSabun(list.getUpdRowMaps().get(0).get("sabun").toString());
			dto.setSccUserRoleChgLog(list.getUpdRowMaps());
			authChgLog.createLog(AuthorityTable.SCC_USER_ROLE, dto);
		}

		if (list.getDelRowMaps().size() > 0) {
			dto.setChgFact("DEL_ROLE");
			dto.setSabun(list.getDelRowMaps().get(0).get("sabun").toString());
			dto.setSccUserRoleChgLog(list.getDelRowMaps());

			authChgLog.createLog(AuthorityTable.SCC_USER_ROLE, dto);
		}
		
		
		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * 사용자 예외권한 정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scu.service.UserMngtService#selectExptAuthList(java.util.Map)
	 */
	public RecordSet selectExptAuthList(Map<String, Object> mapParam)
			throws Exception {
		return userMngtDAO.selectExptAuthList(mapParam);
	}

	/**
	 * 사용자 예외권한정보를 처리한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scu.service.UserMngtService#saveExptAuth(hone.online.xplatform.map.DataSetMap)
	 */
	@SuppressWarnings("unchecked")
	public int saveExptAuth(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		// 사용자 정보를 처리한다.
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			
			AuthorityChangeLogDTO dto = new AuthorityChangeLogDTO();
			
			// 추가
			if ("0".equals(rowData.get("uMenuId").toString())) {
				insRowCnt += userMngtDAO.insertExptAuth(rowData);
				
				dto.setChgFact("NEW_MENU");
				dto.setSabun(rowData.get("sabun").toString());
				dto.setSccUserMenuChgLog(rowData);
				authChgLog.createLog(AuthorityTable.SCC_USER_MENU, dto);
				
			} else {
				// 삭제
				if ("1".equals(rowData.get("chk").toString())) {
					delRowCnt += userMngtDAO.deleteExptAuth(rowData);

					dto.setChgFact("DEL_MENU");
					dto.setSabun(rowData.get("sabun").toString());
					dto.setSccUserMenuChgLog(rowData);
					authChgLog.createLog(AuthorityTable.SCC_USER_MENU, dto);
				}
				// 수정
				else {
					updRowCnt += userMngtDAO.updateExptAuth(rowData);

					dto.setChgFact("CHG_MENU");
					dto.setSabun(rowData.get("sabun").toString());
					dto.setSccUserMenuChgLog(rowData);
					authChgLog.createLog(AuthorityTable.SCC_USER_MENU, dto);
				}
			}
		}

		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * 사용자의 게시판 권한을 조회한다.(미등록/등록)
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scu.service.UserMngtService#select(java.util.Map)
	 */
	public Map<String, Object> selectBbsAuthList(Map<String, Object> mapParam)
			throws Exception {

		Map<String, Object> rtn = new HashMap<String, Object>();

		rtn.put("UnBbsAuth", userMngtDAO.selectUnBbsAuthList(mapParam));
		rtn.put("BbsAuth", userMngtDAO.selectBbsAuthList(mapParam));

		return rtn;
	}

	/**
	 * 게시판 권한정보를 처리한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scu.service.UserMngtService#saveBbsAuth(hone.online.xplatform.map.DataSetMap)
	 */
	@SuppressWarnings("unchecked")
	public int saveBbsAuth(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		// 게시판 권한정보를 처리한다.
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer) rowData
					.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += userMngtDAO.insertBbsAuth(rowData);
			}
			// Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += userMngtDAO.updateBbsAuth(rowData);
			}
			// Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += userMngtDAO.deleteBbsAuth(rowData);
			}
		}

		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * 복수업장을 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scu.service.UserMngtService#selectDualUpjang(java.util.Map)
	 */
	public RecordSet selectDualUpjang(Map<String, Object> mapParam)
			throws Exception {
		return userMngtDAO.selectDualUpjang(mapParam);
	}

	/**
	 * 복수업장을 처리한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scu.service.UserMngtService#saveDualUpjang(hone.online.xplatform.map.DataSetMap)
	 */
	@SuppressWarnings("unchecked")
	public int saveDualUpjang(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		// 게시판 권한정보를 처리한다.
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer) rowData
					.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				try {
					insRowCnt += userMngtDAO.insertDualUpjang(rowData);
				}
				catch (Exception ept) {
					throw new BizException("이미 등록된 업장입니다.\n화면의 [항상 사용중인 업장만 조회]의 체크를 해제하여 주세요.");
				}
			}
			// Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += userMngtDAO.updateDualUpjang(rowData);
			}
			// Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += userMngtDAO.deleteDualUpjang(rowData);
			}
		}

		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * saveUnLock 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param master
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scu.service.UserMngtService#saveUnLock(hone.online.xplatform.map.DataSetMap)
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int saveUnLock(DataSetMap master) throws Exception {
		Map<String, Object> mapParam = master.get(0);
		return userMngtDAO.updateUnLock(mapParam);
	}

	public String saveClearPwd(Map<String, Object> parameter) throws Exception {
		String pwd = "";

		if ("내부".equals(parameter.get("userType").toString())) {
			pwd = parameter.get("sabun").toString();
		}
		else {
			
			RecordSet rr = userMngtDAO.selectRandom(parameter);
			
			pwd = rr.get(0).getString("rdmNum");
		}

		parameter.put("pwd", pwd);

		userMngtDAO.updatePwd(parameter);
		
		if ( "외부".equals(parameter.get("userType").toString()) ) {
			RecordSet rs = persChgDAO.selectUserSms(parameter);
			String sabun = rs.get(0).getString("sabun");
			String pNum = rs.get(0).getString("hpNo");
			String callback = rs.get(0).getString("csNo");
			
			if ( !StringUtil.isNull(pNum) ) {
				if ( pNum.startsWith("010") ) {
					List<SmsDTO> smsList = new ArrayList<SmsDTO>();
					SmsDTO smsDTO = new SmsDTO();
					smsDTO.setTrPhone(pNum);	//수신자 전화번호
					String strMsg = "[푸디스트] 초기화 비밀번호는 "+ pwd + " 입니다.";
					smsDTO.setTrMsg(strMsg);			//전송 메시지
					
					if ( callback.length() < 10 ) {
						callback = propertiesService.getString("ems.sms.callback.no", "");
					}
					
					smsDTO.setTrCallback(callback);
					smsDTO.setTrDeptId("316830");		// 식재사업기획팀
					smsDTO.setTrCcId("316830");			// 식재사업기획팀
					smsDTO.setTrUserId(sabun);
					smsDTO.setTrCustNo("");				
					
					smsList.add(smsDTO);
					
					smsSendService.saveSms(smsList);
				}
			}
		}
		
		return pwd;
	}

}
