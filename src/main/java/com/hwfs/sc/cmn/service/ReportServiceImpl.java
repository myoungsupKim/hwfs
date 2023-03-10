package com.hwfs.sc.cmn.service;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.dto.ReportViewerDTO;

/**
 * OzReport 처리 Service Implementation
 * 
 * @ClassName ReportServiceImpl.java
 * @Description ReportServiceImpl Class 
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
@Service("/sc/cmn/reportService")
public class ReportServiceImpl extends DefaultServiceImpl implements ReportService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** 레포트 ozr name */
	private static final String RPT_NAME = "url";
	
	/** XML Binding Data */
	public static final String RPT_XML_BIND = "xmlbind";

	/**
	 * Report Viewer에 전달할 ReportViewerDTO를 얻는다.
	 * <pre>
	 * - 공통매개변수 생성한다.
	 * - 개인정보보호 요건으로 레포트 로그를 기록한다.
	 * </pre>
	 *
	 * @param request
	 * @return ReportViewerDTO
	 */
	public ReportViewerDTO getReportViewerDTO (HttpServletRequest request) throws Exception {
		Map <String, Object> inVar = new HashMap<String, Object>();

		//Request 파라미터를 맵으로 변환
		Enumeration<?> params = request.getParameterNames();
		while (params.hasMoreElements()) {
			String name = (String)params.nextElement();
			String value = request.getParameter(name);
			inVar.put(name, value);
		}

		//개인정보보호 요건으로 레포트 로그를 기록한다.
		accessLogService.reportLog(inVar);
		
		return getReportViewerDTO(request, inVar);
	}

	/**
	 * Report Viewer에 전달할 ReportViewerDTO를 얻는다.
	 * <pre>
	 * - 공통매개변수 생성
	 * </pre>
	 *
	 * @param request
	 * @param inVar Report 생성 파라메터 정보
	 * @return ReportViewerDTO
	 */
	public ReportViewerDTO getReportViewerDTO (HttpServletRequest request, Map <String, Object> inVar) throws Exception {
		//로그인 정보
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);

		//Viewer에 전달할 정보를 설정한다.
		ReportViewerDTO reportViewerDTO = new ReportViewerDTO();

		//Report명 설정
		reportViewerDTO.setReportName((String)inVar.get(RPT_NAME));
		//reportViewerDTO.setReportName(java.net.URLDecoder.decode((String)inVar.get(RPT_NAME),"UTF-8"));
		
		//Report 이미지 매개변수를 추가한다.
//		if (inVar.containsKey(RPT_VERTICAL_YN) && inVar.get(RPT_VERTICAL_YN).toString().equalsIgnoreCase("n"))
//			reportViewerDTO.setImgPath(propertiesService.getString("oz.background-horizon.image"));
//		else
//			reportViewerDTO.setImgPath(propertiesService.getString("oz.background.image"));
		
		//XML Client Bind 여부
		if(inVar.get("multiYn") == null || "".equals(inVar.get("multiYn"))){
			inVar.put("multiYn", "false");
		}
		if (inVar.containsKey(RPT_XML_BIND) && inVar.get(RPT_XML_BIND).toString().equalsIgnoreCase("y")) {
			reportViewerDTO.setXmlBind(true);
			reportViewerDTO.setDynamicXmlBind(false);
		}else if (inVar.containsKey(RPT_XML_BIND) && inVar.get(RPT_XML_BIND).toString().equalsIgnoreCase("d")) {
			reportViewerDTO.setXmlBind(true);
			reportViewerDTO.setDynamicXmlBind(true);
		}else if(inVar.get("multiYn").toString().equals("true")){
			reportViewerDTO.setMultiBind(true);
		}else
			reportViewerDTO.setXmlBind(false);
		
		//공통 파라미터 설정
		reportViewerDTO.setSabun(loginDTO.getSabun());
		reportViewerDTO.setUserId(loginDTO.getUserid());
		reportViewerDTO.setUserNm(loginDTO.getNmKor());
		reportViewerDTO.setDeptNm(loginDTO.getDeptNm());
		reportViewerDTO.setUserInfo(reportViewerDTO.getUserNm() + "/" + reportViewerDTO.getDeptNm());
		reportViewerDTO.setPersInfoMask(loginDTO.getPersInfoMask());
		
		logger.debug("레포트 뷰 SETTING {}", reportViewerDTO);


		return reportViewerDTO;
	}

}
