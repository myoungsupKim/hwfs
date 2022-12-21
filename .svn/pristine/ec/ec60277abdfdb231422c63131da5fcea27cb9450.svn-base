package com.hwfs.sm.saa.web;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sm.saa.service.AccdArOccurReptService;
import com.hwfs.sm.saa.service.SaleColletionListService;

/**
 * 판매/수금 부동처 현황하는 SaleColletionList Controller
 *
 * @ClassName SaleColletionListController.java
 * @Description SaleColletionListController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.12    최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최종덕
 * @since 2015.05.12
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sm/saa/saleColletionList/")
public class SaleColletionListController extends DefaultController {

    /** SaleColletionListService Bean 생성 */
    @Resource(name = "/sm/saa/saleColletionListService")
    private SaleColletionListService saleColletionListService;

    /** AccdArOccurReptService Bean 생성 */
    @Resource(name = "/sm/saa/accdArOccurReptService")
    private AccdArOccurReptService accdArOccurReptService;

    /**
     * 판매부동처 및 수금부동처 현황을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectList.xdo")
    public ModelAndView selectList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        List<Record> yrMon       = null;
        RecordSet rsGrdlist      = null;
        RecordSet rsHdrDealDesc  = null;

        // 판매부동처 헤더
        parameter.get("ds_search").get(0).put("hdrGubun", "1");
        rsHdrDealDesc = accdArOccurReptService.selectHdrDealDesc(parameter.get("ds_search").get(0));

        // 일자 조회조건
        parameter.get("ds_search").get(0).put("hdrGubun", "2");
        yrMon = accdArOccurReptService.selectHdrDealDesc(parameter.get("ds_search").get(0));
        parameter.get("ds_search").get(0).put("yrMon", yrMon.get(0).get("yrMon"));

        //판매부동처 및 수금부동처 현황을 조회한다.
        rsGrdlist   = saleColletionListService.selectList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsHdrDealDesc", rsHdrDealDesc);
        super.addOutDataSet(mav, "dsSearchOutput", rsGrdlist);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 판매부동처 및 수금부동처 현황(식재)을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectListFms.xdo")
    public ModelAndView selectListFms(
    		@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
    	
    	//XPLATFORM에 결과를 전달할 객체 생성
    	ModelAndView mav = super.createModelAndView();
    	
    	//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
    	Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
    	
    	List<Record> yrMon       = null;
    	RecordSet rsGrdlist      = null;
    	RecordSet rsHdrDealDesc  = null;
    	
    	// 판매부동처 헤더
    	parameter.get("ds_search").get(0).put("hdrGubun", "1");
    	rsHdrDealDesc = accdArOccurReptService.selectHdrDealDesc(parameter.get("ds_search").get(0));
    	
    	// 일자 조회조건
    	parameter.get("ds_search").get(0).put("hdrGubun", "2");
    	yrMon = accdArOccurReptService.selectHdrDealDesc(parameter.get("ds_search").get(0));
    	parameter.get("ds_search").get(0).put("yrMon", yrMon.get(0).get("yrMon"));
    	
    	//판매부동처 및 수금부동처 현황을 조회한다.
    	rsGrdlist   = saleColletionListService.selectListFms(parameter.get("ds_search").get(0));
    	
    	//XPlatform으로 넘겨줄 Dataset을 설정한다.
    	super.addOutDataSet(mav, "dsHdrDealDesc", rsHdrDealDesc);
    	super.addOutDataSet(mav, "dsSearchOutput", rsGrdlist);
    	
    	//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
    	return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
}
