package com.hwfs.sc.scc.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

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
import com.hwfs.sc.scc.service.HnrSubinvMappingService;


 /**
 * HnrSubinvMapping Controller
 * 
 * @ClassName HnrSubinvMappingController.java
 * @Description HnrSubinvMappingController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 * 
 * </pre>
 * @author 
 * @since 
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scc/hnrSubinvMapping/")
public class HnrSubinvMappingController extends DefaultController {
	
	/** HnrSubinvMappingService Bean 생성 */
	@Resource(name = "/sc/scc/hnrSubinvMappingService")
	private HnrSubinvMappingService hnrSubinvMappingService;
	
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		Map<String, RecordSet> hnrSubinvMappingList = hnrSubinvMappingService.selectList(parameter.get("ds_cond").get(0));
		super.addOutDataSet(mav, "ds_hnrSubinvMappingList", hnrSubinvMappingList.get("hnrSubinvMappingList"));
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {

		ModelAndView mav = super.createModelAndView();
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		DataSetMap paramSet = param.get("ds_list");
		int processCnt = hnrSubinvMappingService.saveList(paramSet, loginDTO);
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
