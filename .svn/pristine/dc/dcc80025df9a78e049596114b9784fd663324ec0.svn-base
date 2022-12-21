package com.hwfs.ls.cmn.web;

import java.util.HashMap;
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
import com.hwfs.ls.cmn.service.SlaTestService;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;

/**
 * Sla I/F Test Controller Class
 *
 * @ClassName SlaTestContoller.java
 * @Description SlaTestContoller Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 8.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 1. 8.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Controller
public class SlaTestContoller extends DefaultController {

    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    @Resource(name = "/ls/cmn/slaTestService")
    private SlaTestService slaTestService;

    @RequestMapping("/ls/cmn/web/slaTest.xdo")
    public ModelAndView slaTest(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request)
            throws Exception {
        ModelAndView mav = createModelAndView();

        // 발생일자:20150612,업장코드:120950,MU코드:2001,CC코드:300301,거래처코드:200002,과세구분:1,금액:0,판매수량:1,영수증번호:1000001
        //procParam.put("p_upmu", "LIMS"); // 업무구분 : LIMS(연구소), IFIS(고도화), FTP(식재도매)
        //procParam.put("p_req_num", strReqNum); // 키값
        //procParam.put("p_occur_date", LimsUtil.getDate("yyyyMMdd")); // 발생일자
        //procParam.put("p_upjang", procRsUpjang.get(0).get("upjang")); // 관리업장코드 - FC 식품분석실
        //procParam.put("p_mu_cd", procRsUpjang.get(0).get("muCd")); // 관리 MU 코드 - FC사업지원부
        ////procParam.put("p_mu_cd", ""); // 관리 MU 코드 - FC사업지원부
        //procParam.put("p_cc_cd", procRsUpjang.get(0).get("ccCd")); // 관리 CC 코드 - 식품분석실
        //procParam.put("p_custcd", procRs.get(0).get("custcd")); // 거래처번호
        //procParam.put("p_vat_gubun", "1"); // 과세 여부
        //procParam.put("p_amt", procRs.get(0).get("commTotAmt")); // 총합계 : 과세여부에 따라 procedure에서 갈라치기
        //procParam.put("p_sal_quantity", 1); // 판매 수량
        //procParam.put("p_cuser", param.get("loginSabun")); // 처리자

        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("p_upmu", 		"LIMSD");
        parameter.put("p_req_num", 	    "R-150602001");
        parameter.put("p_occur_date", 	"20150828");
        parameter.put("p_upjang", 		"120950");
        parameter.put("p_mu_cd", 		"2001");
        parameter.put("p_cc_cd", 		"300301");
        parameter.put("p_custcd", 		"100717");
        parameter.put("p_vat_gubun", 	1);
        //parameter.put("p_uprice", 		430000);
        parameter.put("p_amt", 			430000);
        parameter.put("p_sal_quantity", 1);
        parameter.put("p_cuser", 		"201204452");
        parameter.put("p_param_receipt_num", "1000001");
        parameter.put("p_pay_cd", "7");

        Map<String, Object> retVal = slaTestService.saveSlaTest(parameter);
        logger.debug("*************** slaTest retProcIsrVal value={}", retVal.get("retVal"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutDataSet(mav, "ds_retval", retVal);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
