package com.hwfs.sm.saa.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sm.saa.service.AccdUpjangMngtService;

/**
 * 사고업장관리하는 AccdUpjangMngt Controller
 *
 * @ClassName AccdUpjangMngtController.java
 * @Description AccdUpjangMngtController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.22    최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최종덕
 * @since 2015.04.22
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sm/saa/accdUpjangMngt/")
public class AccdUpjangMngtController extends DefaultController {

    /** AccdUpjangMngtService Bean 생성 */
    @Resource(name = "/sm/saa/accdUpjangMngtService")
    private AccdUpjangMngtService accdUpjangMngtService;

    /**
     * 사고업장관리 목록을 조회한다.
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

        //조회 조건 파라미터를 얻는다.
        Map <String, Object> inVar = xpDTO.getInVariableMap();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        Map<String, Object> param = parameter.get("ds_search").get(0);
        param.put("maskAuth", inVar.get("maskAuth"));
        
        RecordSet rsGrdlist = null;

        rsGrdlist   = accdUpjangMngtService.selectList(param);

        //개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
        accessLogService.readLog(inVar, rsGrdlist.size());

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsSearchOutput", rsGrdlist);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 사고채권발생보고, 매출 미발생 사유보고에 데이터가 있는지 확인한다
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectAccdList.xdo")
    public ModelAndView selectAccdList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map <String, Object> inVar = xpDTO.getInVariableMap();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //Map<String, Object> param = parameter.get("ds_search").get(0);
        
        
        RecordSet rsGrdlist = null;

        rsGrdlist   = accdUpjangMngtService.selectAccdList(parameter.get("ds_searchDetail").get(0));

        //개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
        accessLogService.readLog(inVar, rsGrdlist.size());

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_searchDetailOut", rsGrdlist);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 사고업장관리(을)를 Insert/Update/Delete 처리한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("saveList.xdo")
    public ModelAndView saveList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

    	//로그인 세션 정보 얻기
    	LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);
    			
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

        //개인정보보호 접근로그를 쌓는다.
        accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"CEO_BRTH_DATE_ENC, ADDR_ENC"}));

        //사고업장관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = accdUpjangMngtService.saveList(param.get("ds_list"), loginDTO);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_processCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
}
