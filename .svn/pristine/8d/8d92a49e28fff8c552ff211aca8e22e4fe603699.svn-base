package com.hwfs.sc.cmn.web;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.cmn.service.PersInfoProcPolicyService;


 /**
 * 개인정보취급방침 동의를 관리하는 PersInfoProcPolicy Controller
 * 
 * @ClassName PersInfoProcPolicyController.java
 * @Description PersInfoProcPolicyController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.24    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 :  AA kksoo
 * @since 2015.04.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/persInfoProcPolicy/")
public class PersInfoProcPolicyController extends DefaultController {
	
	/** PersInfoProcPolicyService Bean 생성 */
	@Resource(name = "/sc/cmn/persInfoProcPolicyService")
	private PersInfoProcPolicyService persInfoProcPolicyService;
	
	/**
	 * 개인정보취급방침 동의를 저장한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveAgreeInfo.xdo")
	public ModelAndView saveAgreeInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//개인정보취급방침 동의를을(를) 저장 처리한다.
		int processCnt = persInfoProcPolicyService.saveAgreeInfo(inVar);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 노무수령 거부의사 동의를 저장한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveHRAgree.xdo")
	public ModelAndView saveHRAgree(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//개인정보취급방침 동의를을(를) 저장 처리한다.
		int processCnt = persInfoProcPolicyService.saveHRAgree(inVar);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
