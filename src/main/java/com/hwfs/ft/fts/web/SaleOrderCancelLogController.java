package com.hwfs.ft.fts.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.ft.fts.dao.SaleOrderItemMgmtDAO;
import com.hwfs.ft.fts.service.SaleOrderCancelLogService;


 /**
 * 주문 취소를 관리하는 SaleOrderCancelLog Controller
 *
 * @ClassName SaleOrderCancelLogController.java
 * @Description SaleOrderCancelLogController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.04    KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 :  식재도매 KJJ
 * @since 2015.06.04
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ft/fts/saleOrderCancelLog/")
public class SaleOrderCancelLogController extends DefaultController {

    /** SaleOrderCancelLogService Bean 생성 */
    @Resource(name = "/ft/fts/saleOrderCancelLogService")
    private SaleOrderCancelLogService saleOrderCancelLogService;



    /**
     * 주문 취소를 관리 목록을 조회한다.
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

        //주문 취소를 관리 을(를) 조회한다.
        RecordSet rs = saleOrderCancelLogService.selectList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 주문 취소를 관리(을)를 Insert/Update/Delete 처리한다.
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
        DataSetMap dsSearch = param.get("ds_search");

        //주문 취소를 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = saleOrderCancelLogService.saveList(dsSearch, parameter);


        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
