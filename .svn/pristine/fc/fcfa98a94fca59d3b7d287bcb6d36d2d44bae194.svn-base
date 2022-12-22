package com.hwfs.ls.lem.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.io.File;
import java.util.HashMap;
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
import com.hwfs.ls.cmn.util.CreateInspectIssuePdf;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lem.service.InspectRptIssueInqueryService;

/**
 * 성적서발급 및 결과 조회 Controller Class
 *
 * @ClassName InspectRptIssueInqueryController.java
 * @Description InspectRptIssueInqueryController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 07.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 07.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ls/lem/inspectRptIssueInquery/")
public class InspectRptIssueInqueryController extends DefaultController {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
    @Resource(name = "/ls/lem/inspectRptIssueInqueryService")
    private InspectRptIssueInqueryService inspectRptIssueInqueryService;

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

        RecordSet rs = inspectRptIssueInqueryService.selectList(parameter.get("ds_search").get(0));

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

        RecordSet rs = inspectRptIssueInqueryService.selectSpecmList(parameter.get("ds_search").get(0));

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

        RecordSet rs = inspectRptIssueInqueryService.selectDetailList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_testArticleList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 성적서재발급 목록을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectInspectRptIssueHistList.xdo")
    public ModelAndView selectInspectRptIssueHistList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = inspectRptIssueInqueryService.selectInspectRptIssueHistList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_inspectRptHistory", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 성적서 미리보기
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectInspectRptPreview.xdo")
    public ModelAndView selectInspectRptPreview(HttpServletRequest request,
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        String realpath = propertiesService.getString("global.filerepository.path");
        realpath = realpath + propertiesService.getString("ls.file.path")
                + propertiesService.getString("ls.inspectrpt.upload.path") + File.separator;
        // folder가 없으면 생성
        LimsUtil.makeFolder(realpath);

        String strCss = realpath + "inspectRpt.css";
        //String htmlFile = realpath + "InspectRptNew.html";
        String createFile = "";
        String removeFileName = "";

        String serverIP = request.getServerName();
        String serverPORT = String.valueOf(request.getServerPort());
        String linkPath = request.getScheme() + "://" + serverIP + ":"
                + serverPORT + propertiesService.getString("ls.img.sign.upload.linkpath");
        String linkPathHanwha = request.getScheme() + "://" + serverIP + ":"
                + serverPORT + propertiesService.getString("ls.inspectrpt.upload.linkpath");

        Map<String, Object> param = parameter.get("ds_search").get(0);
        RecordSet rs = inspectRptIssueInqueryService.selectInsptRptSpecmtList(param);

        // 개인정보보호 접근로그를 쌓는다. 조회조건과 조회 건수
        accessLogService.readLog(param, rs.size());
        
        RecordSet rs1 = null;
        RecordSet rs2 = null;
        RecordSet rs3 = null;

        //////////////////////////////////////////////////////////////////////////////////////////////////////
        // 성적서 만들기
        //////////////////////////////////////////////////////////////////////////////////////////////////////
        if (!rs.isEmpty()) {
            Map<String, Object> paramMap = null;
            for (Map<String, Object> specmInfo : rs) {
                param.put("acceptNum", LimsUtil.checkNull(specmInfo.get("acceptNum")));

                rs1 = inspectRptIssueInqueryService.selectInsptRptTestResultList(param);
                rs2 = inspectRptIssueInqueryService.selectInsptRptTestUserList(param);
                rs3 = inspectRptIssueInqueryService.selectInsptRptTestTechUserList(param);
        		
                String htmlFile = "";
                if ("S".equals(specmInfo.get("inspectRptIssue"))) {
                	htmlFile = realpath + "InspectRptNewShow.html";
                }else{
                	htmlFile = realpath + "InspectRptNew.html";
                }
                
                createFile = realpath + LimsUtil.checkNull(param.get("reqNum")) + "_"
                        + LimsUtil.checkNull(specmInfo.get("acceptNum")) + ".pdf";
                removeFileName = LimsUtil.checkNull(param.get("reqNum")) + "_" + LimsUtil.checkNull(specmInfo.get("acceptNum"))
                        + ".pdf";

logger.debug("##_selectInspectRptPreview linkPath:"+linkPath);
                paramMap = new HashMap<String, Object>();
                paramMap.put("realpath", realpath);
                paramMap.put("linkPath", linkPath);
                paramMap.put("linkPathHanwha", linkPathHanwha);
                paramMap.put("createFile", createFile);
                paramMap.put("strCss", strCss);
                paramMap.put("htmlFile", htmlFile);
                paramMap.put("specmList", specmInfo);
                paramMap.put("testResultList", rs1);
                paramMap.put("testUserList", rs2);
                paramMap.put("testTechUserList", rs3);

                try {
logger.debug("##_startCredatePdf");                	
                    CreateInspectIssuePdf.createPdf(paramMap);
logger.debug("##_endCredatePdf");
                    
                } catch (Exception ex) {
                    return super.setResultSet(mav, DefaultConsts.ERR_CODE, ex.getMessage());
                }
            }

            // 미리보기를 위해 임의 경로로 옮기고 미리보기 창을 닫을때 파일을 삭제한다.
            if (!"".equals(createFile)) {
                String targetpath = propertiesService.getString("global.imagerepository.path");
                targetpath = targetpath + propertiesService.getString("ls.file.path")
                        + propertiesService.getString("ls.inspectrpt.upload.path") + File.separator;
                // folder가 없으면 생성
logger.debug("##_beforeMakeFolder::"+targetpath);
                LimsUtil.makeFolder(targetpath);
logger.debug("##_afterMakeFolder::"+realpath);
                File oriFile = new File(realpath + removeFileName);
                File targetFile = new File(targetpath + removeFileName);
logger.debug("##_afterMakeFile"+removeFileName);
                oriFile.renameTo(targetFile);
logger.debug("##_afterRenameFile");
            }

        }
logger.debug("##_beforeEndModel");
        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }

    /**
     * 성적서 발급
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("saveInspectRptIssue.xdo")
    public ModelAndView saveInspectRptIssue(HttpServletRequest request,
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        String realpath = propertiesService.getString("global.filerepository.path");
        realpath = realpath + propertiesService.getString("ls.file.path")
                + propertiesService.getString("ls.inspectrpt.upload.path") + File.separator;
        // folder가 없으면 생성
        LimsUtil.makeFolder(realpath);

        String strCss = realpath + "inspectRpt.css";
        //String htmlFile = realpath + "InspectRptNew.html";
        String createFile = "";

        String serverIP = request.getServerName();
        String serverPORT = String.valueOf(request.getServerPort());
        String linkPath = request.getScheme() + "://" + serverIP + ":"
                + serverPORT + propertiesService.getString("ls.img.sign.upload.linkpath");
        String linkPathHanwha = request.getScheme() + "://" + serverIP + ":"
                + serverPORT + propertiesService.getString("ls.inspectrpt.upload.linkpath");
logger.debug("##_serverIP::"+serverIP);
logger.debug("##_serverPORT::"+serverPORT);
logger.debug("##_linkPath::"+linkPath);
logger.debug("##_linkPathHanwha::"+linkPathHanwha);

        Map<String, Object> param = parameter.get("ds_search").get(0);
        // 성적서 발행 이력 저장
        Map<String, Object> retVal = inspectRptIssueInqueryService.saveInsptRptIssueHistory(param);
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));
        super.addOutDataSet(mav, "ds_retval", retVal);

        RecordSet rs = inspectRptIssueInqueryService.selectInsptRptSpecmtList(param);

        // 개인정보보호 접근로그를 쌓는다. 조회조건과 조회 건수
        accessLogService.readLog(param, rs.size());

        RecordSet rs1 = null;
        RecordSet rs2 = null;
        RecordSet rs3 = null;
        int publishCnt = 0;

        //////////////////////////////////////////////////////////////////////////////////////////////////////
        // 성적서 만들기
        //////////////////////////////////////////////////////////////////////////////////////////////////////
        if (!rs.isEmpty()) {
            Map<String, Object> paramMap = null;
            for (Map<String, Object> specmInfo : rs) {
                param.put("acceptNum", LimsUtil.checkNull(specmInfo.get("acceptNum")));
                publishCnt = LimsUtil.checkNull(specmInfo.get("publishCnt"), 0);

                rs1 = inspectRptIssueInqueryService.selectInsptRptTestResultList(param);
                rs2 = inspectRptIssueInqueryService.selectInsptRptTestUserList(param);
                rs3 = inspectRptIssueInqueryService.selectInsptRptTestTechUserList(param);

                String htmlFile = "";
                if ("S".equals(specmInfo.get("inspectRptIssue"))) {  
                	htmlFile = realpath + "InspectRptNewShow.html";
                }else{
                	htmlFile = realpath + "InspectRptNew.html";
                }
                
                createFile = realpath + LimsUtil.checkNull(param.get("reqNum")) + "_"
                        + LimsUtil.speciaLettersRemove(LimsUtil.checkNull(specmInfo.get("specmNm"))) + ".pdf";

logger.debug("##_saveInspectRptIssue linkPath:"+linkPath);
                paramMap = new HashMap<String, Object>();
                paramMap.put("realpath", realpath);
                paramMap.put("linkPath", linkPath);
                paramMap.put("linkPathHanwha", linkPathHanwha);
                paramMap.put("createFile", createFile);
                paramMap.put("strCss", strCss);
                paramMap.put("htmlFile", htmlFile);
                paramMap.put("specmList", specmInfo);
                paramMap.put("testResultList", rs1);
                paramMap.put("testUserList", rs2);
                paramMap.put("testTechUserList", rs3);

                try {
logger.debug("##_start createPdf");                	
                    CreateInspectIssuePdf.createPdf(paramMap);
logger.debug("##_end createPdf");
                } catch (Exception ex) {
                    return super.setResultSet(mav, DefaultConsts.ERR_CODE, ex.getMessage());
                }
            }

            // 의뢰번호를 파일명으로 하는 zip 파일을 생성한다.
logger.debug("##_start createZip");            
            LimsUtil.createInsptRptZip(realpath, LimsUtil.checkNull(param.get("reqNum")), publishCnt);
logger.debug("##_end createZip");
logger.debug("##_start deleteFile");
            // pdf파일 삭제
            LimsUtil.deletePdfFile(realpath);
logger.debug("##_start deleteFile");
        }
logger.debug("##_return model");
        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }

    /**
     * 성적서 미리보기 후 오픈경로의 파일을 삭제 한다.
     *
     * @param request
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectInspectRptPreviewClose.xdo")
    public ModelAndView selectInspectRptPreviewClose(HttpServletRequest request,
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        String targetpath = propertiesService.getString("global.imagerepository.path");
        targetpath = targetpath + propertiesService.getString("ls.file.path")
                + propertiesService.getString("ls.inspectrpt.upload.path") + File.separator;

        Map<String, Object> param = parameter.get("ds_search").get(0);
        String targetFile = targetpath + param.get("reqNum") + "_" + param.get("acceptNum") + ".pdf";

        if (LimsUtil.isExistsFile(targetFile)) {
            LimsUtil.deleteFile(targetFile);
        }

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }

}
