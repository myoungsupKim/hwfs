package com.hwfs.fs.fse.web;

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
import com.hwfs.fs.fse.service.EventProcessApprvMgntService;
import com.hwfs.fs.fse.service.EventResultRegMgntService;
import com.hwfs.sc.cmn.service.AttachFileService;


/**
 * 이벤트 결과등록 관리하는 EventResultRegMgnt Controller
 *
 * @ClassName EventResultRegMgntController.java
 * @Description EventResultRegMgntController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17    최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최종덕
 * @since 2015.04.17
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fse/eventResultRegMgnt/")
public class EventResultRegMgntController extends DefaultController {

    /** File Attach Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    /** EventProcessApprvMgntService Bean 생성 */
    @Resource(name = "/fs/fse/eventProcessApprvMgntService")
    private EventProcessApprvMgntService eventProcessApprvMgntService;

    /** EventResultRegMgntService Bean 생성 */
    @Resource(name = "/fs/fse/eventResultRegMgntService")
    private EventResultRegMgntService eventResultRegMgntService;

    /**
     * 이벤트 분류, 테마를 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectEvntClsfi.xdo")
    public ModelAndView selectEvntClsfi(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsCbo     = null;
        RecordSet rsTheme   = null;

        //분류 콤보
        rsCbo   = eventResultRegMgntService.selectCboList(parameter.get("ds_search").get(0));
        if(rsCbo.size() > 0 ){
        	parameter.get("ds_search").get(0).put("mclassCd", rsCbo.get(0).get("mclassCd"));
        }
        
        //테마 콤보
        rsTheme = eventResultRegMgntService.selectThemeList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsCboOutput", rsCbo);
        super.addOutDataSet(mav, "dsThemeOutput", rsTheme);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 이벤트 Theme 목록을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectTheme.xdo")
    public ModelAndView selectTheme(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //테마 콤보
        RecordSet rsTheme = eventResultRegMgntService.selectThemeList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsThemeListOutput", rsTheme);


        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 이벤트 결과등록 관리 목록을 조회한다.
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

        RecordSet rsCbo     = null;
        RecordSet rsTheme   = null;
        RecordSet rsGrdlist = null;

        //신청목록
        rsGrdlist = eventResultRegMgntService.selectList(parameter.get("ds_search").get(0));

        //분류 콤보
        rsCbo     = eventProcessApprvMgntService.selectCboList(parameter.get("ds_search").get(0));
        if(rsCbo.size() > 0 ){
        	parameter.get("ds_search").get(0).put("mclassCd", rsCbo.get(0).get("mclassCd"));
        }
        
        //테마 콤보
        rsTheme   = eventProcessApprvMgntService.selectThemeList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsCboOutput", rsCbo);
        super.addOutDataSet(mav, "dsThemeOutput", rsTheme);
        super.addOutDataSet(mav, "dsSearchOutput", rsGrdlist);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 이벤트 신청 정보 및 진행정보를 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping("selectRequestInfo.xdo")
    public ModelAndView selectRequestInfo(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map <String, Object> inVar = xpDTO.getInVariableMap();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsEventReq  = null;
        RecordSet rsProgress  = null;
        RecordSet rsInforeg   = null;
        RecordSet rsUtensil   = null;
        RecordSet rsTheme     = null;
        RecordSet rsResult    = null;
        List<Map> fileEvtList = null;
        List<Map> fileList    = null;

        parameter.get("ds_search").get(0).put("seq", parameter.get("ds_search").get(0).get("evntId"));

        // 신청정보
        rsEventReq = eventProcessApprvMgntService.selectEventReq(parameter.get("ds_search").get(0));

        // 진행정보
        rsProgress = eventProcessApprvMgntService.selectProgress(parameter.get("ds_search").get(0));

        // 기기정보
        rsInforeg  = eventProcessApprvMgntService.selectInforeg(parameter.get("ds_search").get(0));

        // 사업장 기기정보
        rsUtensil  = eventProcessApprvMgntService.selectUpjangutensil(parameter.get("ds_search").get(0));

        // 결과정보
        rsResult   = eventResultRegMgntService.selectResult(parameter.get("ds_search").get(0));

        // 테마 콤보
        parameter.get("ds_search").get(0).put("mclassCd", rsEventReq.get(0).get("mclassCd"));
        rsTheme = eventProcessApprvMgntService.selectThemeList(parameter.get("ds_search").get(0));

        //첨부파일 참조일련번호를 얻는다.
        String strEvtFileId = "";
        String strFileId    = "";
        
        if (rsEventReq.size() > 0) {
            Map map = rsEventReq.get(0);
            if (map.get("fileId") != null)
                strEvtFileId =  map.get("fileId").toString();  //필드명이 "refSeq"인 경우임
        }

        //첨부파일 조회 Service 호출
        if (!"".equals(strEvtFileId)) {
            fileEvtList = attachFileService.selectList(strEvtFileId);
        }

        if (rsResult.size() > 0) {
            Map map = rsResult.get(0);
            if (map.get("fileId") != null)
                strFileId =  map.get("fileId").toString();  //필드명이 "refSeq"인 경우임
        }

        //첨부파일 조회 Service 호출
        if (!"".equals(strFileId)) {
            fileList = attachFileService.selectList(strFileId);
        }

        //개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
        accessLogService.readLog(inVar, rsEventReq.size());

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsEventInfo", rsEventReq);
        super.addOutDataSet(mav, "dsProgress", rsProgress);
        super.addOutDataSet(mav, "dsInforeg",  rsInforeg);
        super.addOutDataSet(mav, "dsUtensil",  rsUtensil);
        super.addOutDataSet(mav, "dsResult",  rsResult);
        super.addOutDataSet(mav, "dsThemeOutput", rsTheme);
        super.addOutDataSet(mav, "dsEvtFile", fileEvtList);   //신청정보 첨부파일
        super.addOutDataSet(mav, "dsFile", fileList);         //결과정보 첨부파일

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 이벤트 결과등록 관리(을)를 Insert/Update/Delete 처리한다.
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

        //이벤트 결과등록 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = eventResultRegMgntService.saveList(param.get("ds_form"), param.get("ds_file"));

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_processCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
}
