package com.hwfs.ft.fgp.web;

import hone.core.util.record.Record;
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
import com.hwfs.ft.fgp.service.GdspaymMstService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 물품대금 마스터하는 GdspaymMst Controller
 *
 * @ClassName GdspaymMstController.java
 * @Description GdspaymMstController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.06    kjj        최초생성
 * </pre>
 * @author FC종합전산구축 :  물품대금 마스터 kjj
 * @since 2015.04.06
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ft/fgp/gdspaymMst/")
public class GdspaymMstController extends DefaultController {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** GdspaymMstService Bean 생성 */
    @Resource(name = "/ft/fgp/gdspaymMstService")
    private GdspaymMstService gdspaymMstService;

    /**
     * 물품대금 마스터 관리 목록을 조회한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @RequestMapping("selectList.xdo")
    public ModelAndView selectList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        //물품대금 마스터 관리 을(를) 조회한다.
        RecordSet rs = gdspaymMstService.selectList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_gdspaymList", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }



    /**
     * 물품대금 마스터 관리(을)를 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
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
//		DataSetMap parameter = param.get("ds_list");
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //물품대금 마스터 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = gdspaymMstService.saveList( parameter.get("ds_gdspaymList") );

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
      * 물품대금 삭제
      * <pre>
      *
      * </pre>
      *
      * @param xpDto XPlatformMapDTO
      * @param req HttpServletRequest
      * @return ModelAndView
      * @throws Exception
      */
    @RequestMapping("deleteGdspaymList.xdo")
    public ModelAndView deleteGdspaymList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request)  throws Exception {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        int procCnt  = gdspaymMstService.deleteGdspaymList(loginDTO, parameter.get("ds_search"), parameter.get("ds_gdspaymList"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }


    /**
     * 물품대금 회계전표 IF 버튼 클릭시 SAP
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
        List<Map<String, Object>> listMap  = gdspaymMstService.createFiscalSlip(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_gdspaymList")
                );

//        logger.info("procCnt :"+procCnt);

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
        logger.info("sSlipNums :"+sSlipNums);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", listMap.get(0).get("procCnt"));
        super.addOutVariable(mav, "fv_slipNums", sSlipNums);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 물품대금(수입) 결재 정보를 등록한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveIncomDraft.xdo")
    public ModelAndView saveIncomDraft(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = gdspaymMstService.saveIncomDraft(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_gdspaymList")
                );

        logger.info("procCnt :"+listMap.get(0).get("procCnt"));
        logger.info("poOrderNum :"+listMap.get(0).get("poOrderNum"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", listMap.get(0).get("procCnt"));
        super.addOutVariable(mav, "fv_poOrderNum", listMap.get(0).get("poOrderNum"));
        super.addOutVariable(mav, "fv_flag", "UPDATE");

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 물품대금(수입) 결재 정보를 등록한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveDmtDraft.xdo")
    public ModelAndView saveDmtDraft(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = gdspaymMstService.saveIncomDraft(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_gdspaymList")
                );

        logger.info("procCnt :"+listMap.get(0).get("procCnt"));
        logger.info("poOrderNum :"+listMap.get(0).get("poOrderNum"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", listMap.get(0).get("procCnt"));
        super.addOutVariable(mav, "fv_poOrderNum", listMap.get(0).get("poOrderNum"));
        super.addOutVariable(mav, "fv_flag", "UPDATE");

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 물품대금 회계전표 IF 취소 버튼 클릭시 SAP
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
        int procCnt  = gdspaymMstService.cancelFiscalSlip(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_gdspaymList")
                );

        logger.info("procCnt :"+procCnt);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);
        super.addOutVariable(mav, "fv_flag", "UPDATE");

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 물품대금 마스터(내수) 관리 목록을 조회한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @RequestMapping("selectList2.xdo")
    public ModelAndView selectList2(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        String sabun = loginDTO.getSabun();
        logger.info("sabun :"+sabun);
        parameter.get("ds_search").get(0).put("sabun", sabun);
        //물품대금 마스터 관리 을(를) 조회한다.
        RecordSet rs = gdspaymMstService.selectList2(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_gdspaymList", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }


    /**
     * 물품대금 마스터(내수) 관리(을)를 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("saveList2.xdo")
    public ModelAndView saveList2(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
//		DataSetMap parameter = param.get("ds_list");
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //물품대금 마스터 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = gdspaymMstService.saveList2( parameter.get("ds_gdspaymList") );

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
      * 물품대금(내수) 삭제
      * <pre>
      *
      * </pre>
      *
      * @param xpDto XPlatformMapDTO
      * @param req HttpServletRequest
      * @return ModelAndView
      * @throws Exception
      */
    @RequestMapping("deleteDmtGdspaymList.xdo")
    public ModelAndView deleteDmtGdspaymList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request)  throws Exception {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        int procCnt  = gdspaymMstService.deleteGdspaymList(loginDTO, parameter.get("ds_search"), parameter.get("ds_gdspaymList"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 물품대금 회계전표(내수) IF 버튼 클릭시 SAP
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("createDmtFiscalSlipIf.xdo")
    public ModelAndView createDmtFiscalSlipIf(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = gdspaymMstService.createDmtFiscalSlip(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_gdspaymList")
                );

        logger.info("procCnt :"+listMap.get(0).get("procCnt"));
        logger.info("slipNums :"+listMap.get(0).get("slipNums"));
        ArrayList slipNums = (ArrayList)listMap.get(0).get("slipNums");

        String sSlipNums = "";
        for ( int i=0; i <slipNums.size(); i++)
        {
            sSlipNums += slipNums.get(i).toString()+",";
        }
        sSlipNums = sSlipNums.substring(0, sSlipNums.length()-1);
        logger.info("sSlipNums11 :"+sSlipNums);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", listMap.get(0).get("procCnt"));
        super.addOutVariable(mav, "fv_slipNums", sSlipNums);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 물품대금 회계전표 IF 취소 버튼 클릭시 SAP
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("cancelDmtFiscalSlipIf.xdo")
    public ModelAndView cancelDmtFiscalSlipIf(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        int procCnt  = gdspaymMstService.cancelDmtFiscalSlip(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_gdspaymList")
                );

        logger.info("procCnt :"+procCnt);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);
        super.addOutVariable(mav, "fv_flag", "UPDATE");

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

   /**
     * 물품대금 회계전표(내수) IF 버튼 클릭시 SAP
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("createMinusDmtFiscalSlipIf.xdo")
    public ModelAndView createMinusDmtFiscalSlipIf(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        int procCnt  = gdspaymMstService.createMinusDmtFiscalSlipIf(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_gdspaymList")
                );

        logger.info("procCnt :"+procCnt);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);
        super.addOutVariable(mav, "fv_flag", "UPDATE");

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

       /**
         * 물품대금 회계전표 IF 취소 버튼 클릭시 SAP
         * <pre>
         *
         * </pre>
         *
         * @param xpDto XPlatformMapDTO
         * @param req HttpServletRequest
         * @return ModelAndView
         * @throws Exception
         */
        @RequestMapping("cancelMinusDmtFiscalSlipIf.xdo")
        public ModelAndView cancelMinusDmtFiscalSlipIf(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
            //ModeAndView를 생성한다.
            ModelAndView mav = super.createModelAndView();

            //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
            Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
            LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
            int procCnt  = gdspaymMstService.cancelMinusDmtFiscalSlipIf(
                    loginDTO
                    , parameter.get("ds_search")
                    , parameter.get("ds_gdspaymList")
                    );

            logger.info("procCnt :"+procCnt);

            //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
            super.addOutVariable(mav, "fv_iProcessCnt", procCnt);
            super.addOutVariable(mav, "fv_flag", "UPDATE");

            //ModelAndView를 설정한다.
            return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
        }

        /**
         * 과세유형 가져오기
         * <pre>
         *
         * </pre>
         *
         * @param xpDto XPlatformMapDTO
         * @param req HttpServletRequest
         * @return ModelAndView
         * @throws Exception
         */
        @RequestMapping(value = "getVatClassCd.xdo")
        public ModelAndView getVatClassCd(
                @Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
              , HttpServletRequest req) throws Exception {
            ModelAndView mav = super.createModelAndView();
            //조회 조건 파라미터를 얻는다.
            Map<String, DataSetMap> parameter = xpDto.getInDataSetMap();
            //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
            logger.info( "ds_search :"+parameter.get("ds_search").get(0));
            Record rd = gdspaymMstService.getVatClassCd(parameter.get("ds_search").get(0));
            logger.info( "rd :"+rd);

            //XPlatform으로 넘겨줄 Dataset을 설정한다.
            String vatClassCd = "";
            String vatClassNm = "";
            if ( rd != null )
            {
                logger.info( "code"+rd.get("code"));
                vatClassCd = rd.get("code").toString();
                vatClassNm = rd.get("codeName").toString();
            }

            super.addOutVariable(mav, "fv_vatClassCd", vatClassCd);
            super.addOutVariable(mav, "fv_vatClassNm", vatClassNm);

            //ModelAndView를 설정한다.
            return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
         }
}
