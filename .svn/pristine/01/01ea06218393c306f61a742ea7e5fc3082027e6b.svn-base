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
import com.hwfs.cmn.token.ValidationToken;
import com.hwfs.fs.fse.service.EventMstRegService;
import com.hwfs.sc.cmn.service.AttachFileService;


/**
 * 이벤트 Master 등록관리하는 EventMstReg Controller
 *
 * @ClassName EventMstRegController.java
 * @Description EventMstRegController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.11    남기빈        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 남기빈
 * @since 2015.03.11
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fse/eventMstReg/")
public class EventMstRegController extends DefaultController {

    /** EventMstRegService Bean 생성 */
    @Resource(name = "/fs/fse/eventMstRegService")
    private EventMstRegService eventMstRegService;
    
    /** File Attach Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;    

    
    /**
     * 이벤트 Master 목록을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
    @SuppressWarnings("unchecked")
    @RequestMapping("selectEventList.xdo")
    public ModelAndView selectEventList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsCbo = null;
        RecordSet rsTheme = null;
        RecordSet rsEventList = null;

        //분류 콤보
        rsCbo = eventMstRegService.selectCboList(parameter.get("ds_search").get(0));
        if(rsCbo.size() > 0 ){
        	parameter.get("ds_search").get(0).put("mclassCd", rsCbo.get(0).get("mclassCd"));
        }
        
        //테마 콤보
        rsTheme = eventMstRegService.selectThemeList(parameter.get("ds_search").get(0));

        //이벤트 목록
        rsEventList = eventMstRegService.selectEventList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsCboOutput", rsCbo);
        super.addOutDataSet(mav, "dsThemeOutput", rsTheme);
        super.addOutDataSet(mav, "dsEventOutput", rsEventList);


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
        RecordSet rsTheme = eventMstRegService.selectThemeList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsThemeListOutput", rsTheme);


        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 이벤트 정보를 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping("selectList.xdo")
    public ModelAndView selectList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        //Map <String, Object> inVar = xpDTO.getInVariableMap();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsSelect         = null;
        RecordSet rsSelectProgress = null;
        RecordSet rsTheme          = null;
        RecordSet rsUtensil        = null;
        List<Map> fileList         = null;

        //이벤트 master 정보
        rsSelect = eventMstRegService.selectList(parameter.get("ds_search").get(0));

        //진행절차 목록
        rsSelectProgress= eventMstRegService.selectProgress(parameter.get("ds_search").get(0));

        //기기/포장제 목록
        rsUtensil = eventMstRegService.selectUtensilList(parameter.get("ds_search").get(0));

        // 테마 콤보
        parameter.get("ds_search").get(0).put("mclassCd", rsSelect.get(0).get("mclassCd"));
        rsTheme = eventMstRegService.selectThemeList(parameter.get("ds_search").get(0));

        //첨부파일 참조일련번호를 얻는다.
        String strRefSeq = "";
        if (rsSelect.size() > 0) {
            Map map = rsSelect.get(0);
            if (map.get("fileId") != null)
                strRefSeq =  map.get("fileId").toString();  //필드명이 "refSeq"인 경우임
        }

        //첨부파일 조회 Service 호출
        if (!"".equals(strRefSeq)) {
            fileList = attachFileService.selectList(strRefSeq);
        }

        //개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
        //accessLogService.readLog(inVar, rsSelect.size());       
        
        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsSelectOutput", rsSelect);
        super.addOutDataSet(mav, "dsSelectProgressOutput", rsSelectProgress);
        super.addOutDataSet(mav, "dsThemeOutput", rsTheme);
        super.addOutDataSet(mav, "dsUtensil", rsUtensil);
        super.addOutDataSet(mav, "dsFile", fileList);   //첨부파일 정보

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 이벤트 Master 등록관리(을)를 Insert/Update/Delete 처리한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("saveList.xdo")
    public ModelAndView saveList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //로그인 세션 정보 얻기
//      LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

        //이벤트 Master 등록관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = eventMstRegService.saveList(param.get("ds_list"), param.get("ds_form"), param.get("ds_progress"), param.get("ds_utensil"), param.get("ds_file"));
        
        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_processCnt", processCnt);

        
        RecordSet rsEventList = null;

        //이벤트 목록
        rsEventList = eventMstRegService.selectEventList(param.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsEventOutput", rsEventList);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 이벤트 Master 등록관리(을)를 Insert/Update/Delete 처리한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("deleteList.xdo")
    public ModelAndView deleteList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

        //이벤트 Master 등록관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = eventMstRegService.deleteList(param.get("ds_eventMst"));
        
        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_processCnt", processCnt);

        RecordSet rsEventList = null;

        //이벤트 목록
        rsEventList = eventMstRegService.selectEventList(param.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsEventOutput", rsEventList);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 이벤트 LV1 조회.(Tree) 목록을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
    @SuppressWarnings("unchecked")
    @RequestMapping("selectLevel1.xdo")
    public ModelAndView selectLevel1(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsLevel1 = null;

        //이벤트 목록
        rsLevel1 = eventMstRegService.selectLevel1(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "level1", rsLevel1);


        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
}
