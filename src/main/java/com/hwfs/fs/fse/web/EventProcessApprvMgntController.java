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
import com.hwfs.sc.cmn.service.AttachFileService;

/**
 * 이벤트 등록 관리자 승인하는 EventProcessApprvMgnt Controller
 *
 * @ClassName EventProcessApprvMgntController.java
 * @Description EventProcessApprvMgntController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.14    최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최종덕
 * @since 2015.04.14
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fse/eventProcessApprvMgnt/")
public class EventProcessApprvMgntController extends DefaultController {

    /** EventProcessApprvMgntService Bean 생성 */
    @Resource(name = "/fs/fse/eventProcessApprvMgntService")
    private EventProcessApprvMgntService eventProcessApprvMgntService;

    /** File Attach Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    /**
     * 이벤트 목록을 조회한다.
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

        //분류 콤보
        rsCbo = eventProcessApprvMgntService.selectCboList(parameter.get("ds_search").get(0));
        if(rsCbo.size() > 0 ){
        	parameter.get("ds_search").get(0).put("mclassCd", rsCbo.get(0).get("mclassCd"));
        }
        
        //테마 콤보
        rsTheme = eventProcessApprvMgntService.selectThemeList(parameter.get("ds_search").get(0));

        //신청목록
        rsGrdlist = eventProcessApprvMgntService.selectList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsCboOutput", rsCbo);
        super.addOutDataSet(mav, "dsThemeOutput", rsTheme);
        super.addOutDataSet(mav, "dsSearchOutput", rsGrdlist);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

   /**
    * 이벤트 마스터 정보 및 진행정보 조회한다.
    *
    * @param xpDTO
    * @return
    * @throws Exception
    */
   @SuppressWarnings("unchecked")
   @RequestMapping("selectMasterInfo.xdo")
   public ModelAndView selectMasterInfo(
           @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

       //XPLATFORM에 결과를 전달할 객체 생성
       ModelAndView mav = super.createModelAndView();

       //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
       Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

       RecordSet rsEventMst     = null;
       RecordSet rsMstProgress  = null;
       RecordSet rsTheme        = null;
       RecordSet rsUtensil      = null;
       List<Map> fileList       = null;

       //Master  정보
       rsEventMst    = eventProcessApprvMgntService.selectEventMst(parameter.get("ds_search").get(0));

       //Master  진행정보(진행절차)
       rsMstProgress = eventProcessApprvMgntService.selectMstProgress(parameter.get("ds_search").get(0));

       //테마 콤보
       parameter.get("ds_search").get(0).put("mclassCd", rsEventMst.get(0).get("mclassCd"));
       rsTheme = eventProcessApprvMgntService.selectThemeList(parameter.get("ds_search").get(0));
       
       //Master 기기/포장제 정보
       rsUtensil = eventProcessApprvMgntService.selectMstUtensil(parameter.get("ds_search").get(0));

       //Master 첨부파일 참조일련번호를 얻는다.
       String strRefSeq = "";
       if (rsEventMst.size() > 0) {
           Map map = rsEventMst.get(0);
           if (map.get("fileIdMst") != null)
               strRefSeq =  map.get("fileIdMst").toString();  //필드명이 "refSeq"인 경우임
       }

       //첨부파일 조회 Service 호출
       if (!"".equals(strRefSeq)) {
           fileList = attachFileService.selectList(strRefSeq);
       }

       //개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
       //accessLogService.readLog(inVar, rsEventMst.size());       
       
       //XPlatform으로 넘겨줄 Dataset을 설정한다.
       super.addOutDataSet(mav, "dsEventInfo", rsEventMst);
       super.addOutDataSet(mav, "dsProgress", rsMstProgress);
       super.addOutDataSet(mav, "dsThemeOutput", rsTheme);
       super.addOutDataSet(mav, "dsUtensilMst", rsUtensil);
       super.addOutDataSet(mav, "dsFileMst", fileList);   //첨부파일 정보

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
       List<Map> fileList    = null;

       // 신청정보
       rsEventReq = eventProcessApprvMgntService.selectEventReq(parameter.get("ds_search").get(0));

       // 진행정보
       rsProgress = eventProcessApprvMgntService.selectProgress(parameter.get("ds_search").get(0));

       // 기기정보
       rsInforeg  = eventProcessApprvMgntService.selectInforeg(parameter.get("ds_search").get(0));

       // 사업장 기기정보
       rsUtensil  = eventProcessApprvMgntService.selectUpjangutensil(parameter.get("ds_search").get(0));

       // 테마 콤보
       parameter.get("ds_search").get(0).put("mclassCd", rsEventReq.get(0).get("mclassCd"));
       rsTheme = eventProcessApprvMgntService.selectThemeList(parameter.get("ds_search").get(0));

       //첨부파일 참조일련번호를 얻는다.
       String strRefSeq = "";
       if (rsEventReq.size() > 0) {
           Map map = rsEventReq.get(0);
           if (map.get("fileId") != null)
               strRefSeq =  map.get("fileId").toString(); //필드명이 "refSeq"인 경우임
       }

       //첨부파일 조회 Service 호출
       if(!"".equals(strRefSeq)) {
           fileList = attachFileService.selectList(strRefSeq);
       }

       //개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
       accessLogService.readLog(inVar, rsEventReq.size());

       //XPlatform으로 넘겨줄 Dataset을 설정한다.
       super.addOutDataSet(mav, "dsEventInfo", rsEventReq);
       super.addOutDataSet(mav, "dsProgress", rsProgress);
       super.addOutDataSet(mav, "dsInforeg",  rsInforeg);
       super.addOutDataSet(mav, "dsUtensil",  rsUtensil);
       super.addOutDataSet(mav, "dsThemeOutput", rsTheme);
       super.addOutDataSet(mav, "dsFile", fileList);   //첨부파일 정보

       //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
       return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
   }

    /**
     * 이벤트 master 정보(을)를 Insert/Update/Delete 처리한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("saveMstList.xdo")
    public ModelAndView saveMstList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

        //이벤트 master 정보을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = eventProcessApprvMgntService.saveMstList(param.get("ds_form"));

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_processCnt", processCnt);
        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_processCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 이벤트 신청 정보(을)를 Insert/Update/Delete 처리한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("saveReqList.xdo")
    public ModelAndView saveReqList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

        //이벤트 신청 정보을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = eventProcessApprvMgntService.saveReqList(param.get("ds_form"));

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_processCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
}
