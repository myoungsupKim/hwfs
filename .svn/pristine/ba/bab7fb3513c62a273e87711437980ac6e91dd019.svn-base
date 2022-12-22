package com.hwfs.fs.fse.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.token.ValidationToken;
import com.hwfs.fs.fse.service.EventPopService;

/**
 * 이벤트 조회 팝업하는 EventPop Controller
 *
 * @ClassName EventPopController.java
 * @Description EventPopController Class
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
@RequestMapping("/fs/fse/eventPop/")
public class EventPopController extends DefaultController {

    /** EventPopService Bean 생성 */
    @Resource(name = "/fs/fse/eventPopService")
    private EventPopService eventPopService;


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
    @RequestMapping("selectEventPopList.xdo")
    public ModelAndView selectEventPopList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

        Map<String, Object> parameter = param.get("ds_search").get(0);
        RecordSet rs = eventPopService.selectEventPopList(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_codeList", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 이벤트 승인 목록을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @ValidationToken
    @SuppressWarnings("unchecked")
    @RequestMapping("selectEventProcessInfoList.xdo")
    public ModelAndView selectEventProcessInfoList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

        Map<String, Object> parameter = param.get("ds_search").get(0);
        RecordSet rs = eventPopService.selectEventProcessInfoList(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_codeList", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 콤보용 코드 목록을 조회한다. (분류, 테마)
     *
     * @param xpDto	
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @RequestMapping("selectCodeList.xdo")
    public ModelAndView selectCodeList(
    		@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        
    	//XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

		//코드 목록을 조회한다. (분류, 테마)
		Map<String, RecordSet> rs = eventPopService.selectCodeList();

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_codeMclass", rs.get("codeMclass"));
		super.addOutDataSet(mav, "ds_codeSclass", rs.get("codeSclass"));

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
}