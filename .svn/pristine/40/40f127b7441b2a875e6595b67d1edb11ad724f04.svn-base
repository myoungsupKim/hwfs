package com.hwfs.ls.ltm.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.ls.ltm.service.TestEndApprvService;
import com.hwfs.sc.cmn.dto.LoginDTO;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

/**
 * 시험완료정보 조회 Controller Class
 *
 * @ClassName TestEndApprvController.java
 * @Description TestEndApprvController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 07.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 07.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ls/ltm/testEndApprv/")
public class TestEndApprvController extends DefaultController {

    @Resource(name = "/ls/ltm/testEndApprvService")
    private TestEndApprvService testEndApprvService;

    /**
     * 시험완료내역을 상태를 저장 한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("saveTestReqStatus.xdo")
    public ModelAndView saveTestReqStatus(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
            HttpServletRequest request) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
        Map<String, Object> param = parameter.get("ds_search").get(0);
        param.put("loginSabun", loginDTO.getSabun());

        Map<String, Object> retVal = testEndApprvService.saveTestReqStatus(parameter.get("ds_testRegList"), param);

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));
        super.addOutDataSet(mav, "ds_retval", retVal);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
