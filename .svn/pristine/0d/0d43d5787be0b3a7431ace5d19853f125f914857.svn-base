package com.hwfs.sc.cmn.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultController;

 /**
 * 외부시스템 화면 연계 처리 Controller
 * @ClassName SysIfController.java
 * @Description SysIfController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 7. 15.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 1. 23.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/sysIf/")
public class SysIfController extends DefaultController {
	
	/**
	 * 전사구매시스템 화면 연계 요청을 처리한다.
	 * 
	 * @param request
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "callEproc.do")
	public ModelAndView callEproc (HttpServletRequest request, Model model) throws Exception {
		//시스템구분 정보를 Model로 전달한다. 추후 이용을 위함
		model.addAttribute("SYS_TYPE", "EPROC");
		
		//Viewer 설정		
    	ModelAndView mav = new ModelAndView();
		mav.setViewName("/cmn/linkSysIF");
		return mav;
	}

	/**
	 * 물류시스템 화면 연계 요청을 처리한다.
	 * 
	 * @param request
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "callMaestro.do")
	public ModelAndView callMaestro (HttpServletRequest request, Model model) throws Exception {
		//시스템구분 정보를 Model로 전달한다. 추후 이용을 위함
		model.addAttribute("SYS_TYPE", "MAESTRO");
		
		//Viewer 설정		
    	ModelAndView mav = new ModelAndView();
		mav.setViewName("/cmn/linkSysIF");
		return mav;
	}

}
