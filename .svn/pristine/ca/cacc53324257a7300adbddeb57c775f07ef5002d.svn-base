package com.hwfs.sc.cmn.service;

import javax.servlet.http.HttpServletRequest;

import com.hwfs.sc.cmn.dto.ReportViewerDTO;

/**
 * OzReport 처리 Service Interface
 * 
 * @ClassName ReportService.java
 * @Description ReportService Class 
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
public interface ReportService {

	/** Report Viewer DTO */
	public static final String RPT_VIEWER_DTO = "reportViewerDTO";

	/** Report Viewer Name */
	public static final String RPT_VIEWER_NAME = "/report/reportViewer";

	/** Report Xml Viewer Name */
	public static final String RPT_XML_VIEWER_NAME = "/report/reportXmlViewer";

	/** Report Dynamic Xml Viewer Name */
	public static final String RPT_DYNAMIC_XML_VIEWER_NAME = "/report/reportDynamicXmlViewer";
	
	/** Report Multi Viewer Name */
	public static final String RPT_MULTI_VIEWER_NAME = "/report/reportMultiViewer";
	

	/**
	 * Report Viewer에 전달할 ReportViewerDTO를 얻는다.
	 * <pre>
	 * - 발행번호 채번
	 * - 공통매개변수 생성
	 * </pre>
	 *
	 * @param request
	 * @return ReportViewerDTO
	 * @throws Exception 
	 */
	public ReportViewerDTO getReportViewerDTO (HttpServletRequest request) throws Exception;
}
