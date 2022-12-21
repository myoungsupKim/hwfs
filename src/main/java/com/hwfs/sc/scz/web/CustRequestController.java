package com.hwfs.sc.scz.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.scc.service.ParameterLogService;
import com.hwfs.sc.scz.service.CustRequestService;


 /**
 * 거래처를 신청하는 CustRequest Controller
 *
 * @ClassName CustRequestController.java
 * @Description CustRequestController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 :  COM 김재섭
 * @since 2015.04.29
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scz/custRequest/")
public class CustRequestController extends DefaultController {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CustRequestService Bean 생성 */
	@Resource(name = "/sc/scz/custRequestService")
	private CustRequestService custRequestService;

	@Resource(name="/sc/scc/parameterLogService")
	private ParameterLogService parameterLog;
	
	/**
	 * 거래처 신청정보 목록을 조회한다.
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
		//Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> param = xpDTO.getInVariableMap();
		Map <String, Object> inVar = parameter.get("ds_search").get(0);
		inVar.put("maskAuth", param.get("maskAuth"));

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "거래처신청(selectList)", inVar.toString());
		
		//거래처 신청정보 을(를) 조회한다.
		RecordSet rs = custRequestService.selectList(inVar);

		//개인정보보호 접근로그를 쌓는다.
		accessLogService.readLog(inVar, rs.size());

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 거래처 신청정보 목록을 조회한다.
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
	@RequestMapping("selectExists.xdo")
	public ModelAndView selectExists(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "거래처신청(selectExists)", inVar.toString());
		
		//거래처 신청정보 을(를) 조회한다.
		Map<String, Object> rtn = custRequestService.selectExists(inVar);

		logger.debug("상태 : " + rtn.get("status").toString());

		//XPlatform으로 넘겨줄 Variable을 설정한다.
		super.addOutVariable(mav, "fv_status", rtn.get("status").toString());
		
		RecordSet rs = (RecordSet)rtn.get("data");
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_existsList", rs);
		super.addOutDataSet(mav, "ds_existsStCustList", (RecordSet)rtn.get("dataStCust"));
		super.addOutDataSet(mav, "ds_existsSccCustRequestList", (RecordSet)rtn.get("dataSccCustRequest"));
		super.addOutDataSet(mav, "ds_existsSccSapCustList", (RecordSet)rtn.get("dataSccSapCust"));

		//개인정보보호 접근로그를 쌓는다.
		accessLogService.readLog(inVar, rs.size());

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 거래처 신청정보(을)를 Insert/Update/Delete 처리한다.
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
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		//개인정보보호 접근로그를 쌓는다. 
		accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"ID_NO_ENC, CEO_ID_NO_ENC, TEL_NUM_ENC, HAND_PHONE_ENC, EMAIL_ADDR_ENC"}));

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "거래처신청(saveList)", parameter);
		
		//거래처 신청정보을(를) 등록, 수정, 삭제 처리한다.
		String requestNum = custRequestService.saveList(parameter, loginDTO.getSabun());

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_requestNum", requestNum);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
