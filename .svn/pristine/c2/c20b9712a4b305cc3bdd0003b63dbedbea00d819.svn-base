package com.hwfs.guide.sample.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hwfs.cmn.defaults.DefaultController;

 /**
 * GuideJSONController에 대한 설명 작성 --> 적용하지 않음
 * @ClassName GuideJSONController.java
 * @Description GuideJSONController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 28.   taiho        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 taiho
 * @since 2015. 7. 28.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/guide/sample/guideJSON/")
public class GuideJSONController extends DefaultController {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@RequestMapping(value = "sample.do")
    public void sample(HttpServletRequest request,
            @RequestParam(value = "data", required = false) String data) throws Exception {

		logger.debug("DATA =>" + data);

        //return new ModelAndView(path);
    }

}
