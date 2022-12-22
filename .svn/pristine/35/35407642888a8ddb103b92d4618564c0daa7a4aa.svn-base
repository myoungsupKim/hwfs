package com.hwfs.ms.msc.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

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
import com.hwfs.ms.msc.service.SaniImprovePlanService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 개선계획작성 SaniImprovePlanController
 * 
 * @ClassName SaniImprovePlanController.java
 * @Description SaniImprovePlanController Class 
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
@RequestMapping("/ms/msc/saniImprovePlan/")
public class SaniImprovePlanController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SaniCheckResultDetailService Bean 생성 */
	@Resource(name = "/ms/msc/saniImprovePlanService")
	private SaniImprovePlanService saniImprovePlanService;
	
	/**
	 * 개선계획작성 목록을 조회한다.
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		RecordSet rsMst = saniImprovePlanService.selectMaster(inVar);
		
		if(rsMst.getRowCount() != 0) {
			inVar.put("tableType", rsMst.get(0).get("tableType")) ;
			inVar.put("formCd", rsMst.get(0).get("formCd")) ;
		} else {
			inVar.put("tableType", "") ;
			inVar.put("formCd", "") ;
		}
		
		RecordSet rsDtl = saniImprovePlanService.selectDetail(inVar);
		
		super.addOutDataSet(mav, "ds_master", rsMst);
		super.addOutDataSet(mav, "ds_detail", rsDtl);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	/**
	 * 개선계획작성 목록을 저장한다.
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {

		ModelAndView mav = super.createModelAndView();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		DataSetMap dsDetail = param.get("ds_detail");
		int processCnt = saniImprovePlanService.saveList(dsDetail, loginDTO);
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
