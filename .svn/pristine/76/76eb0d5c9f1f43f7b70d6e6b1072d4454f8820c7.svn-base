package com.hwfs.sc.cmn.web;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.cmn.service.OwnCertService;


 /**
 * 본인인증을 처리하는 OwnCert Controller
 * 
 * @ClassName OwnCertController.java
 * @Description OwnCertController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.27    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 :  AA kksoo
 * @since 2015.04.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/ownCert/")
public class OwnCertController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** OwnCertService Bean 생성 */
	@Resource(name = "/sc/cmn/ownCertService")
	private OwnCertService ownCertService;
	
	/**
	 * 본인인증번호를 요청한다.
	 * <pre>
	 * - 발급된 정보는 SMS로 발송한다.
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("requestCernNum.xdo")
	public ModelAndView requestCernNum(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		@SuppressWarnings("unchecked")
		Map<String, Object> mapParam = xpDTO.getInDataSetMap().get("ds_list").get(0);
		
		//본인인증번호를 요청한다.
		String cernNum = ownCertService.requestCernNum(mapParam);

		logger.debug("requestCernNum={} ==> cernNum={}", mapParam, cernNum);

		//SMS 테스트 환경에서는 SMS가 전송되지 못하므로 테스트를 위해 클라이언트로 메시지 전송하여 처리
		if (propertiesService.getBoolean("ems.test.env", true))			
			super.addOutVariable(mav, "fv_cernTestMsg", messageService.getMessage("sc.cmn.cern.num.testMsg", new String[]{cernNum}));
		else
			super.addOutVariable(mav, "fv_cernTestMsg", "");

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 본인인증번호를 확인한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("confirmCernNum.xdo")
	public ModelAndView confirmCernNum(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		@SuppressWarnings("unchecked")
		Map<String, Object> mapParam = xpDTO.getInDataSetMap().get("ds_list").get(0);
		
		//본인인증번호를 확인한다.
		boolean isOk = ownCertService.confirmCernNum(mapParam);
		String vKey  = ownCertService.confirmCernNumCheck(mapParam);
		
		logger.debug("requestCernNum={} ==> isOk={} ==> vKey={}  ", mapParam, isOk, vKey);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		if (isOk)
			return super.setResultSet(mav, DefaultConsts.OK_CODE, vKey);
		else
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, messageService.getMessage("sc.cmn.cern.confirm.err"));
	}

}
