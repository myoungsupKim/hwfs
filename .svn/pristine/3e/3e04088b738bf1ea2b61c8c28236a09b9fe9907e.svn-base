package com.hwfs.am.ams.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.am.ams.service.EquipmentRequestService;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

/**
 * 전산장비 요청 관리 Controller Class
 *
 * @ClassName EquipmentRequestController.java
 * @Description EquipmentRequestController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.12.06.  김명섭       최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2018.12.06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/am/ams/equipmentRequest/")
public class EquipmentRequestController extends DefaultController {

    @Resource(name = "/am/ams/equipmentRequestService")
    private EquipmentRequestService equipmentRequestService;

    /**
     * 전산장비 관리자 리스트를 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @RequestMapping("selectAdminList.xdo")
    public ModelAndView selectAdminList(HttpServletRequest request,
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

    	// ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		@SuppressWarnings("unchecked")
        RecordSet rs = equipmentRequestService.selectAdminList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_adminList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 전산장비 요청 리스트를 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @RequestMapping("selectList.xdo")
    public ModelAndView selectList(HttpServletRequest request,
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

    	// ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		@SuppressWarnings("unchecked")
        RecordSet rs = equipmentRequestService.selectList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

	/**
	 * 전산장비 요청 정보를 저장한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//사업장 일마감 하는을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = equipmentRequestService.saveList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
 
    /**
     * 전산장비 마스터를 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @RequestMapping("selectEqList.xdo")
    public ModelAndView selectEqList(HttpServletRequest request,
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

    	// ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		@SuppressWarnings("unchecked")
        RecordSet rs = equipmentRequestService.selectEqList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_amsEqList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
	
}