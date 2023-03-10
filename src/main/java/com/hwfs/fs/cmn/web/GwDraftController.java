package com.hwfs.fs.cmn.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultController;

/**
 * 위생관리 그룹웨어 연동 Controller Class
 *
 * @ClassName GwDraftController.java
 * @Description GwDraftController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 29.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 5. 29.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/cmn/gwDraftController/")
public class GwDraftController extends DefaultController {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.
     * <pre>
     * - RequestMapping은 .do로 해야 한다.
     * - 상신을 위한 본문은 DB에서 쿼리하여 JSP를 이용하여 동적으로 HTML 본문을 만든다.
     * - JSP 본문 양식은 WEB-INF/jsp에서 관리한다.
     * - 본문 title 파라미터는 공통에서 전달한다.
     * </pre>
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "makeGwDraftContent.do")
    public ModelAndView makeGwDraftContent(HttpServletRequest request, Model model,
            @RequestParam(value = "searchId", required = true) String searchId,
            @RequestParam(value = "FORM_CD", required = true) String strFormCd,
            @RequestParam(value = "UPJANG", required = false) String strUpjang,
            @RequestParam(value = "CUSTCD", required = false) String strCustcd,
            @RequestParam(value = "CHK_DD", required = false) String strChkDd,
            @RequestParam(value = "TABLE_TYPE", required = true) String strTableType,
            @RequestParam(value = "CHECK_TYPE", required = false) String strCheckType,
            @RequestParam(value = "CHECK_DATE", required = false) String strCheckDate,
            @RequestParam(value = "IMG_ROOT", required = false) String strImgRoot,
            @RequestParam(value = "CHARGE_SABUN", required = false) String strChargeSabun,
          //2018.05.25 김명섭 하위공장명추가
            @RequestParam(value = "SUB_COMP_NM", required = false) String strSubCompNm,
            @RequestParam(value = "title", required = false, defaultValue = "") String strBodyTitle) throws Exception {

        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        //Map<String, Object> parameter = new HashMap<String, Object>();

        logger.info("searchId :" + searchId);
        logger.info("strFormCd :" + strFormCd);
        logger.info("strUpjang :" + strUpjang);
        logger.info("strCustcd :" + strCustcd);
        logger.info("strChkDd :" + strChkDd);
        logger.info("strTableType :" + strTableType);
        logger.info("strCheckType :" + strCheckType);
        logger.info("strCheckDate :" + strCheckDate);
        logger.info("strImgRoot :" + strImgRoot);
        logger.info("strChargeSabun :" + strChargeSabun);
        logger.info("strSubCompNm :" + strSubCompNm);

        model.addAttribute("gwDraftTitle", strBodyTitle);
        model.addAttribute("gwSearchId", searchId);
        model.addAttribute("gwStrFormCd", strFormCd);
        model.addAttribute("gwStrUpjang", strUpjang);
        model.addAttribute("gwStrCustcd", strCustcd);
        model.addAttribute("gwStrChkDd", strChkDd);
        model.addAttribute("gwStrTableType", strTableType);
        model.addAttribute("gwStrCheckType", strCheckType);
        model.addAttribute("gwStrCheckDate", strCheckDate);
        model.addAttribute("gwStrImgRoot", strImgRoot);
        model.addAttribute("gwStrChargeSabun", strChargeSabun);
        model.addAttribute("gwStrSubCompNm", strSubCompNm);

        // 본문을 생성하는 JSP 호출
        // searchId 별로 그룹웨어 본문생성 jsp를 분기 시킨다.
        String path = "";
        if(searchId.equals("1")) {
        	path = "/gw/fsc/FSC00310E_GwDraft"; // 협력업체 점검결과 상신
        } else if(searchId.equals("2")) {
        	path = "/gw/fsc/FSC00311E_GwDraft"; // 협력업체 개선결과 상신
        } else if(searchId.equals("3")) {
        	path = "/gw/fsc/FSC00020E_GwDraft"; // 위생점검 점검결과 상신
        } else if(searchId.equals("4")) {
        	path = "/gw/fsc/FSC00021E_GwDraft"; // 위생점검 개선결과 상신
        } else if(searchId.equals("5")) {
        	path = "/gw/fsc/FSC00410E_GwDraft"; // CS진단 점검결과 상신
        } else if(searchId.equals("6")) {
        	path = "/gw/fsc/FSC00411E_GwDraft"; // CS진단 개선결과 상신
        } else if(searchId.equals("7")) {
        	path = "/gw/fsc/FSC90020E_GwDraft"; // 안전점검 점검결과 상신
        } else if(searchId.equals("8")) {
        	path = "/gw/fsc/FSC90030E_GwDraft"; // 안전점검 개선결과 상신
        } else if(searchId.equals("9")) {
        	path = "/gw/fsc/FSC00022E_GwDraft"; // 위생점검 점검결과 상신 (마트용)
        }


        return new ModelAndView(path);
    }

    @RequestMapping(value = "makeGwDraftExternalContent.do")
    public ModelAndView makeGwDraftExternalContent(HttpServletRequest request, Model model,
            @RequestParam(value = "UPJANG", required = true) String strUpjang,
            @RequestParam(value = "VISIT_DT", required = false) String strVisitDt,
            @RequestParam(value = "SEQNO", required = false) String strSeqNo,
            @RequestParam(value = "IMG_ROOT", required = false) String strImgRoot,
            @RequestParam(value = "title", required = false, defaultValue = "") String strBodyTitle) throws Exception {

        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        //Map<String, Object> parameter = new HashMap<String, Object>();

        logger.info("########### makeGwDraftExternalContent ###########");
        logger.info("strUpjang :" + strUpjang);
        logger.info("strVisitDt :" + strVisitDt);
        logger.info("strSeqNo :" + strSeqNo);
        logger.info("strImgRoot :" + strImgRoot);

        model.addAttribute("gwDraftTitle", strBodyTitle);
        model.addAttribute("gwStrUpjang", strUpjang);
        model.addAttribute("gwStrVisitDt", strVisitDt);
        model.addAttribute("gwStrSeqNo", strSeqNo);
        model.addAttribute("gwStrImgRoot", strImgRoot);

        // 본문을 생성하는 JSP 호출
        // searchId 별로 그룹웨어 본문생성 jsp를 분기 시킨다.
        String path = "";
    	path = "/gw/fsc/FSC91030E_GwDraft"; // 외부기관 점검결과 상신

        return new ModelAndView(path);
    }
    
}
