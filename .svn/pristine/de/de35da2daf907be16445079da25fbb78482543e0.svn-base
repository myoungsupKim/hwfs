package com.hwfs.sc.scu.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.scu.service.UserChangeService;


 /**
 * 사용자 변경을하는 UserChange Controller
 * 
 * @ClassName UserChangeController.java
 * @Description UserChangeController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.19    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 :  COM 김재섭
 * @since 2015.08.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scu/userChange/")
public class UserChangeController extends DefaultController {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UserChangeService Bean 생성 */
	@Resource(name = "/sc/scu/userChangeService")
	private UserChangeService userChangeService;
	
	/**
	 * 사용자 변경 목록을 조회한다.
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
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> param = parameter.get("ds_search").get(0);
		
		//사용자 변경 을(를) 조회한다.
		RecordSet rs = userChangeService.selectList(param);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

    /**
	 * 로그인을 처리한다.
	 * <pre>
	 * - ID/PWD/sysType을 파라미터로 전달 받음
	 * - 개인정보보호 지침 처리
	 * - 로그인정보DTO를 세션에 저장하고 클라이언트에 전달
	 * </pre>
     * 
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "login.xdo")
    public ModelAndView login(
    		@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
    	  , HttpServletRequest req) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//login 파라미터를 얻는다.
		Map <String, Object> inVar = xpDto.getInVariableMap();
		
    	//로그인 처리
		LoginDTO loginDTO = userChangeService.doLogin(req, inVar);

		List<LoginDTO> list = new ArrayList<LoginDTO>();
		list.add(loginDTO);

		super.addOutVariable(mav, "gdsUserInfo", list);
		
		return super.setResultSet (mav, DefaultConsts.OK_CODE, "");
     }

    @RequestMapping("upadteAcctStatus.xdo")
	public ModelAndView upadteAcctStatus(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, Object> param = xpDTO.getInVariableMap();
		
		//사용자 변경 을(를) 조회한다.
		userChangeService.upadteAcctStatus(param);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		//super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
    
    @RequestMapping("upadtePassword.xdo")
	public ModelAndView upadtePassword(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, Object> param = xpDTO.getInVariableMap();
		
		//사용자 변경 을(를) 조회한다.
		userChangeService.upadtePassword(param);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		//super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
