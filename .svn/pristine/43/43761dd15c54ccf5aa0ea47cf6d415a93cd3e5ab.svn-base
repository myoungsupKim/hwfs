package com.hwfs.sc.scu.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.scu.service.UserRoleChngService;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

/**
* 사용자의 권한을 변경하는 UserRoleChng Controller
*
* @ClassName UserRoleChngController.java
* @Description UserRoleChngController Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.05.18    김재섭        최초생성
* </pre>
* @author FC종합전산구축 :  COM 김재섭
* @since 2015.05.18
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Controller
@RequestMapping("/sc/scu/userRoleChng/")
public class UserRoleChngController extends DefaultController {

    /** LogService */
    //private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** UserRoleChngService Bean 생성 */
    @Resource(name = "/sc/scu/userRoleChngService")
    private UserRoleChngService userRoleChngService;

    /**
     * 사용자 권한 목록을 조회한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @RequestMapping("selectList.xdo")
    public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, Object> inVar = xpDTO.getInVariableMap();

        //사용자 권한 을(를) 조회한다.
        RecordSet rs = userRoleChngService.selectList(inVar);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 사용자 권한(을)를 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("saveList.xdo")
    public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_master");

        //사용자 권한을(를) 등록, 수정, 삭제 처리한다.
        Long processCnt = userRoleChngService.saveList(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_ChgSrlnum", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 상신 후 instanceId를 저장 한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("saveGwInstanceId.xdo")
    public ModelAndView saveGwInstanceId(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        Map<String, Object> parameter = xpDTO.getInVariableMap();

        //사용자 권한을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = userRoleChngService.saveGwInstanceId(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.
     * 김재섭 요청으로 김민수 개발
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
            @RequestParam(value = "title", required = false, defaultValue = "") String strBodyTitle) throws Exception {

        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("chgSrlnum", strId);
        Record rs = userRoleChngService.selectGwDraftMst(parameter); // 마스터을 조회한다.

        model.addAttribute("gwDraftMaster", rs);
        model.addAttribute("gwDraftTitle", strBodyTitle);

        //본문을 생성하는 JSP 호출
        String path = "/gw/scu/UserRoleChngReqGwDraft";

        return new ModelAndView(path);
    }

}
