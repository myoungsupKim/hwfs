package com.hwfs.ls.lum.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.io.File;
import java.util.HashMap;
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
import com.hwfs.ls.lum.service.EquipMgmtService;
import com.hwfs.sc.cmn.service.AttachFileService;

/**
 * 장비이력과 수리이력 관리 Controller Class
 *
 * @ClassName EquipMgmtController.java
 * @Description EquipMgmtController Class
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
@RequestMapping("/ls/lum/equipMgmt/")
public class EquipMgmtController extends DefaultController {

    /** AttachFile Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    /** propertiesService */
    @Autowired
    protected PropertiesService propertiesService;

    @Resource(name = "/ls/lum/equipMgmtService")
    private EquipMgmtService equipMgmtService;

    /**
     * 장비이력을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping("selectEquipLogList.xdo")
    public ModelAndView selectEquipList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = equipMgmtService.selectEquipLogList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_equipLogList", rs);

        if (!rs.isEmpty()) {
            // 첨부파일 참조 순번조회 하여 첨부파일 정보 가져오기
            Map<String, Object> fileParameter = new HashMap<String, Object>();
            fileParameter.put("equipNum", rs.get(0).getString("equipNum"));
            Map<String, Object> rsEquipLog = equipMgmtService.selectEquipLogRefSeq(fileParameter);
            String strRefSeq = LimsUtil.checkNull(rsEquipLog.get("refSeq"));
            List<Map> fileList = null;
            if (!"".equals(strRefSeq)) {
                fileList = attachFileService.selectList(strRefSeq);
                super.addOutDataSet(mav, "ds_file", fileList);
            }

            // 수리이력 조회
            Map<String, Object> subParameter = new HashMap<String, Object>();
            subParameter.put("equipNum", rs.get(0).getString("equipNum"));
            RecordSet rs1 = equipMgmtService.selectRparLogList(subParameter);
            // XPlatform으로 넘겨줄 Dataset을 설정한다.
            super.addOutDataSet(mav, "ds_rparLogList", rs1);
        }

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 특정 장비이력에 대한 수리이력을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping("selectRparList.xdo")
    public ModelAndView selectRparList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        // 첨부파일 참조 순번조회 하여 첨부파일 정보 가져오기
        Map<String, Object> rsEquipLog = equipMgmtService.selectEquipLogRefSeq(parameter.get("ds_search").get(0));
        String strRefSeq = LimsUtil.checkNull(rsEquipLog.get("refSeq"));
        List<Map> fileList = null;
        if (!"".equals(strRefSeq)) {
            fileList = attachFileService.selectList(strRefSeq);
            super.addOutDataSet(mav, "ds_file", fileList);
        }

        RecordSet rs = equipMgmtService.selectRparLogList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_rparLogList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 장비이력과 수리이력을 저장한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping("saveEquipList.xdo")
    public ModelAndView saveEquipList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        String realpath = propertiesService.getString("global.imagerepository.path");
        realpath = realpath + propertiesService.getString("ls.file.path")
                + propertiesService.getString("ls.img.equip.upload.path") + File.separator;

        // folder가 없으면 생성
        LimsUtil.makeFolder(realpath);
        Map<String, Object> retVal = equipMgmtService.saveEquipLogList(realpath, parameter.get("ds_equipLogList"),
                parameter.get("ds_rparLogList"), parameter.get("ds_file"));

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
     * 특정 장비이력에 대한 수리이력을 저장한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @RequestMapping("saveRparList.xdo")
    public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        String pEquipNum = LimsUtil.checkNull(parameter.get("ds_search").get(0).get("equipNum"));
        int procCnt = equipMgmtService.saveRparLogList(pEquipNum, parameter.get("ds_rparLogList"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 특정 장비이력의 첨부파일 삭제 한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unused" })
    @RequestMapping("saveFormAttachFileDelete.xdo")
    public ModelAndView saveFormAttachFileDelete(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        String strLimsUploadPath = propertiesService.getString("global.filerepository.path")
                + propertiesService.getString("ls.file.path"); // Lims 파일 저장소
        Map<String, Object> retVal = null;
        Map<String, Object> serviceParam = new HashMap<String, Object>();

        String pEquipNum = LimsUtil.checkNull(parameter.get("ds_search").get(0).get("equipNum"));

        File fInput = null;
        File fOut = null;
        String svrFileName3 = LimsUtil.checkNull(parameter.get("ds_search").get(0).get("svrFilenm3"));
        int copy = 0;

        if (!"".equals(svrFileName3)) {
            if (LimsUtil.isExistsFile(strLimsUploadPath + File.separator + svrFileName3)) {
                // 임시저장소 삭제
                LimsUtil.deleteFile(strLimsUploadPath + File.separator + svrFileName3);
            }
            serviceParam.put("equipNum", pEquipNum);
            retVal = equipMgmtService.deleteEquipLogFileAppend(serviceParam);
        }

        super.addOutDataSet(mav, "ds_retval", retVal);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
