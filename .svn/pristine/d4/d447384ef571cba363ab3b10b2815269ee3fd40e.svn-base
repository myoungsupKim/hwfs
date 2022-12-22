package com.hwfs.sc.scz.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.CustInchargeService;
import com.hwfs.sc.scc.service.ParameterLogService;
import com.hwfs.sc.scz.service.CustMgmtService;


 /**
 * 거래처 정보를 관리하는 CustMgmt Controller
 *
 * @ClassName CustMgmtController.java
 * @Description CustMgmtController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 :  COM 김재섭
 * @since 2015.04.17
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scz/custMgmt/")
public class CustMgmtController extends DefaultController {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CustMgmtService Bean 생성 */
	@Resource(name = "/sc/scz/custMgmtService")
	private CustMgmtService custMgmtService;

	@Resource(name="/sc/cmn/custInchargeService")
	private CustInchargeService custInchargeService;

	@Resource(name="/sc/scc/parameterLogService")
	private ParameterLogService parameterLog;

	
	/**
	 * 거래처 정보 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> parameter = param.get("ds_search").get(0);
		parameter.put("maskAuth", inVar.get("maskAuth"));

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "거래처관리(selectList)", parameter.toString());
		
		//거래처 정보 을(를) 조회한다.
		RecordSet rs = custMgmtService.selectList(parameter);

		//개인정보보호 접근로그를 쌓는다.
		accessLogService.readLog(inVar, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 거래처 정보 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectInchargeList.xdo")
	public ModelAndView selectInchargeList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "거래처관리(selectInchargeList)", inVar.toString());

		//거래처 정보 을(를) 조회한다.
		RecordSet rs = custInchargeService.selectList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_inchargeList", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 거래처에 대한 정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectCustInfo.xdo")
	public ModelAndView selectCustInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("custcd", inVar.get("custcd"));
		parameter.put("maskAuth", inVar.get("maskAuth"));

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "거래처관리(selectCustInfo)", parameter.toString());

		//거래처 정보 을(를) 조회한다.
		Map<String, RecordSet> rtn = custMgmtService.selectCustInfo(parameter);
		RecordSet rs = rtn.get("inchargeList");
		
		//개인정보보호 접근로그를 쌓는다.
		accessLogService.readLog(inVar, rs.size());

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_inchargeList", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * Full사업자번호에 대하여 거래처정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectCustCheckList.xdo")
	public ModelAndView selectCustCheckList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("fullBsnNo", inVar.get("fullBsnNo"));
		parameter.put("maskAuth", inVar.get("maskAuth"));

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "거래처관리(selectCustCheckList)", parameter.toString());

		//거래처 정보 을(를) 조회한다.
		Map<String, RecordSet> rtn = custMgmtService.selectCheckCust(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_custCheckList", rtn.get("custInfo"));
		super.addOutDataSet(mav, "ds_hlevelCust", rtn.get("hlevelCust"));

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 거래처 정보(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		//Map<String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter1 = param.get("ds_list");
		DataSetMap parameter2 = param.get("ds_inchargeList");

		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		//개인정보보호 접근로그를 쌓는다. 
		accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"ID_NO_ENC, CEO_ID_NO_ENC, TEL_NUM_ENC, HAND_PHONE_ENC, EMAIL_ADDR_ENC"}));

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "거래처관리(saveList-parameter1)", parameter1);
		parameterLog.setLog(logKey, "거래처관리(saveList-parameter2)", parameter2);

		//거래처 정보을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> rtn = custMgmtService.saveList(parameter1, parameter2, loginDTO.getSabun(), loginDTO.getMuCd()); //, parameter2, inVar);
		int processCnt = Integer.parseInt(rtn.get("procCnt").toString());

		if (rtn.get("custList") != null)
		{
			RecordSet rs = (RecordSet)rtn.get("custList");

			//XPlatform으로 넘겨줄 Dataset을 설정한다.
			super.addOutDataSet(mav, "ds_list", rs);
		}

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 거래처 AddrKey의 중복 여부를 체크한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("searchAddrCnt.xdo")
	public ModelAndView searchAddrCnt(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("addrKey", inVar.get("addrKey"));

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "거래처관리(searchAddrCnt)", parameter.toString());

		//거래처 정보 을(를) 조회한다.
		Map<String, RecordSet> rtn = custMgmtService.searchAddrCnt(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_addrCnt", rtn.get("addrKey"));
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		
	}

}
