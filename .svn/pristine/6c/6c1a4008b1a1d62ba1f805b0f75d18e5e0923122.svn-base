package com.hwfs.ft.ftp.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
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
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.ft.fsi.service.FtSapInterfaceService;
import com.hwfs.ft.ftp.service.PoOrderMstService;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AttachFileService;


 /**
 * 구매 주문에 대한 내역을 등록 관리.하는 PoOrderMst Controller
 *
 * @ClassName PoOrderMstController.java
 * @Description PoOrderMstController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.16    김종준        최초생성
 * </pre>
 * @author FC종합전산구축 :  식재도매 김종준
 * @since 2015.03.16
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ft/ftp/poOrderMst/")
public class PoOrderMstController extends DefaultController {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** PoOrderMstService Bean 생성 */
    @Resource(name = "/ft/ftp/poOrderMstService")
    private PoOrderMstService poOrderMstService;

    /** File Attach Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    /** FtSapInterfaceService Bean 생성 */
    @Resource(name = "/ft/fsi/ftSapInterfaceService")
    private FtSapInterfaceService ftSapInterfaceService;
    /**
     * 구매 주문에 대한 내역. 목록을 조회한다.
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
    @RequestMapping("selectPoOrderMstList.xdo")
    public ModelAndView selectPoOrderMstList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        logger.info( "ds_search :"+parameter.get("ds_search").get(0));

        //구매 주문에 대한 내역. 을(를) 조회한다.
        RecordSet rs = poOrderMstService.selectList(parameter.get("ds_search").get(0));



        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_poOrderList", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 구매 주문에 대한 내역.(을)를 Insert/Update/Delete 처리한다.
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
        DataSetMap parameter = param.get("ds_list");

        //구매 주문에 대한 내역.을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = poOrderMstService.saveList(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_processCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
      * 구매주문 삭제
      * <pre>
      *
      * </pre>
      *
      * @param xpDto XPlatformMapDTO
      * @param req HttpServletRequest
      * @return ModelAndView
      * @throws Exception
      */
    @RequestMapping("deletePoOrderMst.xdo")
    public ModelAndView deletePoProposalMst(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request)  throws Exception {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        int procCnt  = poOrderMstService.deletePoOrderMst(loginDTO, parameter.get("ds_search"), parameter.get("ds_poOrderList"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
      * 품의 상신
      * <pre>
      *
      * </pre>
      *
      * @param xpDto XPlatformMapDTO
      * @param req HttpServletRequest
      * @return ModelAndView
      * @throws Exception
      */
    @RequestMapping("updatePoOrderStatus.xdo")
    public ModelAndView updatePoOrderStatus(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        int procCnt  = poOrderMstService.updatePoOrderStatus(loginDTO, parameter.get("ds_search"), parameter.get("ds_poOrderList"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 구매 주문에 대한 상세내역. 목록을 조회한다.
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
    @RequestMapping("selectPoOrderDtl.xdo")
    public ModelAndView selectPoOrderDtl(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //구매 주문에 대한 내역. 을(를) 조회한다.
        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        RecordSet rs = poOrderMstService.selectPoOrderDtl(parameter.get("ds_search").get(0));			//구매 품의 마스터을 조회한다.
        RecordSet rs1 = poOrderMstService.selectPoOrderItemDetail(parameter.get("ds_search").get(0));	//구매 주문 품목 상세를 조회한다.
        RecordSet rs2 = poOrderMstService.selectPoOrderPayCond(parameter.get("ds_search").get(0));		//구매 주문 지불 조건를 조회한다.
        RecordSet rs3 = poOrderMstService.selectPoOrderInvoice(parameter.get("ds_search").get(0));		//구매주문 INVOICE를 조회한다.
        RecordSet rs5 = poOrderMstService.selectPoOrderOtherAmt(parameter.get("ds_search").get(0));		//구매주문 부대비를 조회한다.
        RecordSet rs6 = poOrderMstService.selectEtcPrepayamtAdjust(parameter.get("ds_search").get(0));	//기타 선급금 정산를 조회한다.
        RecordSet rs7 = poOrderMstService.selectbasiNumList(parameter.get("ds_search").get(0));			//통관 수입면허번호 조회한다.
        RecordSet rs8 = poOrderMstService.selectCommSalsList(parameter.get("ds_search").get(0));			//통관 수입면허번호 조회한다.

        //첨부파일 참조일련번호를 얻는다.
        String strRefSeq =rs.get(0).getString("fileRefSrlNum");

        //첨부파일 조회 Service 호출
        List<Map> rs4 = null;

        if ( strRefSeq != null )
        {
            rs4 = attachFileService.selectList(strRefSeq);	  //구매주문 첨부문서를 조회한다.
        }

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_poOrderInfo", rs);
        super.addOutDataSet(mav, "ds_itemList", rs1);
        super.addOutDataSet(mav, "ds_payList", rs2);
        super.addOutDataSet(mav, "ds_invoiceList", rs3);
        super.addOutDataSet(mav, "ds_file", rs4);
        super.addOutDataSet(mav, "ds_otherAmtList", rs5);
        super.addOutDataSet(mav, "ds_etcPrepayamtList", rs6);
        super.addOutDataSet(mav, "ds_basiNum", rs7);
        super.addOutDataSet(mav, "ds_commSals", rs8);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 품의 구매(수입)를 등록한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("savePoOrderDtl.xdo")
    public ModelAndView savePoOrderDtl(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = poOrderMstService.savePoOrderDtl(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_poOrderInfo")
                , parameter.get("ds_itemList")
                , parameter.get("ds_payList")
                , parameter.get("ds_invoiceList")
                , parameter.get("ds_file")
                , parameter.get("ds_otherAmtList")
                , parameter.get("ds_etcPrepayamtList")
                , parameter.get("ds_commSals")
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
     * 품의 구매(수입)를 등록한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveInsDtl.xdo")
    public ModelAndView saveInsDtl(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = poOrderMstService.saveInsDtl(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_poOrderInfo")
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
     * 품의 구매(수입)를 등록한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveDmtPoOrderDtl.xdo")
    public ModelAndView saveDmtPoOrderDtl(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = poOrderMstService.saveDmtPoOrderDtl(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_poOrderInfo")
                , parameter.get("ds_itemList")
                , parameter.get("ds_payList")
                , parameter.get("ds_file")
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
        List<Map<String, Object>> listMap  = poOrderMstService.createFiscalSlip(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_otherAmtList")
                );

        logger.info("procCnt :"+listMap.get(0).get("procCnt"));
        logger.info("slipNums :"+listMap.get(0).get("slipNums"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", listMap.get(0).get("procCnt"));
        super.addOutVariable(mav, "fv_slipNums", listMap.get(0).get("slipNums"));
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
        int procCnt  = poOrderMstService.cancelFiscalSlip(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_otherAmtList")
                );

        logger.info("procCnt :"+procCnt);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);
        super.addOutVariable(mav, "fv_flag", "UPDATE");

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

   /**
     * 기타선급금 정산 회계전표 IF 버튼 클릭시 SAP
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("createEtcFiscalSlipIf.xdo")
    public ModelAndView createEtcFiscalSlipIf(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = poOrderMstService.createEtcFiscalSlipIf(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_etcPrepayamtList")
                );

        logger.info("procCnt :"+listMap.get(0).get("procCnt"));
        logger.info("slipNums111 :"+listMap.get(0).get("slipNums"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", listMap.get(0).get("procCnt"));
        super.addOutVariable(mav, "fv_slipNums", listMap.get(0).get("slipNums"));
        super.addOutVariable(mav, "fv_flag", "UPDATE");

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 기타선급금 정산 회계전표 IF 취소 버튼 클릭시 SAP
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("cancelEtcFiscalSlipIf.xdo")
    public ModelAndView cancelEtcFiscalSlipIf(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        int procCnt  = poOrderMstService.cancelEtcFiscalSlipIf(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_etcPrepayamtList")
                );

        logger.info("procCnt :"+procCnt);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);
        super.addOutVariable(mav, "fv_flag", "UPDATE");

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 품의 구매(수입)를 등록한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveEtcPrepayamtList.xdo")
    public ModelAndView saveEtcPrepayamtList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = poOrderMstService.saveEtcPrepayamtList(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_poOrderInfo")
                , parameter.get("ds_etcPrepayamtList")
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
     * 품의 수수료 정보를 등록한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveOtherAmtList.xdo")
    public ModelAndView saveOtherAmtList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = poOrderMstService.saveOtherAmtList(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_poOrderInfo")
                , parameter.get("ds_otherAmtList")
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
     * 수수료 매출 정보를 등록한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveCommSalsList.xdo")
    public ModelAndView saveCommSalsList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = poOrderMstService.saveCommSalsList(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_poOrderInfo")
                , parameter.get("ds_commSals")
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
     * 수수료 매출 정보를 확정 처리한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveCommSalsConfirm.xdo")
    public ModelAndView saveCommSalsConfirm(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = poOrderMstService.saveCommSalsConfirm(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_poOrderInfo")
                , parameter.get("ds_commSals")
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
     * 수수료 매출 정보를 확정취소 처리한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveCommSalsConfirmCancel.xdo")
    public ModelAndView saveCommSalsConfirmCancel(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = poOrderMstService.saveCommSalsConfirmCancel(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_poOrderInfo")
                , parameter.get("ds_commSals")
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
     * 수수료 매출 마감 취소 처리한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveSalsRegCancel.xdo")
    public ModelAndView saveSalsRegCancel(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = poOrderMstService.saveSalsReg(		//확정처리
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_poOrderInfo")
                , parameter.get("ds_commSals")
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
     * 수수료 매출 정보를 마감 처리한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveSalsReg.xdo")
    public ModelAndView saveSalsReg(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = poOrderMstService.saveSalsReg(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_poOrderInfo")
                , parameter.get("ds_commSals")
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
     * 원시전표 불러오기 조회한다.
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
    @RequestMapping("selectSlipCallPop.xdo")
    public ModelAndView selectSlipCallPop(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        logger.info( "ds_search :"+parameter.get("ds_search").get(0));

        //구매 주문에 대한 내역. 을(를) 조회한다.
        RecordSet rs = poOrderMstService.selectSlipCallPop(parameter.get("ds_search").get(0));



        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 영업회계 원시전표 불러오기 조회한다.
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
    @RequestMapping("selectIfcSlipCallPop.xdo")
    public ModelAndView selectIfcSlipCallPop(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        logger.info( "ds_search :"+parameter.get("ds_search").get(0));
        logger.info( "search :"+parameter.get("ds_search").get(0).get("search"));
        logger.info( "searchContents :"+parameter.get("ds_search").get(0).get("searchContents"));
        

        //구매 주문에 대한 내역. 을(를) 조회한다.
        RecordSet rs = poOrderMstService.selectIfcSlipCallPop(parameter.get("ds_search").get(0));



        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 가수금전표 불러오기 조회한다.
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
    @RequestMapping("selectSuspenseCallPop.xdo")
    public ModelAndView selectSuspenseCallPop(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        logger.info( "ds_search :"+parameter.get("ds_search").get(0));

        //구매 주문에 대한 내역. 을(를) 조회한다.
        RecordSet rs = poOrderMstService.selectSuspenseCallPop(parameter.get("ds_search").get(0));



        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
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
//    @RequestMapping(value = "/ft/ftp/makeGwDraftContent.do")
    @RequestMapping(value = "makeSlipGwDraftContent.do")
    public ModelAndView makeSlipGwDraftContent (HttpServletRequest request, Model model
            , @RequestParam(value="slipNums", required=true) String strId
            , @RequestParam(value="svc", required=true) String svc
            , @RequestParam(value="title", required=false, defaultValue="") String strBodyTitle) throws Exception {

        logger.info("#####makeSlipGwDraftContent#####");
        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        Map<String, Object> parameter = new HashMap<String, Object>();

        logger.info("strId :"+strId);

        List<String> slipNums = Arrays.asList(strId.split(","));
        List<String> al = new ArrayList<String>();
        for (int i=0 ; i<slipNums.size() ; i++) {
            al.add(slipNums.get(i));
        }

        parameter.put("searchId", al);
        RecordSet rs = ftSapInterfaceService.selectSlipMst(parameter);					//전표 마스터을 조회한다.

        RecordSet rs2 = ftSapInterfaceService.selectSlipList(parameter);					//전표 마스터을 조회한다.


        //본문을 생성하는 JSP로 정보를 전달하기 위해 Model에 설정한다.
        model.addAttribute("gwDraftMst", rs.get(0));
        model.addAttribute("gwDraftList", rs2);
//        model.addAttribute("gwDraftList", rs2);

        //본문 타이틀 설정
        model.addAttribute("gwDraftTitle", strBodyTitle);
        model.addAttribute("svc", svc);
        logger.info("svc :"+svc);

        //본문을 생성하는 JSP 호출
        String path  = "/gw/ftp/SlipGwDraft";
        return new ModelAndView(path);
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
//    @RequestMapping(value = "/ft/ftp/makeGwDraftContent.do")
    @RequestMapping(value = "makeEtcSlipGwDraftContent.do")
    public ModelAndView makeEtcSlipGwDraftContent (HttpServletRequest request, Model model
            , @RequestParam(value="slipNums", required=true) String strId
            , @RequestParam(value="svc", required=true) String svc
            , @RequestParam(value="title", required=false, defaultValue="") String strBodyTitle) throws Exception {

        logger.info("#####makeSlipGwDraftContent#####");
        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        Map<String, Object> parameter = new HashMap<String, Object>();

        logger.info("strId :"+strId);

        List<String> slipNums = Arrays.asList(strId.split(","));
        List<String> al = new ArrayList<String>();
        for (int i=0 ; i<slipNums.size() ; i++) {
            al.add(slipNums.get(i));
        }

        parameter.put("searchId", al);

        RecordSet rs = ftSapInterfaceService.selectSlipMst(parameter);					//전표 마스터을 조회한다.

        RecordSet rs2 = ftSapInterfaceService.selectSlipList(parameter);					//전표 마스터을 조회한다.


        //본문을 생성하는 JSP로 정보를 전달하기 위해 Model에 설정한다.
        model.addAttribute("gwDraftMst", rs.get(0));
        model.addAttribute("gwDraftList", rs2);


        //본문 타이틀 설정
        model.addAttribute("gwDraftTitle", strBodyTitle);
        model.addAttribute("svc", svc);
        logger.info("svc :"+svc);

        //본문을 생성하는 JSP 호출
        String path  = "/gw/ftp/SlipGwDraft";
        return new ModelAndView(path);
    }

    /**
     * 품의 수수료 정보를 등록한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveOtherAmtDraft.xdo")
    public ModelAndView saveOtherAmtDraft(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = poOrderMstService.saveOtherAmtDraft(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_poOrderInfo")
                , parameter.get("ds_otherAmtList")
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
     * 품의 수수료 정보를 등록한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveEtcAmtDraft.xdo")
    public ModelAndView saveEtcAmtDraft(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = poOrderMstService.saveEtcAmtDraft(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_poOrderInfo")
                , parameter.get("ds_etcPrepayamtList")
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
     * @throws Exception //makeGwSilpContent
     */
    @RequestMapping(value = "makeGwDraftContent.do")
    public ModelAndView makeGwDraftContent (HttpServletRequest request, Model model
            , @RequestParam(value="slipNums", required=true) String strId
            , @RequestParam(value="svc", required=true) String svc
            , @RequestParam(value="title", required=false, defaultValue="") String strBodyTitle) throws Exception {

        logger.info("#####makeGwDraftContent #####");
        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        Map<String, Object> parameter = new HashMap<String, Object>();

        logger.info("strId :"+strId);

        List<String> slipNums = Arrays.asList(strId.split(","));
        List<String> al = new ArrayList<String>();
        for (int i=0 ; i<slipNums.size() ; i++) {
            al.add(slipNums.get(i));
        }

        parameter.put("searchId", al);
    	
        RecordSet rsGrdlist = ftSapInterfaceService.selectGwSlipList(parameter);

        //본문을 생성하는 JSP로 정보를 전달하기 위해 Model에 설정한다.
        model.addAttribute("gwDraftList", rsGrdlist);
        
        //본문을 생성하는 JSP 호출
        return new ModelAndView("/gw/ftp/SlipGwDraftAll");
    }  

}
