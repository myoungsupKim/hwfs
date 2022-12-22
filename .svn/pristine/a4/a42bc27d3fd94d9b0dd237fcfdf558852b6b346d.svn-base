package com.hwfs.ft.fsi.web;

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
import com.hwfs.ft.fsi.service.WhbyItembyChargAmtService;


 /**
 * 창고, 품목별로 보관료를 관리.하는 WhbyItembyChargAmt Controller
 *
 * @ClassName WhbyItembyChargAmtController.java
 * @Description WhbyItembyChargAmtController Class
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
@RequestMapping("/ft/fsi/whbyItembyChargAmt/")
public class WhbyItembyChargAmtController extends DefaultController {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** WhbyItembyChargAmtService Bean 생성 */
    @Resource(name = "/ft/fsi/whbyItembyChargAmtService")
    private WhbyItembyChargAmtService whbyItembyChargAmtService;

    /**
     * 창고, 품목별로 보관료. 목록을 조회한다.
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
    @RequestMapping("selectWhbyItembyChargAmt.xdo")
    public ModelAndView selectWhbyItembyChargAmt(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        logger.info( "ds_search :"+parameter.get("ds_search").get(0));


        //창고, 품목별로 보관료. 을(를) 조회한다.
        RecordSet rs = whbyItembyChargAmtService.selectList(parameter.get("ds_search").get(0));
        RecordSet rs2 = null;
        if ( rs.size() >0 && rs.get(0).get("whCd") !=null )
        {
            //창고, 품목별로 보관료. 상세을(를) 조회한다.
            parameter.get("ds_search").get(0).put("whCd", rs.get(0).get("whCd"));
            rs2 = whbyItembyChargAmtService.selectList2(parameter.get("ds_search").get(0));
        }

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);	//창고리스트
        super.addOutDataSet(mav, "ds_list2", rs2);	//창고 품목 리스트

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 창고, 품목별로 보관료. 목록을 조회한다.
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
    @RequestMapping("selectWhbyItembyChargAmt2.xdo")
    public ModelAndView selectWhbyItembyChargAmt2(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        logger.info( "ds_search :"+parameter.get("ds_search").get(0));


        //창고, 품목별로 보관료. 을(를) 조회한다.
        logger.info("####selectWhbyItembyChargAmt start###");
        //창고, 품목별로 보관료. 상세을(를) 조회한다.
        RecordSet rs = whbyItembyChargAmtService.selectList2(parameter.get("ds_search").get(0));
        logger.info("####selectWhbyItembyChargAmt end###");

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list2", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 창고, 품목별로 보관료. 목록을 조회한다.
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
    @RequestMapping("selectWhbyItembyChargAmtPop.xdo")
    public ModelAndView selectWhbyItembyChargAmtPop(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        logger.info( "ds_search :"+parameter.get("ds_search").get(0));

        //창고, 품목별로 보관료. 팝업을(를) 조회한다.
        logger.info("####selectWhbyItembyChargAmtPop start###");
        //창고, 품목별로 보관료. 팝업을(를) 조회한다.
        RecordSet rs = whbyItembyChargAmtService.selectList2(parameter.get("ds_search").get(0));
        logger.info("####selectWhbyItembyChargAmtPop end###");

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 창고, 품목별로 보관료.(을)를 Insert/Update/Delete 처리한다.
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
    @RequestMapping("saveWhbyItembyChargAmtList.xdo")
    public ModelAndView saveWhbyItembyChargAmtList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list2");

        //창고, 품목별로 보관료.을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = whbyItembyChargAmtService.saveList(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
