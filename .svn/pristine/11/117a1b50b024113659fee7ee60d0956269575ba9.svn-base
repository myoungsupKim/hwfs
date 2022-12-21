package com.hwfs.sc.scu.web;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.sc.scc.service.ParameterLogService;
import com.hwfs.sc.scu.service.UserMngtService;

/**
 * 사용자를 관리하는 UserMngt Controller
 *
 * @ClassName UserMngtController.java
 * @Description UserMngtController Class
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
@Controller
@RequestMapping("/sc/scu/userMngt/")
public class UserMngtController extends DefaultController {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** UserMngtService Bean 생성 */
	@Resource(name = "/sc/scu/userMngtService")
	private UserMngtService userMngtService;

	@Resource(name="/sc/scc/parameterLogService")
	private ParameterLogService parameterLog;

	/**
	 * 선택된 사원에 대한 중복여부를 확인한다.
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectExistsUser.xdo")
	public ModelAndView selectExistsUser(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(selectExistsUser)", inVar.toString());

		// 사용자 정보 을(를) 조회한다.
		RecordSet rs = userMngtService.selectExistsUser(inVar);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_userExistsCnt", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 사용자 정보 목록을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectAuthLevelList.xdo")
	public ModelAndView selectAuthLevelList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(selectAuthLevelList)", inVar.toString());

		// 사용자 정보 을(를) 조회한다.
		RecordSet rs = userMngtService.selectAuthLevelList(inVar);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_authLevel", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 사용자 변경이력 목록을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectChangeHist.xdo")
	public ModelAndView selectChangeHist(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(select)", inVar.toString());

		// 사용자 정보 을(를) 조회한다.
		Map<String, Object> rtn = userMngtService.selectHist(inVar);

		RecordSet rsChangeHistory = (RecordSet) rtn.get("changeHistory");

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_changeHistory", rsChangeHistory);
			    
		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 사용자 정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("select.xdo")
	public ModelAndView select(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(select)", inVar.toString());

		// 사용자 정보 을(를) 조회한다.
		Map<String, Object> rtn = userMngtService.select(inVar);

		Record r = (Record) rtn.get("master");
		RecordSet rs = (RecordSet) rtn.get("authLevel");
		RecordSet rsHis = (RecordSet) rtn.get("loginHis");
		//RecordSet rsChangeHistory = (RecordSet) rtn.get("changeHistory");

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_master", r);
		super.addOutDataSet(mav, "ds_authLevel", rs);
		super.addOutDataSet(mav, "ds_loginHistory", rsHis);
		//super.addOutDataSet(mav, "ds_changeHistory", rsChangeHistory);

		//개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
	    accessLogService.readLog(inVar, r.size());
	    
		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 사용자 정보(을)를 Insert/Update/Delete 처리한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("save.xdo")
	public ModelAndView save(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap master = param.get("ds_master");
		DataSetMap authLevel = param.get("ds_authLevel");

		//개인정보보호 접근로그를 쌓는다. 
		accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"TEL_NO_ENC, HP_NO_ENC, EMAIL_ENC"}));
		
		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(save-master)", master);
		parameterLog.setLog(logKey, "사용자관리(save-authLevel)", authLevel);

		// 사용자 정보을(를) 등록, 수정, 삭제 처리한다.
		Map<String, String> rtn = userMngtService.save(master, authLevel);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_sabun", rtn.get("sabun"));
		super.addOutVariable(mav, "fv_pwd", rtn.get("pwd"));

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 사원자 권한정보(등록/미등록)를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectUserAuth.xdo")
	public ModelAndView selectUserAuth(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(selectUserAuth)", inVar.toString());

		// 사용자 정보 을(를) 조회한다.
		Map<String, Object> rtn = userMngtService.selectUserAuth(inVar);

		RecordSet rsUnUserAuth = (RecordSet) rtn.get("UnUserAuth");
		RecordSet rsUserAuth = (RecordSet) rtn.get("UserAuth");

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_unUserAuth", rsUnUserAuth);
		super.addOutDataSet(mav, "ds_userAuth", rsUserAuth);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 사용자 권한정보(을)를 Insert/Update/Delete 처리한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveUserAuth.xdo")
	public ModelAndView saveUserAuth(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap list = param.get("ds_userAuth");

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(saveUserAuth)", list);

		// 사용자 정보을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = userMngtService.saveUserAuth(list);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 사용자 예외권한정보를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectExptAuthList.xdo")
	public ModelAndView selectExptAuthList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(selectExptAuthList)", inVar.toString());

		// 사용자 예외권한정보 을(를) 조회한다.
		RecordSet rs = userMngtService.selectExptAuthList(inVar);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_exptAuth", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 사용자 권한정보(을)를 Insert/Update/Delete 처리한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveExptAuth.xdo")
	public ModelAndView saveExptAuth(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap list = param.get("ds_exptAuth");

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(saveExptAuth)", list);

		// 사용자 정보을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = userMngtService.saveExptAuth(list);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 사원자 게시판 권한정보(등록/미등록)를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectBbsAuthList.xdo")
	public ModelAndView selectBbsAuthList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(selectBbsAuthList)", inVar.toString());

		// 사용자 정보 을(를) 조회한다.
		Map<String, Object> rtn = userMngtService.selectBbsAuthList(inVar);

		RecordSet rsUnBbsAuth = (RecordSet) rtn.get("UnBbsAuth");
		RecordSet rsBbsAuth = (RecordSet) rtn.get("BbsAuth");

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_unBbsAuth", rsUnBbsAuth);
		super.addOutDataSet(mav, "ds_bbsAuth", rsBbsAuth);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 사용자 권한정보(을)를 Insert/Update/Delete 처리한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveBbsAuth.xdo")
	public ModelAndView saveBbsAuth(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap list = param.get("ds_bbsAuth");

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(saveBbsAuth)", list);

		// 사용자 정보을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = userMngtService.saveBbsAuth(list);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 사원자 게시판 권한정보(등록/미등록)를 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectDualUpjang.xdo")
	public ModelAndView selectDualUpjang(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(selectDualUpjang)", inVar.toString());

		// 사용자 정보 을(를) 조회한다.
		RecordSet rs = userMngtService.selectDualUpjang(inVar);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_dualUpjang", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 사용자 권한정보(을)를 Insert/Update/Delete 처리한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveDualUpjang.xdo")
	public ModelAndView saveDualUpjang(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap list = param.get("ds_dualUpjang");

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(saveDualUpjang)", list);

		// 사용자 정보을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = userMngtService.saveDualUpjang(list);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@RequestMapping("saveUnLock.xdo")
	public ModelAndView saveUnLock(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap list = param.get("ds_master");

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(saveUnLock)", list);

		// 사용자 정보을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = userMngtService.saveUnLock(list);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@RequestMapping("saveClearPwd.xdo")
	public ModelAndView saveClearPwd(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, Object> param = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자관리(saveClearPwd)", param.toString());

		// 사용자 정보을(를) 등록, 수정, 삭제 처리한다.
		String pwd = userMngtService.saveClearPwd(param);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_ClearPwd", pwd);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
