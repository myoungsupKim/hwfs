package com.hwfs.sc.cmn.web;

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
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.EmailDTO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.EmailSendService;


 /**
 * Email을 전송하는 EmailSend Controller
 * 
 * @ClassName EmailSendController.java
 * @Description EmailSendController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.13    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 :  AA kksoo
 * @since 2015.03.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/emailSend/")
public class EmailSendController extends DefaultController {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** EmailSendService Bean 생성 */
	@Resource(name = "/sc/cmn/emailSendService")
	private EmailSendService emailSendService;
	
	/**
	 * Email 전송 목록을 조회한다.
	 * <pre>
	 * - 업무팀에서 업무에 맞게 개발해야 함
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//Email 전송 을(를) 조회한다.
		RecordSet rs = emailSendService.selectListEmail(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * Email 전송(을)를 Insert 처리한다.
	 * <pre>
	 * - EMAIL IF 테이블에 Insert만 존재
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO
		  , HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//로그인 정보
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		
		//받는사람 목록이 전달되므로 DTO ArrayList로 변환
		String strEmailList = (String)parameter.get(0).get("emailList");
		String[] arrEmailList = strEmailList.split(";");
		String strNameList = (String)parameter.get(0).get("nameList");
		String[] arrNameList = strNameList.split(";");

		if (arrEmailList.length != arrNameList.length) 
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, "받는 사람 이메일 수와 이름의 수가 일치하지 않습니다!");
		
		List<EmailDTO> emailList = new ArrayList<EmailDTO>();
		String strSubject = (String)parameter.get(0).get("subject");
		String strMsg = (String)parameter.get(0).get("msg");
		
		for (int i=0; i<arrEmailList.length; i++) {
			EmailDTO emailDTO = new EmailDTO();
			emailDTO.setToEmail(arrEmailList[i]);
			emailDTO.setToName(arrNameList[i]);
			emailDTO.setSubject(strSubject);
			emailDTO.setMapContent(strMsg);
			
			//발송자 이메일이 없는 경우는 기본 값으로 설정한다. (업무에 따라 설정)
			emailDTO.setFromEmail(propertiesService.getString("ems.email.fromEmail", ""));

			//발송자 이름이 없는 경우는 기본 값으로 설정한다. (업무에 따라 설정)
			emailDTO.setFromName(propertiesService.getString("ems.email.fromName", ""));

			emailDTO.setTrCcId("3770"); 		//테스트용이며, 업무에서는 loginDTO.getCcCd()로 설정한다.
			emailDTO.setUserId("900101004");	//테스트용이며, 업무에서는 loginDTO.getSabun()로 설정한다.
			emailDTO.setDmNo("");				//테스트용이며, 업무에서 설정한다.
			
			emailList.add(emailDTO);
		}
		
		//Email 전송을(를) 등록 처리한다.
		int processCnt = emailSendService.saveEmail(emailList);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
