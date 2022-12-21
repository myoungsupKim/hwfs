package com.hwfs.rc.bms.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
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
import com.hwfs.rc.bms.service.BasOrderplceMgmtService;
import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * BasOrderplceMgmtController에 대한 설명 작성
 * @ClassName BasOrderplceMgmtController.java
 * @Description BasOrderplceMgmtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 24.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 2. 24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/rc/bms/basOrderplceMgmt/")
public class BasOrderplceMgmtController extends DefaultController {
	@Resource(name="/rc/bms/basOrderplceMgmtService")
	private BasOrderplceMgmtService basOrderplceMgmt;
	                 
	@RequestMapping("selectOrderplceList.xdo")
	public ModelAndView selectAmList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = basOrderplceMgmt.selectOrderplceList(parameter);

		//개인정보보호 접근로그 조회 조건과 건수
		accessLogService.readLog(parameter, rs.size());
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_orderplceMst", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		
		
		
		 
		
		
	}
	

	@RequestMapping("saveOrderplceMgmt.xdo")
	public ModelAndView saveOrderplceMgmt(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {

		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();
		

		//로그인 정보를 반환한다. 주소처리를 위해서
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);


		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		//개인정보보호 접근로그를 쌓는다.
		accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"핸드폰번호, 전화번호, 이메일, 상세주소"}));
		
		int procCnt =  basOrderplceMgmt.saveOrderplceMgmt(parameter.get("ds_orderplceMst"), loginDTO.getSabun());

		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_iProcessCnt",  procCnt);
	
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		
		


		 
	 

		 

	 
		
	}

}
