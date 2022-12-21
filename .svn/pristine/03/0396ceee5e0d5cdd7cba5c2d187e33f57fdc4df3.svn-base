package com.hwfs.ls.cmn.web;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;

/**
 * 시험양식서 sample.pdf 만들어 upload에 복사한다.
 *
 * @ClassName DocTest.java
 * @Description DocTest Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 8.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 1. 8.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Controller
public class DocTest extends DefaultController {

    @RequestMapping("/ls/cmn/web/docTest.xdo")
    public ModelAndView test(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request)
            throws Exception {
        ModelAndView mav = createModelAndView();

        DataSetMap paramsMap = (DataSetMap) xpDTO.getInDataSetMap().get("dsInput");

        String realpath = propertiesService.getString("global.filerepository.path");
        String realImgPath = propertiesService.getString("global.imagerepository.path");

        @SuppressWarnings("unchecked")
        Map<String, String> parameter = paramsMap.get(0);
        parameter.put("realpath", realpath);
        parameter.put("realImgPath", realImgPath);

        try {
            CreatePdf.createPdf(parameter);
        } catch (Exception e) {
            return setResultSet(mav, DefaultConsts.ERR_CODE, e.getMessage());
        }

        return setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
