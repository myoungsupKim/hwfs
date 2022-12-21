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
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.dto.SmsDTO;
import com.hwfs.sc.cmn.service.SmsSendService;


 /**
 * SMS를 전송하는 SmsSend Controller
 * - SMS or Push 방식으로 전송
 * @ClassName SmsSendController.java
 * @Description SmsSendController Class 
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
@RequestMapping("/sc/cmn/smsSend/")
public class SmsSendController extends DefaultController {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/smsSendService")
	private SmsSendService smsSendService;
	
	/**
	 * SMS 전송 목록을 조회한다.
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
		
		//SMS 전송 을(를) 조회한다.
		RecordSet rs = smsSendService.selectListSms(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * SMS 전송(을)를 Insert 처리한다.
	 * <pre>
	 * - SMS IF 테이블에 Insert만 존재
	 * - SMS or PUSH 방식으로 전송
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
		String strHpList = (String)parameter.get(0).get("hpList");
		String[] arrHpList = strHpList.split(";");
		List<SmsDTO> smsList = new ArrayList<SmsDTO>();
		String strMsg = (String)parameter.get(0).get("msg");
		String strSendType = (String)parameter.get(0).get("sendType");
		
		for (int i=0; i<arrHpList.length; i++) {
			SmsDTO smsDTO = new SmsDTO();
			smsDTO.setTrPhone(arrHpList[i]);	//수신자 전화번호
			smsDTO.setTrMsg(strMsg);			//전송 메시지
			
			//송신자번호가 없는 경우는 기본 전화번호로 설정한다. (업무에 따라 설정)
			smsDTO.setTrCallback(propertiesService.getString("ems.sms.callback.no", ""));
			
			//전송할 시간 : 생략하면 현재 시간
			//smsDTO.setTrSendDate("20150501 1200");
			
			//smsDTO.setTrCcId("3770"); 			//테스트용이며, 업무에서는 loginDTO.getCcCd()로 설정한다.
			smsDTO.setTrDeptId(loginDTO.getDeptId()); 			//테스트용이며, 업무에서는 loginDTO.getCcCd()로 설정한다.
			smsDTO.setTrCcId(loginDTO.getCcCd()); 			//테스트용이며, 업무에서는 loginDTO.getCcCd()로 설정한다.
			//smsDTO.setTrUserId("900101004");	//테스트용이며, 업무에서는 loginDTO.getSabun()로 설정한다.
			smsDTO.setTrUserId(loginDTO.getUserid());
			smsDTO.setTrCustNo("");				//테스트용이며, 업무에서는 수신자의 사업장코드로 설정한다.
			
			smsList.add(smsDTO);
		}
		
		//SMS/PUSH 전송을(를) 등록 처리한다.
		int processCnt = 0;
		if (strSendType.equals("sms")) 
			processCnt = smsSendService.saveSms(smsList);
//		else
//			processCnt = smsSendService.savePush(smsList);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
