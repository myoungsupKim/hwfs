package com.hwfs.sc.cmn.web;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;

/**
 * AS-IS에서 FSP 프레임워크를 사용하는 경우 개인정보 조회/저장/삭제 로그를 처리하는 Controller
 * <pre>
 * -AS-IS에서 FSP 프레임워크를 사용하는 경우는 서버단에서 로그를 쌓을 수 없으므로 클라이언트 요청에 의해 쌓이도록 함
 * </pre>
 * 
 * @ClassName PersInfoLogController.java
 * @Description PersInfoLogController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 17.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 8. 17.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/persInfoLog/")
public class PersInfoLogController extends DefaultController {

    /**
	 * 개인정보보호 조회 접근로그를 쌓는다.
     * 
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "readLog.xdo")
    public ModelAndView readLog(
    		@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
    	  , HttpServletRequest req) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();
		
		//파라미터를 얻는다.
		Map <String, Object> inVar = xpDto.getInVariableMap();
		
    	//개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
		accessLogService.readLog((String)inVar.get("readCond"), Integer.parseInt(inVar.get("readCnt").toString()));
		
		return setResultSet (mav, DefaultConsts.OK_CODE, "");		
     }

    /**
     * 개인정보보호 저장/삭제 접근로그를 쌓는다.
     * 
     * @param xpDto
     * @param req
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "writeLog.xdo")
    public ModelAndView writeLog(
    		@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
    	  , HttpServletRequest req) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDto.getInVariableMap();
		
    	//개인정보보호 저장/삭제 접근로그를 쌓는다.
		accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{(String)inVar.get("logData")}));
		
		return setResultSet (mav, DefaultConsts.OK_CODE, "");		
     }

}
