package com.hwfs.ft.fdm.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

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
import com.hwfs.ft.fdm.service.EntryItemDetailService;
import com.hwfs.ft.fdm.service.EntryMstService;
import com.hwfs.ft.fdm.service.InventoryMgmtDeliverService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 관세비용 및 입고예정정보를 등록 관리하는 EntryMst Controller
 *
 * @ClassName EntryMstController.java
 * @Description EntryMstController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.13    kjj        최초생성
 * </pre>
 * @author FC종합전산구축 :  식재도매 kjj
 * @since 2015.04.13
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ft/fdm/entryMst/")
public class EntryMstController extends DefaultController {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** EntryMstService Bean 생성 */
    @Resource(name = "/ft/fdm/entryMstService")
    private EntryMstService entryMstService;

    @Resource(name = "/ft/fdm/entryItemDetailService")
    private EntryItemDetailService entryItemDetailService;

    @Resource(name = "/ft/fdm/inventoryMgmtDeliverService")
    private InventoryMgmtDeliverService inventoryMgmtDeliverService;


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
    @RequestMapping("selectList.xdo")
    public ModelAndView selectList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //관세비용 및 입고예정정보를 등록 관리 을(를) 조회한다.
        RecordSet rs = entryMstService.selectList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리(을)를 Insert/Update/Delete 처리한다.
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

        //관세비용 및 입고예정정보를 등록 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = entryMstService.saveList(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_processCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 관세비용 및 입고예정정보를 상세 조회한다.
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
    @RequestMapping("selectEntryDtl.xdo")
    public ModelAndView selectEntryDtl(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        logger.info("ds_search :"+parameter.get("ds_search").get(0));
        //관세비용 및 입고예정정보를 등록 관리 을(를) 조회한다.
        RecordSet rs = entryMstService.selectEntryMst(parameter.get("ds_search").get(0));					//통관 마스터을 조회한다.
        RecordSet rs1 = entryItemDetailService.selectEntryItemDetail(parameter.get("ds_search").get(0));	//통관 품목 상세를 조회한다.


        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_entryMst", rs);
        super.addOutDataSet(mav, "ds_entryItemDetailList", rs1);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 관세비용 및 입고예정정보를 상세 조회한다.
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
    @RequestMapping("searchSignExchangeRate.xdo")
    public ModelAndView searchSignExchangeRate(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        logger.info("ds_search :"+parameter.get("ds_search").get(0));
        //관세비용 및 입고예정정보를 등록 관리 을(를) 조회한다.
        RecordSet rs = entryMstService.searchSignExchangeRate(parameter.get("ds_search").get(0));					//통관 마스터을 조회한다.


        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_signExchangeRateList", rs);

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
    @RequestMapping("selectItemInfoSaveSearchPop.xdo")
    public ModelAndView selectItemInfoSaveSearchPop(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        logger.info( "ds_search :"+parameter.get("ds_search").get(0));


        RecordSet rs = null;
        RecordSet rs2 = null;
        if ( "A".equals(parameter.get("ds_search").get(0).get("entryFlag")) )	//BL조회시
        {
            rs = entryMstService.selectItemInfoSaveSearchPop(parameter.get("ds_search").get(0));
            if ( rs.size() >0  )
            {
                //창고, 품목별로 보관료. 상세을(를) 조회한다.
                parameter.get("ds_search").get(0).put("poOrderNum", rs.get(0).get("poOrderNum"));
                rs2 = entryMstService.selectItemInfoSaveSearchPop2(parameter.get("ds_search").get(0));
            }
        }
        else if ( "B".equals(parameter.get("ds_search").get(0).get("entryFlag")) )	//가입고 조회
        {
            rs = entryMstService.selectItemInfoSaveReceiveSearchPop(parameter.get("ds_search").get(0));
            if ( rs.size() > 0  )
            {
                //창고, 품목별로 보관료. 상세을(를) 조회한다.
                parameter.get("ds_search").get(0).put("poOrderNum", rs.get(0).get("poOrderNum"));
                logger.info("poOrderNum2 :::::::::"+rs.get(0).get("poOrderNum"));
                rs2 = entryMstService.selectItemInfoSaveReceiveSearchPop2(parameter.get("ds_search").get(0));
            }

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
    @RequestMapping("selectItemInfoSaveSearchPop2.xdo")
    public ModelAndView selectItemInfoSaveSearchPop2(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        logger.info( "ds_search :"+parameter.get("ds_search").get(0));


        //창고, 품목별로 보관료. 상세을(를) 조회한다.
        RecordSet rs2 = entryMstService.selectItemInfoSaveSearchPop2(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list2", rs2);

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
    @RequestMapping("selectItemInfoSaveReceiveSearchPop2.xdo")
    public ModelAndView selectItemInfoSaveReceiveSearchPop2(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        logger.info( "ds_search :"+parameter.get("ds_search").get(0));


        //창고, 품목별로 보관료. 상세을(를) 조회한다.
        RecordSet rs2 = entryMstService.selectItemInfoSaveReceiveSearchPop2(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list2", rs2);

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
    @RequestMapping("saveEntryDtl.xdo")
    public ModelAndView saveEntryDtl(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = entryMstService.saveEntryDtl(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_entryMst")
                , parameter.get("ds_entryItemDetailList")
                );

        logger.info("procCnt :"+listMap.get(0).get("procCnt"));
        logger.info("entryNum :"+listMap.get(0).get("entryNum"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", listMap.get(0).get("procCnt"));
        super.addOutVariable(mav, "fv_entryNum", listMap.get(0).get("entryNum"));
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
    @RequestMapping("deleteEntryList.xdo")
    public ModelAndView deleteEntryList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        int processCnt = entryMstService.deleteEntryList(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_list")
                );


        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }


    /**
     * 가입고를 등록 관리 목록을 조회한다.
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
    @RequestMapping("selectBlListPop.xdo")
    public ModelAndView selectBlListPop(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        logger.info( "ds_search :"+parameter.get("ds_search").get(0));


        RecordSet rs2 = null;
        RecordSet rs = entryMstService.selectBlListPop(parameter.get("ds_search").get(0));
        if ( rs.size() >0  )
        {
            //창고, 품목별로 보관료. 상세을(를) 조회한다.
            parameter.get("ds_search").get(0).put("poOrderNum", rs.get(0).get("poOrderNum"));
            rs2 = entryMstService.selectBlListPop2(parameter.get("ds_search").get(0));
        }

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);	//창고리스트
        super.addOutDataSet(mav, "ds_list2", rs2);	//창고 품목 리스트

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }

    /**
     * 가입고 관리 목록을 조회한다.
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
    @RequestMapping("selectBlListPop2.xdo")
    public ModelAndView selectBlListPop2(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        logger.info( "ds_search :"+parameter.get("ds_search").get(0));


        //창고, 품목별로 보관료. 상세을(를) 조회한다.
        RecordSet rs2 = entryMstService.selectBlListPop2(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list2", rs2);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }

    /**
     * 가입고 관리 목록을 조회한다.
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
    @RequestMapping("selectReceiveRegList.xdo")
    public ModelAndView selectReceiveRegList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //관세비용 및 입고예정정보를 등록 관리 을(를) 조회한다.
        RecordSet rs = inventoryMgmtDeliverService.selectReceiveRegList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 수입면허 입고 처리한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveDeliver.xdo")
    public ModelAndView saveDeliver(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

        //입고정보를 등록 관리한다.을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = inventoryMgmtDeliverService.saveDeliver( param.get("ds_list"));

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 수입면허 입고취소 처리한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("cancelDeliver.xdo")
    public ModelAndView cancelDeliver(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

        //입고정보를 등록 관리한다.을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = inventoryMgmtDeliverService.cancelDeliver( param.get("ds_list"));

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 면허번호 중복체크
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("dupIncomeLicNumChk.xdo")
    public ModelAndView dupIncomeLicNumChk(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //관세비용 및 입고예정정보를 등록 관리 을(를) 조회한다.
        String dupIncomeLicNumYn = entryMstService.dupIncomeLicNumYn(parameter.get("ds_search").get(0));
logger.info("dupIncomeLicNumYn :"+dupIncomeLicNumYn);
        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_dupIncomeLicNumYn", dupIncomeLicNumYn);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 가입고 삭제한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("deleteGaDeliver.xdo")
    public ModelAndView deleteGaDeliver(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

        //입고정보를 등록 관리한다.을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = inventoryMgmtDeliverService.deleteGaDeliver( param.get("ds_list"));

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
}
