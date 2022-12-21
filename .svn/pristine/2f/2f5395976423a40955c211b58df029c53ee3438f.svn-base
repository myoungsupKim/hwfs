package com.hwfs.ft.fts.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.ft.fts.service.NonarrivAltService;
import com.hwfs.sc.cmn.dto.LoginDTO;

/**
 * 미착대체 Controller Class
 *
 * @ClassName NonarrivAltController.java
 * @Description NonarrivAltController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 06. 12.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : jshoon
 * @since 2015. 06. 12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ft/fts/nonarrivAlt/")
public class NonarrivAltController extends DefaultController {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    @Resource(name = "/ft/fts/nonarrivAltService")
    private NonarrivAltService nonarrivAltService;

    /**
     * PO목록을 조회한다.
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
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = nonarrivAltService.selectList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * PO상세 목록을 조회한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectDetailList.xdo")
    public ModelAndView selectDetailList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = nonarrivAltService.selectDetailList(parameter.get("ds_search").get(0));
        RecordSet rs2 = nonarrivAltService.selectDetailList2(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_detailList", rs);
        super.addOutDataSet(mav, "ds_detailList2", rs2);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 미착내역을 저장한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
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

        Map<String, Object> retVal = nonarrivAltService.saveList(parameter.get("ds_search").get(0),
                parameter.get("ds_detailList"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 수수료 회계전표 IF 버튼 클릭시 SAP
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("createFiscalSlipIf.xdo")
    public ModelAndView createFiscalSlipIf(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap = nonarrivAltService.createFiscalSlip(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_detailList")
                , parameter.get("ds_detailList2")
                );


        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        logger.info("procCnt :"+listMap.get(0).get("procCnt"));
        logger.info("slipNums :"+listMap.get(0).get("slipNums"));
        ArrayList slipNums = (ArrayList)listMap.get(0).get("slipNums");

        String sSlipNums = "";
        for ( int i=0; i <slipNums.size(); i++)
        {
            sSlipNums += slipNums.get(i).toString()+",";
        }
        sSlipNums = sSlipNums.substring(0, sSlipNums.length()-1);
        logger.info("sSlipNums1 :"+sSlipNums);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", listMap.get(0).get("procCnt"));
        super.addOutVariable(mav, "fv_slipNums", sSlipNums);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }


    /**
     * 수수료 회계전표 IF 버튼 클릭시 SAP
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveNonarrivAltDraft.xdo")
    public ModelAndView saveNonarrivAltDraft(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap = nonarrivAltService.saveNonarrivAltDraft(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_detailList")
                , parameter.get("ds_detailList2")
                );


        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        logger.info("procCnt :"+listMap.get(0).get("procCnt"));
        logger.info("slipNums :"+listMap.get(0).get("slipNums"));
        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", listMap.get(0).get("procCnt"));
        super.addOutVariable(mav, "fv_poOrderNum", listMap.get(0).get("poOrderNum"));
        super.addOutVariable(mav, "fv_flag", "UPDATE");

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }

    /**
     * 수수료 회계전표 IF 취소 버튼 클릭시 SAP
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("cancelFiscalSlipIf.xdo")
    public ModelAndView cancelFiscalSlipIf(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        int procCnt  = nonarrivAltService.cancelFiscalSlip(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_detailList")
                , parameter.get("ds_detailList2")
                );

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);
        super.addOutVariable(mav, "fv_flag", "UPDATE");

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }


}
