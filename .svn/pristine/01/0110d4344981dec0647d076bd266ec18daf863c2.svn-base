package com.hwfs.sc.cmn.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.cmn.dto.ReportViewerDTO;
import com.hwfs.sc.cmn.service.ReportService;

 /**
 * OzReport 처리 Controller
 * @ClassName ReportController.java
 * @Description ReportController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 23.   kksoo        최초생성
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
@RequestMapping("/sc/cmn/report/")
public class ReportController extends DefaultController {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** Report Service */
    @Resource (name="/sc/cmn/reportService")
    private ReportService reportService;

	/**
	 * OZReport 생성 요청을 처리한다.
	 * <pre>
	 * - 개인정보보호 요건으로 레포트 로그를 기록한다.
	 * </pre>
	 * 
	 * @param request
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "reportViewer.do")
	public ModelAndView reportViewer (HttpServletRequest request, Model model) throws Exception {
		//Viewer에 전달할 정보를 설정하고 개인정보보호 요건으로 레포트 로그를 기록한다.
		ReportViewerDTO reportViewerDTO = reportService.getReportViewerDTO (request);
		
		//Viewer 정보를 Model로 전달한다.
		model.addAttribute(ReportService.RPT_VIEWER_DTO, reportViewerDTO);
		
		//Viewer 설정		
    	ModelAndView mav = new ModelAndView();
    	if (reportViewerDTO.isXmlBind()) {
    		if (!reportViewerDTO.isDynamicXmlBind())
    			mav.setViewName(ReportService.RPT_XML_VIEWER_NAME);
    		else
    			mav.setViewName(ReportService.RPT_DYNAMIC_XML_VIEWER_NAME);
    	}else
    		if(reportViewerDTO.isMultiBind()){
    			mav.setViewName(ReportService.RPT_MULTI_VIEWER_NAME);
    		}else{
    			mav.setViewName(ReportService.RPT_VIEWER_NAME);
    		}
		return mav;
	}


}
