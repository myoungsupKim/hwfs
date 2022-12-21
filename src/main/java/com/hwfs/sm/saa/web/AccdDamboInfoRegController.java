package com.hwfs.sm.saa.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sm.saa.service.AccdDamboInfoRegService;

/**
 * 담보정보등록하는 AccdDamboInfoReg Controller
 *
 * @ClassName AccdDamboInfoRegController.java
 * @Description AccdDamboInfoRegController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.24    최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최종덕
 * @since 2015.04.24
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sm/saa/accdDamboInfoReg/")
public class AccdDamboInfoRegController extends DefaultController {

    /** AccdDamboInfoRegService Bean 생성 */
    @Resource(name = "/sm/saa/accdDamboInfoRegService")
    private AccdDamboInfoRegService accdDamboInfoRegService;

    /**
     * 담보정보 목록을 조회한다.
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

        //조회 조건 파라미터를 얻는다.
        Map <String, Object> inVar = xpDTO.getInVariableMap();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsGrdlist = null;

        //담보정보 을(를) 조회한다.
        rsGrdlist   = accdDamboInfoRegService.selectList(parameter.get("ds_search").get(0));

        //개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
        accessLogService.readLog(inVar, rsGrdlist.size());

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsSearchOutput", rsGrdlist);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     *
     * 메인업장을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectMainUpjang.xdo")
    public ModelAndView selectMainUpjang(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //메인업장
        RecordSet rsTheme = accdDamboInfoRegService.selectMainUpjang(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsMainUpangOutput", rsTheme);


        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     *
     * 담보를 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectDambo.xdo")
    public ModelAndView selectDambo(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map <String, Object> inVar = xpDTO.getInVariableMap();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsRealEstate     = null;
        RecordSet rsGuaranteeInsur = null;
        RecordSet rsGuarantor      = null;
        RecordSet rsCashGuarantee  = null;
        RecordSet rsPledge         = null;
        RecordSet rsAccRcvAlnt     = null;

        // 부동산 정보
        rsRealEstate     = accdDamboInfoRegService.selectRealEstate(parameter.get("ds_search").get(0));

        // 보증보험 정보
        rsGuaranteeInsur = accdDamboInfoRegService.selectGuaranteeInsur(parameter.get("ds_search").get(0));

        // 인보증 정보
        rsGuarantor      = accdDamboInfoRegService.selectGuarantor(parameter.get("ds_search").get(0));

        // 현금보증 정보
        rsCashGuarantee  = accdDamboInfoRegService.selectCashGuarantee(parameter.get("ds_search").get(0));

        // 질권 정보
        rsPledge         = accdDamboInfoRegService.selectPledge(parameter.get("ds_search").get(0));

        // 채권양도 정보
        rsAccRcvAlnt     = accdDamboInfoRegService.selectAccRcvAlnt(parameter.get("ds_search").get(0));

        //개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
        accessLogService.readLog(inVar, rsRealEstate.size());
        accessLogService.readLog(inVar, rsGuarantor.size());

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsRealEstate", rsRealEstate);
        super.addOutDataSet(mav, "dsGuaranteeInsur", rsGuaranteeInsur);
        super.addOutDataSet(mav, "dsGuarantor", rsGuarantor);
        super.addOutDataSet(mav, "dsCashGuarantee", rsCashGuarantee);
        super.addOutDataSet(mav, "dsPledge", rsPledge);
        super.addOutDataSet(mav, "dsAccRcvAlnt", rsAccRcvAlnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 담보정보(을)를 Insert/Update/Delete 처리한다.
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

        //개인정보보호 접근로그를 쌓는다.
        accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"CEO_BRTH_DATE_ENC, ADDR_ENC"}));

        //담보정보을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = accdDamboInfoRegService.saveList(param.get("ds_realEstate"), param.get("ds_guaranteeInsur"), param.get("ds_guarantor"), param.get("ds_cashGuarantee"), param.get("ds_pledge"), param.get("ds_accRcvAlnt"));

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_processCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
}
