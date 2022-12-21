package com.hwfs.ft.fdm.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

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
import com.hwfs.ft.fdm.service.InventoryAssetDisuseLossService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 재고자산 폐기손실하는 InventoryAssetDisuseLoss Controller
 *
 * @ClassName InventoryAssetDisuseLossController.java
 * @Description InventoryAssetDisuseLossController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.07    KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 :  식재도매 KJJ
 * @since 2015.07.07
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ft/fdm/inventoryAssetDisuseLoss/")
public class InventoryAssetDisuseLossController extends DefaultController {


    /** InventoryAssetDisuseLossService Bean 생성 */
    @Resource(name = "/ft/fdm/inventoryAssetDisuseLossService")
    private InventoryAssetDisuseLossService inventoryAssetDisuseLossService;

    /**
     * 재고자산 폐기손실 목록을 조회한다.
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

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = inventoryAssetDisuseLossService.selectList(parameter.get("ds_search").get(0));

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

        RecordSet rs = inventoryAssetDisuseLossService.selectDetailList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_detailList", rs);

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
        int procCnt  = inventoryAssetDisuseLossService.createFiscalSlip(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_detailList")
                );


        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);
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
        int procCnt  = inventoryAssetDisuseLossService.cancelFiscalSlip(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_detailList")
                );

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);
        super.addOutVariable(mav, "fv_flag", "UPDATE");

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 재고자산 폐기손실(을)를 Insert/Update/Delete 처리한다.
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

        //재고자산 폐기손실을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = inventoryAssetDisuseLossService.saveList(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_processCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
