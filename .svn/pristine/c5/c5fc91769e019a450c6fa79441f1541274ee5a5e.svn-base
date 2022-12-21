package com.hwfs.ft.fts.web;

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
import com.hwfs.ft.fts.service.SaleOrderItemMgmtService;
import com.hwfs.ft.fts.service.SaleOrderService;
import com.hwfs.sc.cmn.dto.LoginDTO;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;


 /**
 * 입고(재고)를 판매 주문에 대하여 관리하는 SaleOrder Controller
 *
 * @ClassName SaleOrderController.java
 * @Description SaleOrderController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06    kjj        최초생성
 * </pre>
 * @author FC종합전산구축 :  식재도매 kjj
 * @since 2015.05.06
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ft/fts/saleOrder/")
public class SaleOrderController extends DefaultController {
    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** SaleOrderService Bean 생성 */
    @Resource(name = "/ft/fts/saleOrderService")
    private SaleOrderService saleOrderService;

    /** SaleOrderService Bean 생성 */
    @Resource(name = "/ft/fts/saleOrderItemMgmtService")
    private SaleOrderItemMgmtService saleOrderItemMgmtService;


    /**
     * 입고(재고)를 판매 주문에 대하여 관리 목록을 조회한다.
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

        //입고(재고)를 판매 주문에 대하여 관리 을(를) 조회한다.
        RecordSet rs = saleOrderService.selectList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리 목록을 조회한다.
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
    @RequestMapping("selectSaleOrderItemSlctPop.xdo")
    public ModelAndView selectSaleOrderItemSlctPop(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();


        RecordSet rs2 = null;
        RecordSet rs = saleOrderService.selectItemInfoSaveSearchPop(parameter.get("ds_search").get(0));
        if ( rs.size() >0  )
        {
            //창고, 품목별로 보관료. 상세을(를) 조회한다.
            parameter.get("ds_search").get(0).put("poOrderNum", rs.get(0).get("poOrderNum"));
            //parameter.get("ds_search").get(0).put("entryNum", rs.get(0).get("entryNum"));
            rs2 = saleOrderService.selectItemInfoSaveSearchPop2(parameter.get("ds_search").get(0));
        }

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);	//창고리스트
        super.addOutDataSet(mav, "ds_list2", rs2);	//창고 품목 리스트

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리 목록을 조회한다.
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
    @RequestMapping("selectSaleOrderItemSlctPop2.xdo")
    public ModelAndView selectSaleOrderItemSlctPop2(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //창고, 품목별로 보관료. 상세을(를) 조회한다.
        RecordSet rs2 = saleOrderService.selectItemInfoSaveSearchPop2(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list2", rs2);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }

    /**
     * 입고(재고)를 판매 주문에 대하여 관리(을)를 Insert/Update/Delete 처리한다.
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
        logger.info("parameter.size() ::::"+parameter.size());
        //입고(재고)를 판매 주문에 대하여 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = saleOrderService.saveList(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 입고(재고)를 판매 주문에 대하여 관리(을)를 Insert/Update/Delete 처리한다.
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
    @RequestMapping("deleteList.xdo")
    public ModelAndView deleteList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");
        logger.info("parameter.size() ::::"+parameter.size());
        //입고(재고)를 판매 주문에 대하여 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = saleOrderService.deleteList(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매주문상세 화면의 판매 주문에 대하여 조회한다.
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
    @RequestMapping("selectSaleOrderDtl.xdo")
    public ModelAndView selectSaleOrderDtl(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        //관세비용 및 입고예정정보를 등록 관리 을(를) 조회한다.
        RecordSet rs = saleOrderService.selectSaleOrder(parameter.get("ds_search").get(0));					//통관 마스터을 조회한다.
        RecordSet rs1 = saleOrderItemMgmtService.selectSaleOrderItemMgmt(parameter.get("ds_search").get(0));	//통관 품목 상세를 조회한다.


        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_saleOrder", rs);
        super.addOutDataSet(mav, "ds_saleOrderItemMgmtList", rs1);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매주문 등록한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveSaleOrderDtl.xdo")
    public ModelAndView saveSaleOrderDtl(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = saleOrderService.saveSaleOrderDtl(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_saleOrder")
                , parameter.get("ds_saleOrderItemMgmtList")
                );

        logger.info("procCnt :"+listMap.get(0).get("procCnt"));
        logger.info("saleOrderNum :"+listMap.get(0).get("saleOrderNum"));
        logger.info("fv_processYn :"+listMap.get(0).get("fv_processYn"));
        logger.info("fv_processYn2 :"+listMap.get(0).get("fv_processYn2"));
        logger.info("incomeCstAmt1 :"+listMap.get(0).get("incomeCstAmt"));
        logger.info("saleAmt :"+listMap.get(0).get("saleAmt"));
        logger.info("fv_wonwtrAmt :"+listMap.get(0).get("fv_wonwtrAmt"));
        logger.info("fv_deliverNum :"+listMap.get(0).get("deliverNum"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", listMap.get(0).get("procCnt"));
        super.addOutVariable(mav, "fv_saleOrderNum", listMap.get(0).get("saleOrderNum"));
        super.addOutVariable(mav, "fv_processYn", listMap.get(0).get("fv_processYn"));
        super.addOutVariable(mav, "fv_processYn2", listMap.get(0).get("fv_processYn2"));
        super.addOutVariable(mav, "fv_incomeCstAmt", listMap.get(0).get("fv_incomeCstAmt"));
        super.addOutVariable(mav, "fv_saleAmt", listMap.get(0).get("fv_saleAmt"));
        super.addOutVariable(mav, "fv_wonwtrAmt", listMap.get(0).get("fv_wonwtrAmt"));
        super.addOutVariable(mav, "fv_flag", "UPDATE");
        super.addOutVariable(mav, "fv_deliverNum", listMap.get(0).get("deliverNum").toString());
        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매단가 조회한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("setSaleInfo.xdo")
    public ModelAndView setSaleInfo(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);

        Map<String, Object> saleResultMap  = saleOrderService.setSaleInfo( parameter.get("ds_saleOrderItemMgmtList").get(0) );

        logger.info("buyCst :"+saleResultMap.get("buyCst"));
        logger.info("saleCst :"+saleResultMap.get("saleCst"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_buyCst", saleResultMap.get("buyCst"));
        super.addOutVariable(mav, "fv_saleCst", saleResultMap.get("saleCst"));

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 입고(재고)를 판매 주문에 대하여 관리 목록을 조회한다.
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
    @SuppressWarnings("unchecked")
    @RequestMapping("selectSalesOrderRegList.xdo")
    public ModelAndView selectSalesOrderRegList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //입고(재고)를 판매 주문에 대하여 관리 을(를) 조회한다.
        RecordSet rs = saleOrderService.selectSalesOrderRegList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
