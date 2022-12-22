package com.hwfs.ls.cmn.web;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.hwfs.ls.cmn.service.SlaTestService;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.FaxDTO;
import com.hwfs.sc.cmn.service.FaxService;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;

/**
 * Fax Image Test Controller Class
 *
 * @ClassName FaxTransferTestContoller.java
 * @Description FaxTransferTestContoller Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 23.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 1. 8.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Controller
public class FaxTransferTestContoller extends DefaultController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource(name = "/ls/cmn/slaTestService")
    private SlaTestService slaTestService;

    /** FaxService Bean 생성 */
    @Resource(name = "/sc/cmn/faxService")
    private FaxService faxService;

    @RequestMapping("/ls/cmn/web/faxTransferTest.xdo")
    public ModelAndView faxTransferTest(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
            HttpServletRequest request) throws Exception {
        ModelAndView mav = createModelAndView();

        Map<String, Object> parameter = new HashMap<String, Object>();
        RecordSet rs = slaTestService.faxTransferTest(parameter);

        // root 경로
        String realpath = propertiesService.getString("global.filerepository.path");

        // pdf파일이 생성될 경로
        String realFtPath = realpath + propertiesService.getString("ft.file.path") + File.separator;
        // folder가 없으면 생성
        LimsUtil.makeFolder(realFtPath);

        // css, html, font, 한화직인 경로
        realpath = realpath + propertiesService.getString("ls.file.path")
                + propertiesService.getString("ls.inspectrpt.upload.path") + File.separator;
        // folder가 없으면 생성
        LimsUtil.makeFolder(realpath);

        String strCss = realpath + "inspectRpt.css";
        String htmlFile = realpath + "releaseReqRpt.html";
        String transTitle = "1"; //LimsUtil.checkNull(parameter.get("ds_search").get(0).get("releaseReqCert"));

        String serverIP = request.getServerName();
        String serverPORT = String.valueOf(request.getServerPort());
        String linkPath = request.getScheme() + "://" + serverIP + ":"
                + serverPORT + propertiesService.getString("ls.img.sign.upload.linkpath");
        String linkPathHanwha = request.getScheme() + "://" + serverIP + ":"
                + serverPORT + propertiesService.getString("ls.inspectrpt.upload.linkpath");

        String tmpWhCd = "";
        List<Map<String, Object>> releaseList = new ArrayList<Map<String, Object>>();
        Map<String, Object> tmpRsd = new HashMap<String, Object>();
        Map<String, Object> rsd = new HashMap<String, Object>();
        int rowCnt = 0;
        int retVal = 0;

        if (!rs.isEmpty()) {
            //for (Map<String, Object> rsd : rs) {
            for (int i = 0; i < rs.size(); i++) {
                rsd = new HashMap<String, Object>();
                rsd = rs.get(i);
                if (!LimsUtil.checkNull(rsd.get("whCd")).equals(tmpWhCd)) {
                    if (rowCnt > 0) {
                        // pdf출력
                        retVal = prtFaxPds(realpath, realFtPath, linkPath, linkPathHanwha, strCss, htmlFile, transTitle,
                                releaseList, tmpRsd);
                        if (retVal < 0) {
                            return super.setResultSet(mav, DefaultConsts.ERR_CODE, "Fax발송 오류!");
                        }
                    }

                    releaseList = new ArrayList<Map<String, Object>>();
                    tmpRsd = new HashMap<String, Object>();
                    releaseList.add(rsd);
                    tmpRsd = rsd;
                    tmpWhCd = LimsUtil.checkNull(rsd.get("whCd"));
                } else {
                    releaseList.add(rsd);
                }
                rowCnt++;
            }
        }
        if (rowCnt > 0) {
            // pdf출력
            retVal = prtFaxPds(realpath, realFtPath, linkPath, linkPathHanwha, strCss, htmlFile, transTitle, releaseList, tmpRsd);
            if (retVal < 0) {
                return super.setResultSet(mav, DefaultConsts.ERR_CODE, "Fax발송 오류!");
            }
        }

        return setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * pdf출력 후 Fax발송
     *
     * @param realpath
     * @param realFtPath
     * @param linkPath
     * @param linkPathHanwha
     * @param strCss
     * @param htmlFile
     * @param transTitle
     * @param releaseList
     * @param tmpRsd
     * @return
     * @throws Exception
     */
    public int prtFaxPds(String realpath, String realFtPath, String linkPath, String linkPathHanwha, String strCss,
            String htmlFile, String transTitle, List<Map<String, Object>> releaseList, Map<String, Object> tmpRsd)
                    throws Exception {

        int retVal = 0;
        // pdf 파일 경로 및 파일명 지정
        String createFile = realFtPath + LimsUtil.checkNull(tmpRsd.get("releaseNum")) + "_"
                + LimsUtil.checkNull(tmpRsd.get("whCd")) + ".pdf";

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("realpath", realpath);
        paramMap.put("linkPath", linkPath);
        paramMap.put("linkPathHanwha", linkPathHanwha);
        paramMap.put("createFile", createFile);
        paramMap.put("strCss", strCss);
        paramMap.put("htmlFile", htmlFile);
        paramMap.put("transTitle", transTitle);

        paramMap.put("whCd", LimsUtil.checkNull(tmpRsd.get("whCd")));
        paramMap.put("vdNmLoc", LimsUtil.checkNull(tmpRsd.get("vdNmLoc")));
        paramMap.put("releaseNum", LimsUtil.checkNull(tmpRsd.get("releaseNum")));
        paramMap.put("chamJo", "출고담당자");
        paramMap.put("sendInfo", LimsUtil.checkNull(tmpRsd.get("sendInfo")));
        paramMap.put("releaseDate", LimsUtil.checkNull(tmpRsd.get("releaseDate")));
        paramMap.put("custNm", LimsUtil.checkNull(tmpRsd.get("custNm")));

        paramMap.put("releaseList", releaseList);

        try {
            // pdf 파일 생성
            CreateFaxPdf.createFaxPdf(paramMap);

            // FAX 정보설정
            FaxDTO faxDTO = new FaxDTO();
            faxDTO.setRecipient(
                    "출고증발행-" + LimsUtil.checkNull(tmpRsd.get("releaseNum")) + "_" + LimsUtil.checkNull(tmpRsd.get("vdNmLocNm")));
            faxDTO.setFaxno(LimsUtil.checkNull(tmpRsd.get("faxNo")).replaceAll("[-]", ""));
            faxDTO.setFilename(createFile); // 생성된 pdf full path

            //등록된 사용자 설정
            faxDTO.setUserid(propertiesService.getString("fax.userid"));
            faxDTO.setUserpw(propertiesService.getString("fax.userpw"));

            //FAX 전송을(를) 등록 처리한다.
            retVal = faxService.send(faxDTO);
        } catch (Exception ex) {
            logger.error(ex.getLocalizedMessage());
            retVal = -1;
        }

        return retVal;
    }

}
