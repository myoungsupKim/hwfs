package com.hwfs.sc.sca.web;

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
import com.hwfs.sc.sca.service.AuthMappingMgmtService;

/**
 * 권한을 부여하는 AuthMappingMgmt Controller
 *
 * @ClassName AuthMappingMgmtController.java
 * @Description AuthMappingMgmtController Class
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
@Controller
@RequestMapping("/sc/sca/authMappingMgmt/")
public class AuthMappingMgmtController extends DefaultController {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** AuthMappingMgmtService Bean 생성 */
	@Resource(name = "/sc/sca/authMappingMgmtService")
	private AuthMappingMgmtService authMappingMgmtService;

	/**
	 * 권한 부여 목록을 조회한다.
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
	@SuppressWarnings("unchecked")
	@RequestMapping("selectAuthList.xdo")
	public ModelAndView selectAuthList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		// Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> inDs = xpDTO.getInDataSetMap();

		// 권한 부여 을(를) 조회한다.
		RecordSet rs = authMappingMgmtService.selectAuthList(inDs.get(
				"ds_search").get(0));

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_authList", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 선택된 권한에 따른 부서목록(미등록,등록)을 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectAuthDeptList.xdo")
	public ModelAndView selectAuthDeptList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();
		// Map<String, DataSetMap> inDs = xpDTO.getInDataSetMap();

		// 권한 부여 을(를) 조회한다.
		Map<String, RecordSet> rtn = authMappingMgmtService
				.selectAuthDeptList(inVar);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_authDept_UnCcMapList", rtn.get("UnCcMap"));
		super.addOutDataSet(mav, "ds_authDept_CcMapList", rtn.get("CcMap"));

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 권한 부여 목록을 조회한다.
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
	@SuppressWarnings("unchecked")
	@RequestMapping("selectDeptAuthCcList.xdo")
	public ModelAndView selectDeptAuthCcList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		// Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> inDs = xpDTO.getInDataSetMap();

		// 권한 부여 을(를) 조회한다.
		RecordSet rs = authMappingMgmtService.selectDeptAuthCcList(inDs.get(
				"ds_search").get(0));

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_deptAuth_ccList", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 선택된 CC에 따른 권한목록(미등록,등록)을 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectDeptAuthList.xdo")
	public ModelAndView selectDeptAuthList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();
		// Map<String, DataSetMap> inDs = xpDTO.getInDataSetMap();

		// 권한 부여 을(를) 조회한다.
		Map<String, RecordSet> rtn = authMappingMgmtService
				.selectDeptAuthList(inVar);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_deptAuth_UnAuthMapList",
				rtn.get("UnAuthMap"));
		super.addOutDataSet(mav, "ds_deptAuth_AuthMapList", rtn.get("AuthMap"));

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 권한 부여(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveDeptRoleList.xdo")
	public ModelAndView saveDeptRoleList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_deptRole");

		// 권한 부여을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = authMappingMgmtService.saveDeptRoleList(parameter);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 선택된 권한에 따른 등록/미등록 사용자 군을 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectAuthCustList.xdo")
	public ModelAndView selectAuthCustList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();
		// Map<String, DataSetMap> inDs = xpDTO.getInDataSetMap();

		// 권한 부여 을(를) 조회한다.
		Map<String, RecordSet> rtn = authMappingMgmtService
				.selectAuthCustList(inVar);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_authCust_UnCustMapList",
				rtn.get("UnCustMap"));
		super.addOutDataSet(mav, "ds_authCust_CustMapList", rtn.get("CustMap"));

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 권한 부여(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveUserGroupRoleList.xdo")
	public ModelAndView saveUserGroupRoleList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_userGroupRole");

		// 권한 부여을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = authMappingMgmtService
				.saveUserGroupRoleList(parameter);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 사용자군 목록을 조회한다.
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
	@SuppressWarnings("unchecked")
	@RequestMapping("selectCustAuthUserGroupList.xdo")
	public ModelAndView selectCustAuthUserGroupList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		// Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> inDs = xpDTO.getInDataSetMap();

		// 권한 부여 을(를) 조회한다.
		RecordSet rs = authMappingMgmtService.selectCustAuthUserGroupList(inDs
				.get("ds_search").get(0));

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_custAuth_userGroupList", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 선택된 CC에 따른 권한목록(미등록,등록)을 조회한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectCustAuthList.xdo")
	public ModelAndView selectCustAuthList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// 조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();
		// Map<String, DataSetMap> inDs = xpDTO.getInDataSetMap();

		// 권한 부여 을(를) 조회한다.
		Map<String, RecordSet> rtn = authMappingMgmtService
				.selectCustAuthList(inVar);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_custAuth_UnAuthMapList",
				rtn.get("UnAuthMap"));
		super.addOutDataSet(mav, "ds_custAuth_AuthMapList", rtn.get("AuthMap"));

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
