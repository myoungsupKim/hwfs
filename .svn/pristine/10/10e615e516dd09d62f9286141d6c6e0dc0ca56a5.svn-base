package com.hwfs.ls.ltm.web;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.ltm.service.TestResultInqueryService;
import com.hwfs.sc.cmn.service.AttachFileService;

/**
 * 시험진행 및 결과 조회 Controller Class
 *
 * @ClassName TestResultInqueryController.java
 * @Description TestResultInqueryController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 30.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 30.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ls/ltm/testResultInquery/")
public class TestResultInqueryController extends DefaultController {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    /** AttachFile Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    @Resource(name = "/ls/ltm/testResultInqueryService")
    private TestResultInqueryService testResultInqueryService;

    /**
     * 의뢰목록을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectList.xdo")
    public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = testResultInqueryService.selectList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_testRegList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 접수목록을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectSpecmList.xdo")
    public ModelAndView selectSpecmList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = testResultInqueryService.selectSpecmList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_specmList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 시험항목 목록을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectDetailList.xdo")
    public ModelAndView selectDetailList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = testResultInqueryService.selectDetailList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_testArticleList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 시험일지를 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping("selectTestDiaryList.xdo")
    public ModelAndView selectTestDiaryList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = testResultInqueryService.selectTestDiary(parameter.get("ds_search").get(0));
        RecordSet rs1 = testResultInqueryService.selectTestDiaryMethodList(parameter.get("ds_search").get(0));

        if (!rs.isEmpty()) {
            // 첨부파일 참조 순번조회 하여 첨부파일 정보 가져오기
            String strRefSeq = LimsUtil.checkNull(rs.get(0).get("refSeq"));
            List<Map> fileList = null;
            if (!"".equals(strRefSeq)) {
                fileList = attachFileService.selectList(strRefSeq);
                super.addOutDataSet(mav, "ds_file", fileList);
            }
        }

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_testArticleList", rs);
        super.addOutDataSet(mav, "ds_testDiaryList", rs1);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 성적서 파일명과 파일경로를 구한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectFileInfo.xdo")
    public ModelAndView selectFileInfo(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        Map<String, Object> param = parameter.get("ds_search").get(0);
        
        List<Map<String, Object>> gwDraftAttachList = new ArrayList<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("fileName", LimsUtil.checkNull(param.get("acceptnm")).trim().replaceAll("\\.", "") + ".zip");
        map.put("filePath",
                propertiesService.getString("global.filerepository.path") + propertiesService.getString("ls.file.path") + "/"
                        + propertiesService.getString("ls.inspectrpt.upload.path") + "/" + param.get("svrFileName"));
        gwDraftAttachList.add(map);

        //Json 형식으로 변환하여 outVariable로 반환
        JSONArray jsonList = new JSONArray(gwDraftAttachList);
        addOutDataSet(mav, "fv_attachList", jsonList.toString());

        /*String strFileName = param.get("acceptnm") + ".zip";
        String strFilePath = propertiesService.getString("global.filerepository.path")
                + propertiesService.getString("ls.file.path") +"/"
                + propertiesService.getString("ls.inspectrpt.upload.path") +"/"
                + param.get("reqNum") + ".zip";

        addOutDataSet (mav, "fv_fileName", strFileName);
        addOutDataSet (mav, "fv_filePath", strFilePath);*/

        //결재상신 팝업 임시저장테이블에 저장(20171123 유선미)
        testResultInqueryService.saveGwDraftTemp(param);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 시험일지를 저장한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping("saveList.xdo")
    public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> retVal = testResultInqueryService.saveList(parameter.get("ds_search").get(0),
                parameter.get("ds_testArticleList"), parameter.get("ds_testDiaryList"), parameter.get("ds_file"));

        String strRefSeq = LimsUtil.checkNull(retVal.get("strRefSeq"));
        List<Map> fileList = null;
        if (!"".equals(strRefSeq)) {
            fileList = attachFileService.selectList(strRefSeq);
            super.addOutDataSet(mav, "ds_file", fileList);
        }

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_RefSeq", retVal.get("strRefSeq"));
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));
        super.addOutDataSet(mav, "ds_retval", retVal);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 시험결과 상신 전 검사목적,방법을 등록한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("saveInsptPurpMtod.xdo")
    public ModelAndView saveInsptPurpMtod(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> retVal = testResultInqueryService.saveInsptPurpMtod(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));
        super.addOutDataSet(mav, "ds_retval", retVal);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 검체폐기 정보를 등록한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @RequestMapping("saveDisuseYn.xdo")
    public ModelAndView saveDisuseYn(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> retVal = testResultInqueryService.saveDisuseYn(parameter.get("ds_specmList"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 성적서 발급여부를 변경.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @RequestMapping("saveInspectRptIssueYn.xdo")
    public ModelAndView saveInspectRptIssueYn(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> retVal = testResultInqueryService.saveInspectRptIssueYn(parameter.get("ds_testRegList"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.
     * <pre>
     * - RequestMapping은 .do로 해야 한다.
     * - 상신을 위한 본문은 DB에서 쿼리하여 JSP를 이용하여 동적으로 HTML 본문을 만든다.
     * - JSP 본문 양식은 WEB-INF/jsp에서 관리한다.
     * - 본문 title 파라미터는 공통에서 전달한다.
     * </pre>
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "makeGwDraftContent.do")
    public ModelAndView makeGwDraftContent(HttpServletRequest request, Model model,
            @RequestParam(value = "searchId", required = true) String strId,
            @RequestParam(value = "upjangNm", required = true) String strupjangNm,
            
            @RequestParam(value = "insptPurp", required = true) String strInsptPurp,
            @RequestParam(value = "insptMtod", required = true) String strInsptMtod,
            @RequestParam(value = "fileName", required = true) String strFileName,
            @RequestParam(value = "srvFileName", required = true) String strSrvFileName,
            @RequestParam(value = "attachFileNm", required = false) String strAttachFileNm,
            @RequestParam(value = "limsBigo", required = false) String strLimsBigo,
            @RequestParam(value = "limsAfterProc", required = false) String strLimsAfterProc,
            @RequestParam(value = "draftGubun", required = false) String strDraftGubun,
            @RequestParam(value = "title", required = false, defaultValue = "") String strBodyTitle) throws Exception {

    	
        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        Map<String, Object> parameter = new HashMap<String, Object>();

        logger.info("strId :" + strId);
        logger.info("upjangNm : ", strupjangNm);
        logger.info("strInsptPurp :" + strInsptPurp);
        logger.info("strInsptMtod :" + strInsptMtod);
        logger.info("strAttachFileNm :" + strAttachFileNm);
        logger.info("strLimsBigo :" + strLimsBigo);
        logger.info("strLimsAfterProc :" + strLimsAfterProc);
        logger.info("strDraftGubun :" + strDraftGubun);
        parameter.put("reqNum", strId);
        parameter.put("upjangNm", strupjangNm);
        
        
        
        Record rs = testResultInqueryService.selectReportMst(parameter); // 시험결과 마스터을 조회한다.
        RecordSet rs1 = testResultInqueryService.selectReportDetail(parameter); // 시험결과 상세를 조회한다.

        model.addAttribute("gwDraftMaster", rs);
        model.addAttribute("gwDraftDetail", rs1);
        
        
        strBodyTitle = strBodyTitle.replaceAll("[∮]", "&");        
        model.addAttribute("gwDraftTitle", strBodyTitle);
        model.addAttribute("gwInsptPurp", strInsptPurp);
        model.addAttribute("gwInsptMtod", strInsptMtod);
        model.addAttribute("gwFileName", strFileName);
        model.addAttribute("gwSrvFileName", strSrvFileName);
       // System.out.println("########### strBodyTitle 모르겠어어려워3:"+strBodyTitle);
        strAttachFileNm = strAttachFileNm.replaceAll("[¶]", "\r\n");
        strAttachFileNm = strAttachFileNm.replaceAll("[§]", "=");
        strAttachFileNm = strAttachFileNm.replaceAll("[∮]", "&");
        model.addAttribute("attachFileNm", strAttachFileNm);
        
        strLimsBigo = strLimsBigo.replaceAll("[¶]", "\r\n");
        strLimsBigo = strLimsBigo.replaceAll("[§]", "=");
        strLimsBigo = strLimsBigo.replaceAll("[∮]", "&");
        model.addAttribute("limsBigo", strLimsBigo);

        strLimsAfterProc = strLimsAfterProc.replaceAll("[¶]", "\r\n");
        strLimsAfterProc = strLimsAfterProc.replaceAll("[§]", "=");
        strLimsAfterProc = strLimsAfterProc.replaceAll("[∮]", "&");
        model.addAttribute("limsAfterProc", strLimsAfterProc);
        
        model.addAttribute("draftGubun", strDraftGubun);

        String serverIP = request.getServerName();
        String serverPORT = String.valueOf(request.getServerPort());
        model.addAttribute("gwServerIP", serverIP);
        model.addAttribute("gwServerPORT", serverPORT);

        /*RecordSet rs = testResultInqueryService.selectProposalDtl(parameter); //구매 품의 마스터을 조회한다.
        RecordSet rs2 = testResultInqueryService.selectPoProposalItemDtlList(parameter); //구매 품의 품목 상세를 조회한다.

        logger.info("settleSchdDate :" + rs.get(0).getString("settleSchdDate"));
        //본문을 생성하는 JSP로 정보를 전달하기 위해 Model에 설정한다.
        model.addAttribute("gwDraftInfo", rs.get(0));
        model.addAttribute("gwDraftList", rs2);

        //본문 타이틀 설정
        model.addAttribute("gwDraftTitle", strBodyTitle);*/

        //본문을 생성하는 JSP 호출
        String path = "/gw/ltm/TestResultGwDraft";

        return new ModelAndView(path);
    }

    /**
     * 검체 폐기대상 목록을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectSpecmDisuseList.xdo")
    public ModelAndView selectSpecmDisuseList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = testResultInqueryService.selectSpecmDisuseList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_testRegList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 검체폐기 정보를 일괄 등록한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @RequestMapping("saveDisuseAllYn.xdo")
    public ModelAndView saveDisuseAllYn(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> retVal = testResultInqueryService.saveDisuseAllYn(parameter.get("ds_testRegList"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 서버 사진을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectImgList.xdo")
    public ModelAndView selectImgList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsImgList = testResultInqueryService.selectImgList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsImgeSvrList", rsImgList);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

	/**
	 * 구매 수기전송 데이터를 저장한다.
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("insertSendItem.xdo")
	public ModelAndView insertSendItem(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
	    // ModeAndView를 생성한다.
	    ModelAndView mav = super.createModelAndView();
	
	    // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
	    Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
	
	    Map<String, Object> retVal = testResultInqueryService.insertSendItem(parameter.get("ds_specmList"));
	
	    // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
	    super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));
	
	    // ModelAndView를 설정한다.
	    return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

    /**
     * 결재상신팝업 저장내역 조회
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectGwDraftTemp.xdo")
    public ModelAndView selectGwDraftTemp(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = testResultInqueryService.selectGwDraftTemp(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_search", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

	/**
	 * 결재상신 팝업 임시저장
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
     * @since 20171123
     * @author 유선미
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("saveGwDraftTemp.xdo")
	public ModelAndView saveGwDraftTemp(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
	    // ModeAndView를 생성한다.
	    ModelAndView mav = super.createModelAndView();
	
	    // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
	    Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
	    Map<String, Object> param = parameter.get("ds_search").get(0);
	    
	    int cnt = testResultInqueryService.saveGwDraftTemp(param);
	
	    // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
	    super.addOutVariable(mav, "fv_iProcessCnt", cnt);
	
	    // ModelAndView를 설정한다.
	    return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

    /**
     * 시험진행및결과조회 시험목록을 저장한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("saveResultList.xdo")
    public ModelAndView saveResultList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> retVal = testResultInqueryService.saveResultList(parameter.get("ds_testArticleList"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));
        super.addOutDataSet(mav, "ds_retval", retVal);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}


