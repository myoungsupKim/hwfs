package com.hwfs.ft.fsi.web;

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
import com.hwfs.ft.fsi.service.PbGoalMgmtService;
import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * PbGoalMgmtController에 대한 설명 작성
 * @ClassName PbGoalMgmtController.java
 * @Description PbGoalMgmtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021. 3. 12.   ITO        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 ITO
 * @since 2021. 3. 12.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ft/fsi/pbGoalMgmt/")
public class PbGoalMgmtController extends DefaultController {
	
	@Resource(name = "/ft/fsi/pbGoalMgmtService")
	private PbGoalMgmtService pbGoalMgmtService;
	
	@SuppressWarnings("unchecked")
    @RequestMapping("selectList.xdo")
    public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        ModelAndView mav = super.createModelAndView();
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        RecordSet rs = pbGoalMgmtService.selectList(parameter.get("ds_cond").get(0));
        super.addOutDataSet(mav, "ds_list", rs);
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
	
	
	@SuppressWarnings("unchecked")
    @RequestMapping("selectGrpCdList.xdo")
    public ModelAndView selectGrpCdList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        ModelAndView mav = super.createModelAndView();
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        RecordSet rs = pbGoalMgmtService.selectGrpCdList(parameter.get("ds_cond").get(0));
        super.addOutDataSet(mav, "ds_grpCdSrch", rs);
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
	
	
	@SuppressWarnings("unchecked")
    @RequestMapping("selectGrpGoalList.xdo")
    public ModelAndView selectGrpGoalList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        ModelAndView mav = super.createModelAndView();
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        RecordSet rs = pbGoalMgmtService.selectGrpGoalList(parameter.get("ds_cond").get(0));
        super.addOutDataSet(mav, "ds_list", rs);
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
	
	
	@SuppressWarnings("unchecked")
    @RequestMapping("saveGrpGoalList.xdo")
    public ModelAndView saveGrpGoalList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
		ModelAndView mav = super.createModelAndView();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		DataSetMap paramSet = parameter.get("ds_list");
		int result = pbGoalMgmtService.saveGrpGoalList(paramSet, loginDTO);
		super.addOutVariable(mav, "fv_iProcessCnt", result);
		return mav;
	}
	
	
	
	@SuppressWarnings("unchecked")
    @RequestMapping("saveList.xdo")
    public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
		ModelAndView mav = super.createModelAndView();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		DataSetMap paramSet = parameter.get("ds_list");
		int result = pbGoalMgmtService.saveList(paramSet, loginDTO);
		super.addOutVariable(mav, "fv_iProcessCnt", result);
		return mav;
	}
	
	@SuppressWarnings("unchecked")
    @RequestMapping("deleteList.xdo")
    public ModelAndView deleteList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
		ModelAndView mav = super.createModelAndView();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		DataSetMap paramSet = parameter.get("ds_list");
		int result = pbGoalMgmtService.deleteList(paramSet);
		super.addOutVariable(mav, "fv_iProcessCnt", result);
		return mav;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	

}
