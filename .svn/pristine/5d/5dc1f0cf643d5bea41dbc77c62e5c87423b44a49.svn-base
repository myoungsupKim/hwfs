package com.hwfs.ls.lcm.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.service.PropertiesService;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lcm.service.FormMgmtService;
import com.hwfs.sc.cmn.service.AttachFileService;

/**
 * 양식서 관리 Controller Class
 *
 * @ClassName FormMgmtController.java
 * @Description FormMgmtController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 28.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 1. 28.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ls/lcm/formMgmt/")
public class FormMgmtController extends DefaultController {

    /** propertiesService */
    @Autowired
    protected PropertiesService propertiesService;

    /** File Attach Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    @Resource(name = "/ls/lcm/formMgmtService")
    private FormMgmtService formMgmtService;

    /**
     * 양식서목록을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("selectFormList.xdo")
    public ModelAndView selectFormList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = formMgmtService.selectFormList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_formList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 양식서 상세내역을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping("selectForm.xdo")
    public ModelAndView selectForm(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> rs = formMgmtService.selectForm(parameter.get("ds_search").get(0));

        // 첨부파일 참조일련번호를 얻는다.
        String strRefSeq = "";
        if (rs != null) {
            strRefSeq = LimsUtil.checkNull(rs.get("refSeq")); //필드명이 "refSeq"인 경우임
            if (!"".equals(strRefSeq)) {
                // 첨부파일 조회 Service 호출
                List<Map> fileList = attachFileService.selectList(strRefSeq);
                super.addOutDataSet(mav, "ds_file", fileList); //첨부파일 정보
            }
        }

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_formList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 첨부파일을 조회 한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping("selectAttachFileList.xdo")
    public ModelAndView selectAttachFileList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        Map<String, Object> parameter = xpDTO.getInVariableMap();

        // 첨부파일 참조일련번호를 얻는다.
        String strRefSeq = "";
        String retrunDataSet = LimsUtil.checkNull(parameter.get("retrunDataSet"), "ds_file");
        List<Map> fileList = null;
        if (!"".equals(LimsUtil.checkNull(parameter.get("refSeq")))) {
            strRefSeq = LimsUtil.checkNull(parameter.get("refSeq")); //필드명이 "refSeq"인 경우임
            if (!"".equals(strRefSeq)) {
                // 첨부파일 조회 Service 호출
                fileList = attachFileService.selectList(strRefSeq);
            }
        }

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutVariable(mav, "fv_retrunDataSet", retrunDataSet);
        super.addOutDataSet(mav, retrunDataSet, fileList); //첨부파일 정보

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 양식서를 저장한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping("saveFormList.xdo")
    public ModelAndView saveFormList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> retVal = formMgmtService.saveFormList(parameter.get("ds_formList"), parameter.get("ds_file"));

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
     * ******************************************* 사용안함 ***********************************
     * 양식서을 저장한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "unused" })
    @RequestMapping("saveFormAttachFileDelete.xdo")
    public ModelAndView saveFormAttachFileDelete(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //String strLimsUploadPath = propertiesService.getString("ls.file.path"); // Lims 파일 저장소
        String strLimsUploadPath = propertiesService.getString("global.filerepository.path")
                + propertiesService.getString("ls.file.path"); // Lims 파일 저장소
        Map<String, Object> retVal = null;

        // 임시저장소에 업로드된 파일을 업무 upload path 에 저장 한다.
        for (int i = 0; i < parameter.get("ds_formList").size(); i++) {
            Map<String, Object> fileUpActionMap = parameter.get("ds_formList").get(0);

            File fInput = null;
            File fOut = null;
            String svrFileName = LimsUtil.checkNull(fileUpActionMap.get("svrFilenm"));
            int copy = 0;

            if (!"".equals(svrFileName)) {
                if (LimsUtil.isExistsFile(strLimsUploadPath + File.separator + svrFileName)) {
                    // 임시저장소 삭제
                    LimsUtil.deleteFile(strLimsUploadPath + File.separator + svrFileName);
                }
                retVal = formMgmtService.saveFormAttachFileDelete(parameter.get("ds_formList").get(0));
            }
        }

        super.addOutDataSet(mav, "ds_retval", retVal);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
