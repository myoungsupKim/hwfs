package com.hwfs.ls.lrm.web;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lrm.service.TestInfoRegService;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

/**
 * 접수정보 등록 Controller Class
 *
 * @ClassName TestInfoRegController.java
 * @Description TestInfoRegController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 23.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 23.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ls/lrm/testInfoReg/")
public class TestInfoRegController extends DefaultController {

    @Resource(name = "/ls/lrm/testInfoRegService")
    private TestInfoRegService testInfoRegService;

    /**
     * 시험항목목록을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectTestArticleList.xdo")
    public ModelAndView selectTestArticleList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = testInfoRegService.selectTestArticleList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_testArticleList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 사업장목록을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectUpjangList.xdo")
    public ModelAndView selectUpjangList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = testInfoRegService.selectUpjangList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_upjangList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 접수내역을 조회한다.
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

        RecordSet rs = testInfoRegService.selectTestReqAcceptList(parameter.get("ds_search").get(0));
        RecordSet rs1 = testInfoRegService.selectSpecmInfoList(parameter.get("ds_search").get(0));
        RecordSet rs2 = testInfoRegService.selectTestInfoList(parameter.get("ds_search").get(0));

        super.addOutDataSet(mav, "ds_testReqAccept", rs);
        super.addOutDataSet(mav, "ds_specmArticleList", rs1);
        super.addOutDataSet(mav, "ds_testArticleListTmp", rs2);

        Map<String, Object> param = parameter.get("ds_search").get(0);
        // 각 조회화면에서 접수정보상세를 볼때 진행사항 조회
        if (LimsUtil.checkNull(param.get("searchGubun")).equals("TestInfoRegDtl")) {
            RecordSet rs3 = testInfoRegService.selectTestInfoProgressList(param);
            super.addOutDataSet(mav, "ds_testInfoProgress", rs3);
        }

        // 개인정보보호 접근로그를 쌓는다. 조회조건과 조회 건수
        accessLogService.readLog(parameter.get("ds_search").get(0), rs.size());

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 접수시험정보를 저장한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("saveList.xdo")
    public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> retVal = testInfoRegService.saveList(parameter.get("ds_testReqAccept"),
                parameter.get("ds_specmArticleList"), parameter.get("ds_testArticleList"), parameter.get("ds_paramValue"));

        // 개인정보보호 접근로그를 쌓는다.
        accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"REQ_USER_TELNO, REQ_USER_EMAIL"}));

        retVal.put("maskAuth", parameter.get("ds_search").get(0).get("maskAuth"));
        RecordSet rs = testInfoRegService.selectTestReqAcceptList(retVal);
        RecordSet rs1 = testInfoRegService.selectSpecmInfoList(retVal);
        RecordSet rs2 = testInfoRegService.selectTestInfoList(retVal);

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));
        super.addOutDataSet(mav, "ds_retval", retVal);
        super.addOutDataSet(mav, "ds_testReqAccept", rs);
        super.addOutDataSet(mav, "ds_specmArticleList", rs1);
        super.addOutDataSet(mav, "ds_testArticleListTmp", rs2);

        if (parameter.get("ds_search") != null) {
            Map<String, Object> param = parameter.get("ds_search").get(0);
            // 각 조회화면에서 접수정보상세를 볼때 진행사항 조회
            if (LimsUtil.checkNull(param.get("searchGubun")).equals("TestInfoRegDtl")) {
                RecordSet rs3 = testInfoRegService.selectTestInfoProgressList(param);
                super.addOutDataSet(mav, "ds_testInfoProgress", rs3);
            }

            // 개인정보보호 접근로그를 쌓는다. 조회조건과 조회 건수
            accessLogService.readLog(parameter.get("ds_search").get(0), rs.size());
        } else {
            // 개인정보보호 접근로그를 쌓는다. 조회조건과 조회 건수
            accessLogService.readLog(retVal, rs.size());
        }

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 접수시험정보를 임시저장한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     * @since 20171109
     * @author 유선미
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("saveTemp.xdo")
    public ModelAndView saveTemp(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> retVal = testInfoRegService.saveTemp(parameter.get("ds_testReqAccept"),
                parameter.get("ds_specmArticleList"), parameter.get("ds_testArticleList"));

        // 개인정보보호 접근로그를 쌓는다.
        accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"REQ_USER_TELNO, REQ_USER_EMAIL"}));

        retVal.put("maskAuth", parameter.get("ds_search").get(0).get("maskAuth"));
        RecordSet rs = testInfoRegService.selectTestReqAcceptListTemp(retVal);
        RecordSet rs1 = testInfoRegService.selectSpecmInfoListTemp(retVal);
        RecordSet rs2 = testInfoRegService.selectTestInfoListTemp(retVal);

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));
        super.addOutDataSet(mav, "ds_retval", retVal);
        super.addOutDataSet(mav, "ds_testReqAccept", rs);
        super.addOutDataSet(mav, "ds_specmArticleList", rs1);
        super.addOutDataSet(mav, "ds_testArticleListTmp", rs2);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 임시저장 불러오기 팝업 목록 조회
     *
     * @param xpDTO
     * @return
     * @throws Exception
     * @since 20171109
     * @author 유선미
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectLoadTestInfoTempList.xdo")
    public ModelAndView selectLoadTestInfoTempList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = testInfoRegService.selectLoadTestInfoTempList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 임시저장한 접수내역을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     * @since 20171109
     * @author 유선미
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectLoadTemp.xdo")
    public ModelAndView selectLoadTemp(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = testInfoRegService.selectTestReqAcceptListTemp(parameter.get("ds_search").get(0));
        RecordSet rs1 = testInfoRegService.selectSpecmInfoListTemp(parameter.get("ds_search").get(0));
        RecordSet rs2 = testInfoRegService.selectTestInfoListTemp(parameter.get("ds_search").get(0));

        super.addOutDataSet(mav, "ds_testReqAccept", rs);
        super.addOutDataSet(mav, "ds_specmArticleList", rs1);
        super.addOutDataSet(mav, "ds_testArticleListTmp", rs2);

        // 개인정보보호 접근로그를 쌓는다. 조회조건과 조회 건수
        accessLogService.readLog(parameter.get("ds_search").get(0), rs.size());

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
