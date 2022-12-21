package com.hwfs.ms.cmn.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fm.fms.service.EstPaperWriteService;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ms.cmn.service.MobileCommonService;
import com.hwfs.ms.cmn.util.CreateEstimateReport;
import com.hwfs.sc.cmn.dto.EmailDTO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.EmailSendService;


 /**
 * 모바일 공통 서비스하는 MobileCommon Controller
 * 
 * @ClassName MobileCommonController.java
 * @Description MobileCommonController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.13    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 :  모바일 강대성
 * @since 2015.04.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ms/cmn/mobileCommon/")
public class MobileCommonController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** MobileCommonService Bean 생성 */
	@Resource(name = "/ms/cmn/mobileCommonService")
	private MobileCommonService mobileCommonService;
	
	/** EstPaperWriteService Bean 생성 */
	@Resource(name = "/fm/fms/estPaperWriteService")
	private EstPaperWriteService estPaperWriteService;
	
	/** EmailSendService Bean 생성 */
	@Resource(name = "/sc/cmn/emailSendService")
	private EmailSendService emailSendService;
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
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
		
		//모바일 공통 서비스 을(를) 조회한다.
		RecordSet rs = mobileCommonService.selectList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectMenuAuthList.xdo")
	public ModelAndView selectMenuAuthList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//모바일 공통 서비스 을(를) 조회한다.
		RecordSet rs = mobileCommonService.selectMenuAuthList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
     * 견적서 메일 발송
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("sendEmail.xdo")
    public ModelAndView sendEmail(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        
        //로그인 정보
      	LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);

        String realpath = propertiesService.getString("global.filerepository.path");
        realpath = realpath + propertiesService.getString("ms.file.path")
                + propertiesService.getString("ls.inspectrpt.upload.path") + File.separator;
        // folder가 없으면 생성
        LimsUtil.makeFolder(realpath);

        //String strCss = realpath + "inspectRpt.css";
        String htmlFile = realpath + "EstimateReport.html";
        
        Map<String, Object> param = parameter.get("ds_search").get(0);
        RecordSet rs1 = null;
        
        //////////////////////////////////////////////////////////////////////////////////////////////////////
        // 견적서 만들기
        //////////////////////////////////////////////////////////////////////////////////////////////////////
        Map<String, Object> paramMap = null;
            
        rs1 = estPaperWriteService.selectList(param);
        
        logger.debug("rs1 >>>>>>>>>" +rs1);
        
        paramMap = new HashMap<String, Object>();
        paramMap.put("htmlFile", htmlFile);	                       //html파일명
        paramMap.put("schEstiId", (String)param.get("schEstiId")); //견적번호
        paramMap.put("emailName", (String)param.get("emailName")); //고객사명
        paramMap.put("schDate1", (String)param.get("schDate1"));   //견적시작일
        paramMap.put("schDate2", (String)param.get("schDate2"));   //견적종료일
        paramMap.put("testResultList", rs1);
        
        String strContent = CreateEstimateReport.createHtml(paramMap);        
        
        logger.debug("strContent >>>>>>>>>" +strContent);
        
        List<EmailDTO> emailList = new ArrayList<EmailDTO>();
        
        EmailDTO emailDTO = new EmailDTO();
		emailDTO.setToEmail((String)param.get("emailAddress"));
		emailDTO.setToName((String)param.get("emailName"));
		emailDTO.setSubject("견적서");
		emailDTO.setMapContent(strContent);
		
		//발송자 이메일이 없는 경우는 기본 값으로 설정한다. (업무에 따라 설정)
		emailDTO.setFromEmail(propertiesService.getString("ems.email.fromEmail", ""));

		//발송자 이름이 없는 경우는 기본 값으로 설정한다. (업무에 따라 설정)
		emailDTO.setFromName(propertiesService.getString("ems.email.fromName", ""));
		
		emailDTO.setTrCcId(loginDTO.getCcCd());  //부서명.
		emailDTO.setUserId(loginDTO.getSabun()); //등록자 ID
		emailDTO.setDmNo("");				     //업무에서 설정한다.
		
		emailList.add(emailDTO);
		
        //Email 전송을(를) 등록 처리한다.
      	int processCnt = emailSendService.saveEmail(emailList);
        
        //처리건수를 OutVariable에 설정한다.
      	super.addOutVariable(mav, "fv_processCnt", processCnt);

      	//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
      	return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
	 * 수신된 PUSH알림 검색.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectPushList.xdo")
	public ModelAndView selectPushList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//모바일 공통 서비스 을(를) 조회한다.
		RecordSet rs = mobileCommonService.selectPushList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectMenuList.xdo")
	public ModelAndView selectMenuList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//모바일 공통 서비스 을(를) 조회한다.
		RecordSet rs = mobileCommonService.selectMenuList(inVar);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectComboAuthMenuList.xdo")
	public ModelAndView selectComboAuthMenuList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//모바일 공통 서비스 을(를) 조회한다.
		RecordSet rs = mobileCommonService.selectComboAuthMenuList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectDualUpjangList.xdo")
	public ModelAndView selectDualUpjangList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//모바일 공통 서비스 을(를) 조회한다.
		RecordSet rs = mobileCommonService.selectDualUpjangList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);		
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 모바일 공통 서비스 목록을 조회한다(LIMS팀장승인자 승인반려 권한).
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectLimsAuthLevels.xdo")
	public ModelAndView selectLimsAuthLevels(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//모바일 공통 서비스 을(를) 조회한다.
		RecordSet rs = mobileCommonService.selectLimsAuthLevels(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);		
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
}
