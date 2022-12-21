package com.hwfs.ft.fsi.web;

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
import com.hwfs.ft.fsi.service.PbResultAmtService;

 /**
 * PbResultAmtController에 대한 설명 작성
 * @ClassName PbResultAmtController.java
 * @Description PbResultAmtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021. 3. 30.   ITO        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 ITO
 * @since 2021. 3. 30.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ft/fsi/pbResultAmt/")
public class PbResultAmtController extends DefaultController {
	
	@Resource(name = "/ft/fsi/pbResultAmtService")
	private PbResultAmtService pbResultAmtService;
	
	/**
	 * PB실적조회 리스트
	 * selectList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
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
        RecordSet rs = pbResultAmtService.selectList(parameter.get("ds_cond").get(0));
        super.addOutDataSet(mav, "ds_list", rs);
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
	
	/**
	 * PB코드 리스트
	 * selectPbCode 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
    @RequestMapping("selectPbCode.xdo")
	public ModelAndView selectPbCode(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		ModelAndView mav = super.createModelAndView();
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        RecordSet rs = pbResultAmtService.selectPbCode(parameter.get("ds_cond").get(0));
        super.addOutDataSet(mav, "ds_pbCode", rs);
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
}
