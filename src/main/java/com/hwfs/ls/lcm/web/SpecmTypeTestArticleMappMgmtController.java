package com.hwfs.ls.lcm.web;

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
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lcm.service.SpecmTypeTestArticleMappMgmtService;

/**
 * 검체유형 시험항목 관리 Controller Class
 *
 * @ClassName SpecmTypeTestArticleMappMgmtController.java
 * @Description SpecmTypeTestArticleMappMgmtController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 16.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 16.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ls/lcm/specmTypeTestArticleMappMgmt/")
public class SpecmTypeTestArticleMappMgmtController extends DefaultController {

    @Resource(name = "/ls/lcm/specmTypeTestArticleMappMgmtService")
    private SpecmTypeTestArticleMappMgmtService specmTypeTestArticleMappMgmtService;

    /**
     * 검체유형 시험항목을 조회한다.
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

        Map<String, Object> param = parameter.get("ds_search").get(0);
        //param.put("insptPurp", "101");
        //RecordSet rs01 = specmTypeTestArticleMappMgmtService.selectList(param);	// 공전법1
        //param.put("insptPurp", "102");
        //RecordSet rs02 = specmTypeTestArticleMappMgmtService.selectList(param);	// 공전법2
        param.put("insptPurp", "103");
        RecordSet rs03 = specmTypeTestArticleMappMgmtService.selectList(param);	// 내부시험법1
        //param.put("insptPurp", "104");
        //RecordSet rs04 = specmTypeTestArticleMappMgmtService.selectList(param);	// 내부시험법2

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        //super.addOutDataSet(mav, "ds_testArticleList01", rs01);
        //super.addOutDataSet(mav, "ds_testArticleList02", rs02);
        super.addOutDataSet(mav, "ds_testArticleList01", rs03);
        //super.addOutDataSet(mav, "ds_testArticleList04", rs04);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 검체유형 시험항목을 저장한다.
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

        String paramDataSet = "ds_testArticleList01";
        /*
        Map<String, Object> param = parameter.get("ds_search").get(0);
        if (LimsUtil.checkNull(param.get("insptPurp")).equals("101")) {
            paramDataSet = "ds_testArticleList01";
        } else if (LimsUtil.checkNull(param.get("insptPurp")).equals("102")) {
            paramDataSet = "ds_testArticleList02";
        } else if (LimsUtil.checkNull(param.get("insptPurp")).equals("103")) {
            paramDataSet = "ds_testArticleList03";
        } else if (LimsUtil.checkNull(param.get("insptPurp")).equals("104")) {
            paramDataSet = "ds_testArticleList04";
        }
        */
        Map<String, Object> retVal = specmTypeTestArticleMappMgmtService.saveList(parameter.get("ds_search"),
                parameter.get(paramDataSet));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));
        super.addOutDataSet(mav, "ds_retval", retVal);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 전체 삭제 한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("saveDelAllList.xdo")
    public ModelAndView saveDelAllList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        String paramDataSet = "ds_testArticleList01";
        /*
        Map<String, Object> param = parameter.get("ds_search").get(0);
        if (LimsUtil.checkNull(param.get("insptPurp")).equals("101")) {
            paramDataSet = "ds_testArticleList01";
        } else if (LimsUtil.checkNull(param.get("insptPurp")).equals("102")) {
            paramDataSet = "ds_testArticleList02";
        } else if (LimsUtil.checkNull(param.get("insptPurp")).equals("103")) {
            paramDataSet = "ds_testArticleList03";
        } else if (LimsUtil.checkNull(param.get("insptPurp")).equals("104")) {
            paramDataSet = "ds_testArticleList04";
        }
        */
        Map<String, Object> retVal = specmTypeTestArticleMappMgmtService.saveDelAllList(parameter.get("ds_search"),
                parameter.get(paramDataSet));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));
        super.addOutDataSet(mav, "ds_retval", retVal);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 엑셀업로드 검체유형 시험항목을 저장한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("saveExlList.xdo")
    public ModelAndView saveExlList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //System.out.println(">>>>>>>>>>>>>>>>>>>>specmTypeTestArticleMappMgmtController.saveExlList start<<<<<<<<<<<<<<<<<");
        
        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> retVal = specmTypeTestArticleMappMgmtService.saveExlList(parameter.get("ds_excelDtlList"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));
        super.addOutDataSet(mav, "ds_retval", retVal);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }   
   
    /**
     * 검체유형 시험항목을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectMappingList.xdo")
    public ModelAndView selectMappingList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> param = parameter.get("ds_search").get(0);
        RecordSet rs = specmTypeTestArticleMappMgmtService.selectMappingList(param);

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_testMappingList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
