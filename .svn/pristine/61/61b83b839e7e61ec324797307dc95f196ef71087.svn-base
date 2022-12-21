package com.hwfs.ft.ftr.web;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.ft.ftr.service.FtStatsService;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

/**
 * 식재도매 통계조회 Controller Class
 *
 * @ClassName FtStatsController.java
 * @Description FtStatsController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 06.   kkj         최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 kkh
 * @since 2015. 7. 06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ft/ftr/ftStats/")
public class FtStatsController extends DefaultController {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    @Resource(name = "/ft/ftr/ftStatsService")
    private FtStatsService ftStatsService;

    /**
     * PO별 재고 금액을 조회
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("pobyInventoryAmt.xdo")
    public ModelAndView pobyInventoryAmt(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.pobyInventoryAmt(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * PO별 재고 이력을 조회
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("pobyInventoryLog.xdo")
    public ModelAndView pobyInventoryLog(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.pobyInventoryLog(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 출고내역을 조회
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("releaseDescInquery.xdo")
    public ModelAndView releaseDescInquery(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.releaseDescInquery(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 창고/품목별 재고현황
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("whItemInquery.xdo")
    public ModelAndView whItemInquery(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.whItemInquery(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 품목/창고별 재고현황
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("itemWhInquery.xdo")
    public ModelAndView itemWhInquery(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.itemWhInquery(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 영업사원별 매출현황
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("poSalsStatus.xdo")
    public ModelAndView poSalsStatus(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.poSalsStatus(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * PO별 기타선급금 미착 금액 상세
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("pobyPrepayamtNonarrivAmtDetail.xdo")
    public ModelAndView pobyPrepayamtNonarrivAmtDetail(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.pobyPrepayamtNonarrivAmtDetail(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     *일별 재고 부진재고 상세
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("ddbyInventoryPoorInventoryDet.xdo")
    public ModelAndView ddbyInventoryPoorInventoryDet(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.ddbyInventoryPoorInventoryDet(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 월별 PO별 판매완료
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("mmbyPobySalend.xdo")
    public ModelAndView mmbyPobySalend(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.mmbyPobySalend(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 입고 PO 품목별 원가/판가 상세 - 수입
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("deliverPoItembyDetail.xdo")
    public ModelAndView deliverPoItembyDetail(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.deliverPoItembyDetailIncome(parameter.get("ds_search").get(0));
        RecordSet rs1 = ftStatsService.deliverPoItembyDetailDmt(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);
        super.addOutDataSet(mav, "ds_list1", rs1);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * PO별 내수 매입 금액
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("pobyDmtBuyAmt.xdo")
    public ModelAndView pobyDmtBuyAmt(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.pobyDmtBuyAmt(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * PO별 수입 현황
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("pobyIncomeStatusRpt.xdo")
    public ModelAndView pobyIncomeStatusRpt(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.pobyIncomeStatusRpt(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * PO별 수입 현황
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("pobyIncomeStatusRpt2.xdo")
    public ModelAndView pobyIncomeStatusRpt2(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.pobyIncomeStatusRpt2(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }    

    /**
     * 월별 예상 창고 보관료
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("expectWhChargamtRpt.xdo")
    public ModelAndView expectWhChargamtRpt(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.expectWhChargamtRpt(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 월별 예상 창고 보관료
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("selectWeekYearMm.xdo")
    public ModelAndView selectWeekYearMm(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.selectWeekYearMm(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_weekYearMm", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 월별 예상 창고 보관료
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("itembyPriceMgmtRpt.xdo")
    public ModelAndView itembyPriceMgmtRpt(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.itembyPriceMgmtRpt(parameter.get("ds_search").get(0));
        RecordSet rs1 = ftStatsService.selectWeekOfYearMm(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);
        super.addOutDataSet(mav, "ds_weekOfYearlist", rs1);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 주차에 대해 시세를 저장
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("saveWeekYearMm.xdo")
    public ModelAndView saveWeekYearMm(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> retVal = ftStatsService.saveWeekYearMm(parameter.get("ds_search").get(0), parameter.get("ds_list"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 부진재고 상세 조회
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("poorInventoryDet.xdo")
    public ModelAndView poorInventoryDet(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.poorInventoryDet(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 영업사원 계획 등록(사업계획,수정계획)을 등록
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("salesmanPlanRegList.xdo")
    public ModelAndView salesmanPlanRegList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.salesmanPlanRegList(parameter.get("ds_search").get(0));
        RecordSet rs2 = ftStatsService.salesmanPlanRegList2(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);
        super.addOutDataSet(mav, "ds_list2", rs2);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }


    /**
     * 주차에 대해 시세를 저장
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("salesmanPlanReg.xdo")
    public ModelAndView salesmanPlanReg(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        logger.info( "#########salesmanPlanReg##########");
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> retVal = ftStatsService.salesmanPlanReg(parameter.get("ds_search").get(0), parameter.get("ds_list"), parameter.get("ds_list2"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 영업사원 계획 실적 조회
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("salesmanPlanRegAct.xdo")
    public ModelAndView salesmanPlanRegAct(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        int prev = Integer.parseInt(parameter.get("ds_search").get(0).get("year").toString()) -1;
        parameter.get("ds_search").get(0).put("prev", prev);
        RecordSet rs = ftStatsService.salesmanPlanRegAct(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }


    /**
     * SAP 전표 전송 목록을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("sapSlipSendStatus.xdo")
    public ModelAndView sapSlipSendStatus(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

        Map<String, Object> parameter = param.get("ds_search").get(0);

        //SAP 전표 전송 을(를) 조회한다.
        RecordSet rs = ftStatsService.sapSlipSendStatus(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * SAP 전표 전송 내역 목록을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @RequestMapping("sapSlipSendStatusDtlList.xdo")
    public ModelAndView selectList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map <String, Object> inVar = xpDTO.getInVariableMap();

        //SAP 전표 전송 내역 을(를) 조회한다.
        RecordSet rs = ftStatsService.sapSlipSendStatusDtlList(inVar);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * PO별 미착 재고 현황
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("pobyNonarrivInventoryStatus.xdo")
    public ModelAndView pobyNonarrivInventoryStatus(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.pobyNonarrivInventoryStatus(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }


    /**
     * PO별 상품 재고 현황
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("pobyGoodsInventoryStatus.xdo")
    public ModelAndView pobyGoodsInventoryStatus(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = ftStatsService.pobyGoodsInventoryStatus(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }


}
