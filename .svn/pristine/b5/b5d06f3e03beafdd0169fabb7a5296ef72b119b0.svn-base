package com.hwfs.ft.fsi.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.ft.fsi.service.FreezeWhCommMgmtService;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

/**
* 냉동창고수수료 내역을 Controller
*
* @ClassName WhController.java
* @Description WhController Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.08.26    jshoon        최초생성
* </pre>
* @author FC종합전산구축 :  식재도매 kjj
* @since 2015.08.26
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Controller
@RequestMapping("/ft/fsi/freezeWhCommMgmt/")
public class FreezeWhCommMgmtController extends DefaultController {

    @Resource(name = "/ft/fsi/freezeWhCommMgmtService")
    private FreezeWhCommMgmtService freezeWhCommMgmtService;

    /**
     * 냉동창고수수료 내역을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectList.xdo")
    public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        //창고 조회 을(를) 조회한다.
        RecordSet rs = freezeWhCommMgmtService.selectList(parameter.get("ds_search").get(0));

        // 개인정보보호 접근로그를 쌓는다. 조회조건과 조회 건수
        accessLogService.readLog(parameter.get("ds_search").get(0), rs.size());

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 냉동창고수수료 내역을 Insert/Update/Delete 처리한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("saveList.xdo")
    public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");

        //창고 조회을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = freezeWhCommMgmtService.saveList(param.get("ds_search").get(0), parameter);

        // 개인정보보호 접근로그를 쌓는다.
        accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[] { "BANK_ACCT_NO" }));

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 냉동창고수수료 일괄 저장 - 사용안함
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("saveListAll.xdo")
    public ModelAndView saveListAll(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        int retVal = freezeWhCommMgmtService.saveListAll(parameter.get("ds_search").get(0), parameter.get("ds_list"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 전자결재 결과를 등록한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("saveDraft.xdo")
    public ModelAndView saveDraft(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        int retVal = freezeWhCommMgmtService.saveDraft(parameter.get("ds_search").get(0), parameter.get("ds_list"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 전표 IF -> SAP
     *
     * @param xpDTO
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("createFiscalSlipIf.xdo")
    public ModelAndView createFiscalSlipIf(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
            HttpServletRequest request) throws Exception {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
        Map<String, Object> listMap = freezeWhCommMgmtService.createFiscalSlip(loginDTO, parameter.get("ds_search"),
                parameter.get("ds_list"));

        List<String> slipNums = (ArrayList<String>) listMap.get("slipNums");
        String sSlipNums = "";
        for (int i = 0; i < slipNums.size(); i++) {
            sSlipNums += slipNums.get(i).toString() + ",";
        }
        sSlipNums = sSlipNums.substring(0, sSlipNums.length() - 1);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", LimsUtil.checkNull(listMap.get("procCnt"), 0));
        super.addOutVariable(mav, "fv_slipNums", sSlipNums);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 전표 IF 취소 버튼 클릭시 SAP
     *
     * @param xpDTO
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("cancelFiscalSlipIf.xdo")
    public ModelAndView cancelFiscalSlipIf(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
            HttpServletRequest request) throws Exception {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
        int procCnt = freezeWhCommMgmtService.cancelFiscalSlip(loginDTO, parameter.get("ds_search"), parameter.get("ds_list"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 팝업에서 사용하는 거래처 계좌번호 조회
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectSuplierAcctNoList.xdo")
    public ModelAndView selectSuplierAcctNoList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> param = parameter.get("ds_search").get(0);
        RecordSet rs = freezeWhCommMgmtService.selectSuplierAcctNoList(param);

        // 개인정보보호 접근로그를 쌓는다. 조회조건과 조회 건수
        accessLogService.readLog(param, rs.size());

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 매입 전자세금계산서 조회
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectElctnTexShetList.xdo")
    public ModelAndView selectElctnTexShetList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> param = parameter.get("ds_search").get(0);
        List<Map<String, Object>> rs = freezeWhCommMgmtService.selectElctnTexShetList(param);

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
