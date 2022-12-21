package com.hwfs.ls.lrm.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lrm.service.TestRegInqueryService;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

/**
 * 접수정보 조회 Controller Class
 *
 * @ClassName TestRegInqueryController.java
 * @Description TestRegInqueryController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 19.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 19.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ls/lrm/testRegInquery/")
public class TestRegInqueryController extends DefaultController {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource(name = "/ls/lrm/testRegInqueryService")
    private TestRegInqueryService testRegInqueryService;

    /**
     * 접수목록을 조회한다.
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

        RecordSet rs = testRegInqueryService.selectList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_testRegList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 접수목록을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectAcceptSpecmList.xdo")
    public ModelAndView selectAcceptSpecmList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = testRegInqueryService.selectAcceptSpecmList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_specmArticleList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 접수내역을 상태를 저장 한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("saveTestReqStatus.xdo")
    public ModelAndView saveTestReqStatus(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> retVal = testRegInqueryService.saveTestReqStatus(parameter.get("ds_testRegList"),
                parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));
        super.addOutDataSet(mav, "ds_retval", retVal);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 라벨출력 대상 목록 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectSpecmLabelPrtList.xdo")
    public ModelAndView selectSpecmLabelPrtList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = testRegInqueryService.selectSpecmLabelPrtList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_testRegList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 시험결과 구매 전송 대상 목록을 조회
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("testResultItemSendMgmtList.xdo")
    public ModelAndView testResultItemSendMgmtList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = testRegInqueryService.testResultItemSendMgmtList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_testRegList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 구매자재 정보를 일괄 등록한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @RequestMapping("saveItemSendResult.xdo")
    public ModelAndView saveItemSendResult(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> retVal = testRegInqueryService.saveItemSendResult(parameter.get("ds_testRegList"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.
     * <pre>
     * - RequestMapping은 .do로 해야 한다.
     * - 상신을 위한 본문은 DB에서 쿼리하여 JSP를 이용하여 동적으로 HTML 본문을 만든다.
     * - JSP 본문 양식은 WEB-INF/jsp에서 관리한다.
     * - 본문 title 파라미터는 공통에서 전달한다.
     * </pre>
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "makeGwDraftContent.do")
    public ModelAndView makeGwDraftContent(HttpServletRequest request, Model model,
            @RequestParam(value = "searchId", required = true) String strId,
            @RequestParam(value = "acceptNum", required = true) String acceptNum,
            @RequestParam(value = "insptPurp", required = true) String strInsptPurp,
            @RequestParam(value = "insptMtod", required = true) String strInsptMtod,
            @RequestParam(value = "materialSendResult", required = true) String strMaterialSendResult,
            @RequestParam(value = "materialUpjangSendResult", required = true) String strMaterialUpjangSendResult,
            @RequestParam(value = "title", required = false, defaultValue = "") String strBodyTitle) throws Exception {

        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        Map<String, Object> parameter = new HashMap<String, Object>();

        logger.info("strId :" + strId);
        logger.info("acceptNum :" + acceptNum);
        logger.info("strInsptPurp :" + strInsptPurp);
        logger.info("strInsptMtod :" + strInsptMtod);
        logger.info("strMaterialSendResult :" + strMaterialSendResult);
        logger.info("strMaterialUpjangSendResult :" + strMaterialUpjangSendResult);
        parameter.put("reqNum", strId);
        parameter.put("acceptNum", acceptNum);

        Record rs = null;
        Record rs1 = null;
        RecordSet rs2 = null;
        // S:Q-Stop, P:Q-Pass
        if (strMaterialSendResult.equals("S")) {
            rs = testRegInqueryService.testResultItemSendMasterList(parameter); // 시험결과 마스터을 조회한다.
            rs1 = testRegInqueryService.testResultItemSendSpecmInfoList(parameter); // 시험결과 검체정보를 조회한다.
            rs2 = testRegInqueryService.testResultItemSendTestInfoList(parameter); // 시험결과 시험정보를 조회한다.
        } else {
            rs = testRegInqueryService.testResultItemSendMasterList(parameter); // 시험결과 마스터을 조회한다.
            parameter.put("upjang", LimsUtil.checkNull(rs.get("upjang")));
            parameter.put("specmCd", LimsUtil.checkNull(rs.get("specmCd")));
            rs2 = testRegInqueryService.testResultItemSendSpecmInfoPassList(parameter); // 시험결과 검체정보를 조회한다.
        }

        model.addAttribute("gwDraftMaster", rs);
        if (strMaterialSendResult.equals("S")) {
            model.addAttribute("gwDraftSpecmInfo", rs1);
            model.addAttribute("gwDraftTestInfo", rs2);
        } else {
            model.addAttribute("gwDraftSpecmInfo", rs2);
        }
        model.addAttribute("gwDraftTitle", strBodyTitle);
        model.addAttribute("gwInsptPurp", strInsptPurp);
        model.addAttribute("gwInsptMtod", strInsptMtod);
        model.addAttribute("gwMaterialSendResult", strMaterialSendResult);
        model.addAttribute("gwmaterialUpjangSendResult", strMaterialUpjangSendResult);

        //본문을 생성하는 JSP 호출
        String path = "";
        if (strMaterialSendResult.equals("S")) {
            path = "/gw/lrm/TestResultItemSendStopGwDraft";
        } else {
            path = "/gw/lrm/TestResultItemSendPassGwDraft";
        }

        return new ModelAndView(path);
    }

    /**
     * 기 접수내역 목록조회
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("preAcceptReqInfoList.xdo")
    public ModelAndView preAcceptReqInfoList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = testRegInqueryService.preAcceptReqInfoList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_testRegList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
