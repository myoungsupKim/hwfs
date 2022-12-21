package com.hwfs.ft.ftr.web;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.ft.ftr.service.SapSlipCreateStatusService;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

/**
* SAP 전표 생성 현황(도매유통)을 조회하는 SapSlipCreateStatus Controller
* @ClassName SapSlipCreateStatusController.java
* @Description SapSlipCreateStatusController Class 
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2016. 2. 3.   Administrator        최초생성
* </pre>
* @author FC종합전산구축 : 팀명 Administrator
* @since 2016. 2. 3.
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Controller
@RequestMapping("/ft/ftr/sapSlipCreateStatus/")
public class SapSlipCreateStatusController extends DefaultController {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());


    /** SapSlipSendStatusService Bean 생성 */
    @Resource(name = "/ft/ftr/sapSlipCreateStatusService")
    private SapSlipCreateStatusService sapSlipCreateStatusService;

    /**
	 * SAP 전표 생성 현황(도매유통) 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
    @SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
    public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception
    {
    	// XPLATFORM에 결과를 전달할 객체 생성
    	ModelAndView mav = super.createModelAndView();

    	// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
    	Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

    	// Dataset에서 첫번째 행의 정보만 추출한다.
    	Map<String, Object> parameter = param.get("ds_search").get(0);

        // SAP 전표 생성 현황(도매유통) 목록을 조회한다.
        RecordSet rs = sapSlipCreateStatusService.selectList(parameter);

    	// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
    	super.addOutDataSet(mav, "ds_list", rs);

    	// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
}
