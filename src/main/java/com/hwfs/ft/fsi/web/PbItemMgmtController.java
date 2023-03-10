package com.hwfs.ft.fsi.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.ft.fsi.service.PbItemMgmtService;
import com.hwfs.sc.cmn.dto.LoginDTO;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

/**
*  
*
* @ClassName  
* @Description  
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
@RequestMapping("/ft/fsi/pbItemMgmt/")
public class PbItemMgmtController extends DefaultController {

    @Resource(name = "/ft/fsi/pbItemMgmtService")
    private PbItemMgmtService pbItemMgmtService;

    /**
     * 조회
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectList.xdo")
    public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        ModelAndView mav = super.createModelAndView();
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        
        RecordSet rs = pbItemMgmtService.selectList(parameter.get("ds_cond").get(0));
        super.addOutDataSet(mav, "ds_list", rs);
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 중복체크
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectItemCode.xdo")
    public ModelAndView selectItemCode(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
    	ModelAndView mav = super.createModelAndView();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		DataSetMap paramSet = parameter.get("ds_list2");
		DataSetMap paramCond = parameter.get("ds_cond");
		
		String result = pbItemMgmtService.selectItemCode(paramSet, paramCond);
		super.addOutVariable(mav, "fv_itemCodeList", result);
		
		return mav;
    }
    
    /**
     * 저장
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("saveList.xdo")
    public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
    	ModelAndView mav = super.createModelAndView();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		DataSetMap paramCond = parameter.get("ds_cond");
		DataSetMap paramSet = parameter.get("ds_list");
		DataSetMap paramCol = parameter.get("ds_listUpdateCol");
		 
		int result = pbItemMgmtService.saveList(paramCond, paramSet, paramCol, loginDTO);
		super.addOutVariable(mav, "fv_iProcessCnt", result);
		
		return mav;
    }
  
}
