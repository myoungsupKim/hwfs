package com.hwfs.sc.cmn.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
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
import com.hwfs.cmn.token.SavedToken;
import com.hwfs.sc.cmn.dto.PgmAuthDTO;
import com.hwfs.sc.cmn.service.AuthorityService;

 /**
 * 프로그램 권한, 권한에 맞는 메뉴목록을 조회하고 접속프로그램 정보를 저장하는 Authority Controller
 * <pre>
 * -권한이 있는 메뉴 조회
 * -사용자/부서에 따른 프로그램 권한
 * -CSRF Valid Token 발생
 * </pre>
 * @ClassName AuthorityController.java
 * @Description AuthorityController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 10.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 10.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
public class AuthorityController extends DefaultController {

    /** Authority Service */
    @Resource (name="/sc/cmn/authorityService")
    private AuthorityService authorityService;

    /**
	 * 로그인 사용자가 특정 프로그램을 사용할 수 있는 권한을 조회한다.
	 * <pre>
	 * - 등록되지 않은 프로그램인 경우는 "0000"을 반환
	 * - CSRF 검증을 위한 Token을 발행한다.
	 * - 시스템사용정보를 처리한다.
	 * </pre>
     * 
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/sc/cmn/authority/selectPgmAuth.xdo")
    public ModelAndView selectPgmAuth(
    		@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
    	  , HttpServletRequest req) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDto.getInVariableMap();
		
    	//프로그램 권한 조회 처리
		PgmAuthDTO pgmAuthDTO = authorityService.selectPgmAuth (inVar);
		List<PgmAuthDTO> list = new ArrayList<PgmAuthDTO>(); 
		if (pgmAuthDTO != null) list.add(pgmAuthDTO);
		
		//시스템사용정보를 저장한다.
		authorityService.saveSysUseInfo(inVar);
		
		//Valid Token 생성
		String strSavedToken = SavedToken.setToken(req, SavedToken.DEFAULT_TOKEN_NAME);
				
    	//전달할 결과 ResultSet에 설정
		addOutVariable(mav, "dsOutput", list);
		addOutVariable(mav, DefaultConsts.XPLATFORM_TOKEN_NAME, strSavedToken);

		return setResultSet (mav, DefaultConsts.OK_CODE, "");		
     }

    /**
     * 접속사용자의 권한에 맞는 Menu를 조회한다.
     * <pre>
     * - 시스템 타입에 따라 처리하는 방식이 상이하다.
     * - sysType이 IFIS, FICS,SPOON의 경우는 시스템변경 목록, 업장변경도 조회하여 반환
     * </pre>
     *
     * @param xpDto
     * @param req
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/sc/cmn/selectMenu.xdo")
    public ModelAndView selectMenu(
    		@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
    	  , HttpServletRequest req) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDto.getInVariableMap();
		
		//파라미터 설정
		//LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		//String sysType = inVar.get("sysType").toString();
		
    	//메뉴 조회 처리
		RecordSet listMenu = authorityService.selectMenu(inVar);
		//if (listMenu == null) listMenu = new ArrayList<Map<String,Object>>();
		
    	//전달할 결과 ResultSet에 설정
		addOutDataSet(mav, "gdsMenu", listMenu);
		
		//MOBILE이 아닌 경우 추가 정보 조회
//		if (!sysType.equalsIgnoreCase("FSMOBILE")) {
//			//최근메뉴10개, 시스템변경 목록, 업장변경도 조회
//		}
		
		return setResultSet (mav, DefaultConsts.OK_CODE, "");		
     }

}
