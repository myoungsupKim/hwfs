package com.hwfs.ls.lcm.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.service.PropertiesService;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lcm.service.IntroFrameLimsService;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

/**
 * IntroFrameLims Controller Class
 *
 * @ClassName IntroFrameLimsController.java
 * @Description IntroFrameLimsController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 20.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 20.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ls/lcm/introFrameLims/")
public class IntroFrameLimsController extends DefaultController {

    /** propertiesService */
    @Autowired
    protected PropertiesService propertiesService;

    @Resource(name = "/ls/lcm/introFrameLimsService")
    private IntroFrameLimsService introFrameLimsService;

    /**
     * Main화면의 리스트를 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectList.xdo")
    public ModelAndView selectList(HttpServletRequest request, @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //2018.06.05 김명섭 LIMS개선: 사후처리내역, 접수대기현황, 결재대기현황 Disp제외
        RecordSet rs = introFrameLimsService.selectGraphList(parameter.get("ds_search").get(0)); // 챠트
        RecordSet rs1 = introFrameLimsService.selectMonthIngList(parameter.get("ds_search").get(0)); // 검사원별 월간 진행현황
        //RecordSet rs2 = introFrameLimsService.selecTestAcceptList(parameter.get("ds_search").get(0)); // 접수대기 현황
        //RecordSet rs3 = introFrameLimsService.selecTestApprvtList(parameter.get("ds_search").get(0)); // 결재대기 현황
        RecordSet rs4 = introFrameLimsService.selecApprvActionList(parameter.get("ds_search").get(0)); // 승인처리 현황
        RecordSet rs5 = introFrameLimsService.selecCheckList(parameter.get("ds_search").get(0)); // 체크리스트 현황
        //RecordSet rs6 = introFrameLimsService.selecAfterProcessHistory(parameter.get("ds_search").get(0)); // 사후처리내역 현황
        RecordSet rs7 = introFrameLimsService.selectUserAuth(parameter.get("ds_search").get(0)); // 사용자권한 조회
        RecordSet rs8 = introFrameLimsService.selectQuickList(parameter.get("ds_search").get(0)); // quickList 조회
        RecordSet rs9 = introFrameLimsService.selectSpecmCntList(parameter.get("ds_search").get(0)); // 금일접수검체수 / 월누계검체수를 조회

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("currDate", LimsUtil.getDate("yyyy년 MM월 dd일"));
        super.addOutDataSet(mav, "ds_retval", retVal);

        super.addOutDataSet(mav, "ds_graph", rs);
        super.addOutDataSet(mav, "ds_monthIng", rs1);
        //super.addOutDataSet(mav, "ds_testAcceptList", rs2);
        //super.addOutDataSet(mav, "ds_testApprvList", rs3);
        super.addOutDataSet(mav, "ds_apprvActionList", rs4);
        super.addOutDataSet(mav, "ds_checkListValue", rs5);
        //super.addOutDataSet(mav, "ds_afterProcessHistory", rs6);
        super.addOutDataSet(mav, "ds_quickList", rs8);
        super.addOutDataSet(mav, "gds_limsAuthLevels", rs7);
        super.addOutDataSet(mav, "ds_specmCnt", rs9);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 검사원별 월간진행현황 리스트를 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectMonthIngList.xdo")
    public ModelAndView selectMonthIngList(HttpServletRequest request,
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs1 = introFrameLimsService.selectMonthIngList(parameter.get("ds_search").get(0)); // 검사원별 월간 진행현황
        RecordSet rs9 = introFrameLimsService.selectSpecmCntList(parameter.get("ds_search").get(0)); // 금일접수검체수 / 월누계검체수를 조회

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_monthIng", rs1);
        super.addOutDataSet(mav, "ds_specmCnt", rs9);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * LIMS 권한 세팅
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @RequestMapping("selectLimsAuthLevels.xdo")
    public ModelAndView selectLimsAuthLevels(HttpServletRequest request, @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        RecordSet rs = introFrameLimsService.selectUserAuth(new HashMap<String, Object>()); // 사용자권한 조회

        super.addOutDataSet(mav, "gds_limsAuthLevels", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 기간별 현황을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectTermCntList.xdo")
    public ModelAndView selectTermCntList(HttpServletRequest request, @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = introFrameLimsService.selectTermCntList(parameter.get("ds_search").get(0));

        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 월별 실적 현황
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectMonthStaticList.xdo")
    public ModelAndView selectMonthStaticList(HttpServletRequest request, @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = introFrameLimsService.selectMonthStaticSpecmList(parameter.get("ds_search").get(0));	// 검체건수
        RecordSet rs1 = introFrameLimsService.selectMonthStaticTestList(parameter.get("ds_search").get(0));	// 검체항목수
        RecordSet rs2 = introFrameLimsService.selectMonthStaticNotFitList(parameter.get("ds_search").get(0));	// 부적합항목수

        super.addOutDataSet(mav, "ds_listMonthSpecm", rs);
        super.addOutDataSet(mav, "ds_listMonthTest", rs1);
        super.addOutDataSet(mav, "ds_listMonthNotFit", rs2);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
