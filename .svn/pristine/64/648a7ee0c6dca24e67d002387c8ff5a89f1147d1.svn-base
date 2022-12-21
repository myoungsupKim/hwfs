package com.hwfs.fs.fse.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.fs.fse.service.EventUtensilPopService;
import com.hwfs.fs.fse.service.UtensilPopService;


 /**
 * 사업부 기기/기물 조회 팝업하는 EventUtensilPop Controller
 * 
 * @ClassName EventUtensilPopController.java
 * @Description EventUtensilPopController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.04    김미경        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 김미경
 * @since 2015.06.04
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fse/eventUtensilPop/")
public class EventUtensilPopController extends DefaultController {

	/** EventUtensilPopService Bean 생성 */
	@Resource(name = "/fs/fse/eventUtensilPopService")
	private EventUtensilPopService eventUtensilPopService;


	/**
	 * 사업부 기기/기물 조회 팝업 목록을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		//사업부 기기/기물 조회 팝업 을(를) 조회한다.
        Map<String, Object> parameter = param.get("ds_search").get(0);
        RecordSet rs = eventUtensilPopService.selectList(parameter);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");	
	}
	
	/**
	 * 콤보용 코드 목록을 조회한다. (대분류, 중분류)
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
        
	    //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		//코드 목록을 조회한다. (대분류, 중분류)
        Map<String, Object> parameter = param.get("ds_search").get(0);
		Map<String, RecordSet> rs = eventUtensilPopService.selectCodeList(parameter);
	
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_codeLclass", rs.get("codeLclass"));
		super.addOutDataSet(mav, "ds_codeMclass", rs.get("codeMclass"));
	
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
