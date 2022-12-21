package com.hwfs.fm.fmp.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.fm.fmp.service.WhPackModifyService;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

/**
 * 창고일괄변경 Controller Class
 *
 * @ClassName WhPackModifyController.java
 * @Description WhPackModifyController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 5.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 8. 5.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fmp/whPackModify/")
public class WhPackModifyController extends DefaultController {

    @Resource(name = "/fm/fmp/whPackModifyService")
    private WhPackModifyService whPackModifyService;

    /**
     * 창고일괄변경 목록을 조회한다
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectList.xdo")
    public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        RecordSet rs = whPackModifyService.selectList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 일자, 시간을 조회한다
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @RequestMapping("selectDdayTimeList.xdo")
    public ModelAndView selectDdayList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        RecordSet rs = whPackModifyService.selectDdayList(new HashMap<String, Object>());
        RecordSet rs1 = whPackModifyService.selectDtimesList(new HashMap<String, Object>());

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_dayList", rs);
        super.addOutDataSet(mav, "ds_timeList", rs1);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 일자 시간을 저장
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @RequestMapping("modifyList.xdo")
    public ModelAndView modifyList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        Map<String, Object> retVal = whPackModifyService.modifyList(parameter.get("ds_list"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 일괄 일자 시간을 저장
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("modifyAllList.xdo")
    public ModelAndView modifyAllList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        Map<String, Object> retVal = whPackModifyService.modifyAllList(parameter.get("ds_search").get(0),
                parameter.get("ds_list"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
