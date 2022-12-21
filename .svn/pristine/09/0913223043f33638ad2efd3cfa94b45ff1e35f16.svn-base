package com.hwfs.sc.cmn.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.cmn.service.KiccApprovalService;


 /**
 * KICC의 승인처리를하는 KiccApproval Controller
 *
 * @ClassName KiccApprovalController.java
 * @Description KiccApprovalController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.21    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 :  COM 김재섭
 * @since 2015.07.21
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/kiccApproval/")
public class KiccApprovalController extends DefaultController {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** KiccApprovalService Bean 생성 */
	@Resource(name = "/sc/cmn/kiccApprovalService")
	private KiccApprovalService kiccApprovalService;


	/**
	 * 특정승인정보를 조회한다.
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectCardApproval.xdo")
	public ModelAndView selectCardApproval(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		//KICC 승인처리 을(를) 조회한다.
		RecordSet rs = kiccApprovalService.selectCardApproval(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_approvalList", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * KICC 승인처리 목록을 조회한다.
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
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		//KICC 승인처리 을(를) 조회한다.
		RecordSet rs = kiccApprovalService.selectList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_approvalList", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * KICC 승인처리(을)를 Insert/Update/Delete 처리한다.
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
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		Map<String, Object> p = xpDTO.getInVariableMap();
		JSONObject input = null;
		
		try {
			input = new JSONObject(p.get("input").toString());
		}
		catch (JSONException e) {
			logger.error(e.getMessage());
		}
		
		Map<String, Object> parameter = new HashMap<String, Object>();
		
		if (p.containsKey("refNo")) parameter.put("refNo", p.get("refNo").toString().trim());
		parameter.put("refSys", p.get("refSys").toString().trim());
		
		parameter.put("reqDocCd", input.get("reqDocCd").toString().trim());
		parameter.put("reqWcc", input.get("reqWcc").toString().trim());
		parameter.put("reqCardNo", input.get("reqCardNo").toString().trim());
		parameter.put("reqDiv", input.get("reqDiv").toString().trim());
		parameter.put("reqApprovalDt", input.get("reqApprovalDt").toString().trim());
		parameter.put("reqApprovalNo", input.get("reqApprovalNo").toString().trim());
		parameter.put("reqAmt", input.get("reqAmt").toString().trim());
		parameter.put("reqCharge", input.get("reqCharge").toString().trim());
		parameter.put("reqVat", input.get("reqVat").toString().trim());
		parameter.put("reqPosNo", input.get("reqPosNo").toString().trim());
		parameter.put("docCd", input.get("docCd").toString().trim());
		parameter.put("resCd", input.get("resCd").toString().trim());
		parameter.put("tid", input.get("tid").toString().trim());
		parameter.put("wcc", input.get("wcc").toString().trim());
		parameter.put("cardData", input.get("cardData").toString().trim());
		parameter.put("cardNo", input.get("cardNo").toString().trim());
		parameter.put("div", input.get("div").toString().trim());
		parameter.put("amt", input.get("amt").toString().trim());
		parameter.put("charge", input.get("charge").toString().trim());
		parameter.put("vat", input.get("vat").toString().trim());
		parameter.put("approvalNo", input.get("approvalNo").toString().trim());
		parameter.put("approvalDt", input.get("approvalDt").toString().trim());
		parameter.put("issueCpnCd", input.get("issueCpnCd").toString().trim());
		parameter.put("cardCpnNm", input.get("cardCpnNm").toString().trim());
		parameter.put("memberCd", input.get("memberCd").toString().trim());
		parameter.put("purchaseCpnCd", input.get("purchaseCpnCd").toString().trim());
		parameter.put("purchaseCpnNm", input.get("purchaseCpnNm").toString().trim());
		parameter.put("posNo", input.get("posNo").toString().trim());
		
		if ("B".equals(parameter.get("docCd").toString().substring(0, 1))) {
			parameter.put("dscDiv", "");
		}
		else {
			parameter.put("dscDiv", input.get("dscDiv").toString().trim());
		}
		
		parameter.put("msg", input.get("msg").toString().trim());
		
		//KICC 승인처리을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> rtn = kiccApprovalService.saveList(parameter);
		rtn.put("docCd", input.get("docCd").toString().trim());
		rtn.put("resCd", input.get("resCd").toString().trim());
		rtn.put("msg", input.get("msg").toString().trim());

		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "ds_result", rtn);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
