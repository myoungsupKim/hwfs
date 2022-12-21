package com.hwfs.ls.lcm.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.service.PropertiesService;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lcm.service.UserMgmtService;

/**
 * 담당자 관리 Controller Class
 *
 * @ClassName UserMgmtController.java
 * @Description UserMgmtController Class
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
@RequestMapping("/ls/lcm/userMgmt/")
public class UserMgmtController extends DefaultController {

    /** propertiesService */
    @Autowired
    protected PropertiesService propertiesService;

    @Resource(name = "/ls/lcm/userMgmtService")
    private UserMgmtService userMgmtService;

    /**
     * 담당자 리스트를 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectUserMgmtList.xdo")
    public ModelAndView selectUserMgmtList(HttpServletRequest request,
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = userMgmtService.selectUserMgmtList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_userList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 권한별 담당자 리스트를 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectUserList.xdo")
    public ModelAndView selectUserList(HttpServletRequest request,
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = userMgmtService.selectUserList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_userList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 담당자를 저장한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @RequestMapping("saveUserList.xdo")
    public ModelAndView saveUserList(HttpServletRequest request,
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        String realpath = propertiesService.getString("global.imagerepository.path");
        realpath = realpath + propertiesService.getString("ls.file.path")
                + propertiesService.getString("ls.img.sign.upload.path") + File.separator;

        // folder가 없으면 생성
        LimsUtil.makeFolder(realpath);
        Map<String, Object> retVal = userMgmtService.saveUserList(realpath, parameter.get("ds_userList"));

        // XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", retVal.get("procCnt"));
        super.addOutDataSet(mav, "ds_retval", retVal);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 식품연구소 사원을 조회한다.
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked" })
    @RequestMapping("selectHrUserList.xdo")
    public ModelAndView selectHrUserList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        // ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        // XPlatform에서 넘어온 Variable Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = userMgmtService.selectHrUserList(parameter.get("ds_search").get(0));

        // XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_hrUserList", rs);

        // ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
