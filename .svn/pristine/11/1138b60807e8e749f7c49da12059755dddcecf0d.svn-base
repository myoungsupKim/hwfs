package com.hwfs.sc.cmn.web;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.PwdChgService;

/**
 * 비밀번호를 변경하는하는 PwdChg Controller
 *
 * @ClassName PwdChgController.java
 * @Description PwdChgController Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.24    김재섭        최초생성
 *  2015.05.28    kksoo         접근로그 추가
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.24
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/pwdChg/")
public class PwdChgController extends DefaultController {

	/** PwdChgService Bean 생성 */
	@Resource(name = "/sc/cmn/pwdChgService")
	private PwdChgService pwdChgService;

	/**
	 * 비밀번호(을)를 변경 처리한다.
	 *
	 * <pre>
	 * - saveReset.xdo는 로그인이 안 된 상태에서 비밀번호 변경. 이 경우 userid가 전달 됨
	 * - save.xdo는 로그인이 된 상태에서 비밀번호 변경
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping({"save.xdo", "saveReset.xdo"})
	public ModelAndView save(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO
		  , HttpServletRequest req)
			throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		// 비밀번호을(를) 수정 처리한다.
		Map<String, String> procStatus = pwdChgService.save(parameter);

		//접근로그 추가 : 비밀번호초기화 또는 변경
		if (procStatus.get("status").equalsIgnoreCase("TRUE") && parameter.containsKey("chgType") && parameter.get("chgType") != null) {
			LoginDTO loginDTO;
			if (parameter.get("chgType").toString().equalsIgnoreCase("RESET")) {
				loginDTO = new LoginDTO(); //로그인 세션이 생성되지 않은 상태임
				loginDTO.setSabun(procStatus.get("sabun"));
				loginDTO.setAccessIp(req.getRemoteAddr());
				
    			accessLogService.pwdInitLog(loginDTO, messageService.getMessage("accesslog.pwd.init"));
			}else{
				loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
    			accessLogService.pwdChgLog(loginDTO, messageService.getMessage("accesslog.pwd.change"));
			}
		}
		
		// 처리결과를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_status", procStatus.get("status"));
		super.addOutVariable(mav, "fv_message", procStatus.get("message"));

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
