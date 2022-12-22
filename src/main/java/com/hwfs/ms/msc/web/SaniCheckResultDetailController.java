package com.hwfs.ms.msc.web;

import hone.core.util.record.RecordSet;
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
import com.hwfs.ms.msc.service.SaniCheckResultDetailService;


 /**
 * 위생점검결과조회 SaniCheckResultDetail Controller
 * 
 * @ClassName SaniCheckResultDetailController.java
 * @Description SaniCheckResultDetailController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.29                최초생성
 * </pre>
 * @author 
 * @since 2022.07.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ms/msc/saniCheckResultDetail/")
public class SaniCheckResultDetailController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SaniCheckResultDetailService Bean 생성 */
	@Resource(name = "/ms/msc/saniCheckResultDetailService")
	private SaniCheckResultDetailService saniCheckResultDetailService;
	
	/**
	 * 위생점검결과 목록을 조회한다.
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		RecordSet rs = saniCheckResultDetailService.selectList(inVar);
		super.addOutDataSet(mav, "ds_list", rs);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
}
