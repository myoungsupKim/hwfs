package com.hwfs.fm.fms.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.fm.fms.service.SmallOrderCtrlMgntService;


@Controller
@RequestMapping("/fm/fms/smallOrderCtrlMgnt/")
public class SmallOrderCtrlMgntController extends DefaultController {
	
	@Resource(name = "/fm/fms/smallOrderCtrlMgntService")
	private SmallOrderCtrlMgntService smallOrderCtrlMgntService;
	
	
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();

		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		RecordSet rs = smallOrderCtrlMgntService.selectList(parameter);

		super.addOutDataSet(mav, "ds_list", rs);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();

		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		int processCnt = smallOrderCtrlMgntService.saveList(parameter);

		
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	@RequestMapping("selectCtrlList.xdo")
	public ModelAndView selectCtrlList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();

		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		RecordSet rs = smallOrderCtrlMgntService.selectCtrlList(inVar);

		super.addOutDataSet(mav, "ds_ctrlList", rs);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
