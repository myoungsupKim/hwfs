package com.hwfs.cs.ccs.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cs.ccs.service.CnslMgntService;

/**
 * 상담 관리하는 CnslMgmt Controller
 * 
 * @ClassName CnslMgmtController.java
 * @Description CnslMgmtController Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.12    이규훈        최초생성
 * </pre>
 * @author FC종합전산구축 : 상담관리 이규훈
 * @since 2015.03.12
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/cs/ccs/cnslMgnt/")
public class CnslMgmtController extends DefaultController {

	/** LogService */
	// private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CnslMgntService Bean 생성 */
	@Resource(name = "/cs/ccs/cnslMgntService")
	private CnslMgntService cnslMgntService;

	/**
	 * 상담을 저장한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("insertCnslSave.xdo")
	public ModelAndView insertCnslSave(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_ccsCnslSave");

		// TODO 접수자 임시 지정 - agent027
		//parameter.get(0).put("loginSabun", "200701952");

		// 상담내용을 저장한다.
		int processCnt = cnslMgntService.insertCnslSave(parameter);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 상담현황 목록을 조회한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectCnslTodayLogList.xdo")
	public ModelAndView selectCnslTodayLogList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
			HttpServletRequest req) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//TODO 로그인한 사용자 정보를 파라미터로 받아서 처리해야함.
		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		//Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		// Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = new HashMap<String, Object>();

		//TODO 접수자 임시 지정 - agent027
		//parameter.put("loginSabun", "200701952");

		// 로그인한 사용자 정보 조회한다.
		// LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		// parameter.put("acceptUser", loginDTO.getUserid());

		// 상담현황 목록을(를) 조회한다.
		RecordSet rs = cnslMgntService.selectCnslTodayLogList(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_toDayLogList", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 상담현황, 미처리현황 목록 건 수 조회한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectCnslTodayLogCnt.xdo")
	public ModelAndView selectCnslTodayLogListCnt(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
			HttpServletRequest req) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//TODO 로그인한 사용자 정보를 파라미터로 받아서 처리해야함.
		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		// Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_user").get(0);

		//TODO 접수자 임시 지정 - agent027
		//parameter.put("loginSabun", "200701952");

		// 상담현황 목록 건 수 조회한다.
		int toDaycnt = cnslMgntService.selectCnslTodayLogListCnt(parameter);
		// 미처리현황 목록 건 수 조회한다.
		int unTreatcnt = cnslMgntService.selectCnslUntreatLogCnt(parameter);

		// XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_toDayLogCnt", toDaycnt);
		super.addOutVariable(mav, "fv_unTreatLogCnt", unTreatcnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 미처리현황 목록을 조회한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectCnslUntreatLogList.xdo")
	public ModelAndView selectCnslUntreatLogList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
			HttpServletRequest req) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//TODO 로그인한 사용자 정보를 파라미터로 받아서 처리해야함.
		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		//Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		// Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = new HashMap<String, Object>();

		//TODO 접수자 임시 지정 - agent027
		//parameter.put("loginSabun", "200701952");

		// 로그인한 사용자 정보 조회한다.
		// LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		// parameter.put("acceptUser", loginDTO.getUserid());

		// 미처리현황 목록을(를) 조회한다.
		RecordSet rs = cnslMgntService.selectCnslUntreatLogList(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_unTreatLogList", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 미처리현황 목록에서 '처리상태'가 '처리중'->'처리완료' 업데이트한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("updateProcessComplete.xdo")
	public ModelAndView updateProcessComplete(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_updateProcessComplete");

		//parameter.get(0).put("loginSabun", "200701952");

		// 미처리현황 목록을 수정 처리한다.
		int processCnt = cnslMgntService.updateProcessComplete(parameter);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 상담이력, SMS 이력 목록을 조회한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectCnslLogList.xdo")
	public ModelAndView selectCnslLogList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		// Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);

		// 상담이력 목록을(를) 조회한다.
		RecordSet rs = cnslMgntService.selectCnslLogList(parameter);

		// SMS 이력 목록을(를) 조회한다.
		RecordSet rsSms = cnslMgntService.selectSmsLogList(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_ccsCnslLog", rs);
		super.addOutDataSet(mav, "ds_smsLog", rsSms);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 상담이력 목록을 조회한다.(팝업)
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectCnslLogMgmtList.xdo")
	public ModelAndView selectCnslLogMgmtList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		// 상담이력 목록(팝업)을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = cnslMgntService.selectCnslLogMgmtList(parameter.get("ds_search").get(0));

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_ccsCnslLog", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 사업장 목록을 조회한다.(팝업)
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectCnslMgmtCustInQueryList.xdo")
	public ModelAndView selectCnslMgmtCustInQueryList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		// Dataset에서 첫번째 행의 정보만 추출한다.
		@SuppressWarnings("unchecked")
		Map<String, Object> parameter = param.get("ds_search").get(0);

		// 상담이력 목록(팝업)을(를) 조회한다.
		RecordSet rs = cnslMgntService.selectCnslMgmtCustInQueryList(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_fmsUpjang", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 상담평가이력 목록을 조회한다.(팝업)
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectCnslAllLogList.xdo")
	public ModelAndView selectCnslAllLogList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		// 상담이력 목록(팝업)을(를) 조회한다.
		RecordSet rs = cnslMgntService.selectCnslAllLogList(parameter.get("ds_search").get(0));

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_ccsCnslAllLog", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 상담평가이력의 평가내용, 평가점수을(를) 저장한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("saveCnslEval.xdo")
	public ModelAndView saveCnslEval(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_ccsCnslAllLog");

		// TODO 접수자, 평가자 임시 지정 
		//parameter.get(0).put("loginSabun", "200701952");
		//parameter.get(0).put("evalUser", "200701952");

		// 상담내용을 저장한다.
		int processCnt = cnslMgntService.insertCnslEvalSave(parameter);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 고객 발신번호로 조회 시 건 수 조회
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("searchUpjangCnt.xdo")
	public ModelAndView searchUpjangCnt(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_search");

		// 상담내용을 저장한다.
		int processCnt = cnslMgntService.searchUpjangCnt(parameter.get(0));

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_custTelno", processCnt);
		super.addOutVariable(mav, "fv_partTelNo", parameter.get(0).get("partTelNo"));
		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 업장에 속해있는 담당자/영양사 목록을 조회한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectFmsUpjangCust.xdo")
	public ModelAndView selectFmsUpjangCust(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		// Dataset에서 첫번째 행의 정보만 추출한다.
		@SuppressWarnings("unchecked")
		Map<String, Object> parameter = param.get("ds_search").get(0);

		// 상담이력 목록(팝업)을(를) 조회한다.
		RecordSet rs = cnslMgntService.selectFmsUpjangCust(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_fmsUpjangCust", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 내부사용자 목록 조회 한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectjikWonList.xdo")
	public ModelAndView selectjikWonList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		// Dataset에서 첫번째 행의 정보만 추출한다.
		@SuppressWarnings("unchecked")
		Map<String, Object> parameter = param.get("ds_search").get(0);

		// 상담이력 목록(팝업)을(를) 조회한다.
		RecordSet rs = cnslMgntService.selectjikWonList(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_jikWonList", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@RequestMapping("selectCSList.xdo")
	public ModelAndView selectCSList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		// Dataset에서 첫번째 행의 정보만 추출한다.
		@SuppressWarnings("unchecked")
		Map<String, Object> parameter = param.get("ds_search").get(0);

		// 상담이력 목록(팝업)을(를) 조회한다.
		RecordSet rs = cnslMgntService.selectCSList(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 상담이력 통계 현황 목록 조회 한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectCnslHistoryStcsList.xdo")
	public ModelAndView selectCnslHistoryStcsList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		// Dataset에서 첫번째 행의 정보만 추출한다.
		@SuppressWarnings("unchecked")
		Map<String, Object> parameter = param.get("ds_search").get(0);

		// 상담이력 목록(팝업)을(를) 조회한다.
		RecordSet rs = cnslMgntService.selectCnslHistoryStcsList(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_historyStsc", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 협력업체 목록 조회 한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectVendor.xdo")
	public ModelAndView selectVendor(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		// Dataset에서 첫번째 행의 정보만 추출한다.
		@SuppressWarnings("unchecked")
		Map<String, Object> parameter = param.get("ds_searchVendor").get(0);

		// 협력업체 목록을(를) 조회한다.
		RecordSet rs = cnslMgntService.selectVendor(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_vendor", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 협력업체에 따른 담당자 목록 조회 한다.
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectVendorMgmt.xdo")
	public ModelAndView selectVendorMgmt(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		// Dataset에서 첫번째 행의 정보만 추출한다.
		@SuppressWarnings("unchecked")
		Map<String, Object> parameter = param.get("ds_searchVendor").get(0);

		// 협력업체에 따른 담당자 목록을(를) 조회한다.
		RecordSet rs = cnslMgntService.selectVendorMgmt(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_vendorMgmt", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주요내용 또는 상담내용을 수정한다. 
	 * 
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("updateContents.xdo")
	public ModelAndView updateContents(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_contents");

		// 주요내용 또는 상담내용을 수정한다.
		int processCnt = cnslMgntService.updateContents(parameter);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
