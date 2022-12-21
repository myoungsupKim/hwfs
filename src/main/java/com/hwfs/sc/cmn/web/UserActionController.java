package com.hwfs.sc.cmn.web;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.cmn.service.AuthorityService;


 /**
 * 사용자 이벤트 액션 로그를 처리하는 UserAction Controller
 * 
 * @ClassName UserActionController.java
 * @Description UserActionController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.19    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 :  AA kksoo
 * @since 2015.06.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/userAction/")
public class UserActionController extends DefaultController {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** Authority Service */
    @Resource (name="/sc/cmn/authorityService")
    private AuthorityService authorityService;

	/**
	 * 사용자 이벤트 액션 로그를 처리한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("actionLog.xdo")
	public ModelAndView actionLog(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//Action 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//로그를 기록한다.
		if (propertiesService.getBoolean("accesslog.action.use", false)) {
			try {
				accessLogService.actionLog(inVar.get("action").toString());
				authorityService.updateConnUserPgm(inVar);
			} catch (Exception ex) {
				//Exception은 무시
				logger.error("exception at UserActionController.actionLog ", ex);
			}
		}
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
